import Foundation

/// Performs primitive-based rendering, creates resources, handles system-level variables, adjusts gamma ramp levels, and creates shaders.
public protocol GraphicsContext: AnyObject {
    /// The rate at which the GPU timestamp counter increments.
    var timestampFrequency: UInt64 { get set }
    
    /// Gets or sets the resource factory.
    var factory: ResourceFactory { get set }
    
    /// Gets the backend type (DirectX, OpenGL ...)
    var backendType: GraphicsBackend { get }
    
    /// Gets the capabilities of this graphics context.
    var capabilities: GraphicsContextCapabilities { get }
    
    /// Gets or sets a value indicating the size in bytes of the texture uploader.
    var defaultTextureUploaderSize: UInt64 { get set }
    
    /// Gets or sets a value indicating the size in bytes of the buffer uploader.
    var defaultBufferUploaderSize: UInt64 { get set }
    
    /// Gets the default Sampler state used when there is a missing sampler in a resource set.
    var defaultSampler: SamplerState? { get }
    
    /// Gets the graphics validation layer pointer.
    var validationLayer: ValidationLayer? { get set }
    
    /// Gets a value indicating whether validation layer is enabled or disabled.
    var isValidationLayerEnabled: Bool { get }
    
    /// Initialize the graphics context to be used in a compute shader.
    func createDevice(validationLayer: ValidationLayer?)
    
    /// Initialize the swapchain.
    func createSwapChain(description: SwapChainDescription) -> SwapChain
    
    /// Fill the buffer with a data array.
    func updateBufferData<T: ContiguousBytes>(_ buffer: Buffer, data: [T], destinationOffsetInBytes: UInt)
    
    /// Fill the buffer with a data array.
    func updateBufferData<T: ContiguousBytes>(_ buffer: Buffer, data: [T], count: UInt, destinationOffsetInBytes: UInt)
    
    /// Fill the buffer with a data array.
    func updateBufferData<T>(_ buffer: Buffer, data: inout T, destinationOffsetInBytes: UInt)
    
    /// Fill the buffer from a pointer.
    func updateBufferData(_ buffer: Buffer, source: UnsafeRawPointer, sourceSizeInBytes: UInt, destinationOffsetInBytes: UInt)
    
    /// Fill the texture with a data array.
    func updateTextureData<T: ContiguousBytes>(_ texture: Texture, data: [T], destinationOffsetInBytes: UInt)
    
    /// Fill the texture with a data array.
    func updateTextureData<T: ContiguousBytes>(_ texture: Texture, data: [T], count: UInt, destinationOffsetInBytes: UInt)
    
    /// Fill the texture with a data array.
    func updateTextureData<T>(_ texture: Texture, data: inout T, destinationOffsetInBytes: UInt)
    
    /// Fill the texture from a pointer.
    func updateTextureData(_ texture: Texture, source: UnsafeRawPointer, sourceSizeInBytes: UInt, subResource: UInt)
    
    /// Maps a buffer or texture into a CPU-accessible data region.
    func mapMemory(resource: GraphicsResource, mode: MapMode, subResource: UInt) -> MappedResource
    
    /// Invalidates a previously-mapped data region for the given buffer or texture.
    func unmapMemory(resource: GraphicsResource, subResource: UInt)
    
    /// Generate mipmapping texture levels.
    func generateTextureMipmapping(_ texture: Texture) -> Bool
    
    /// Sync the current buffer data in the copy queue. Internal function used in the upload buffer strategy.
    func syncUpcopyQueue()
    
    /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
    func dispose()
    
    /// Create the default sampler.
    func createDefaultSampler()
}

public extension GraphicsContext {
    var isValidationLayerEnabled: Bool {
        return validationLayer != nil
    }
    
    func createDevice(validationLayer: ValidationLayer? = nil) {
        self.validationLayer = validationLayer
        createDeviceInternal()
        createDefaultSampler()
    }
    
    func updateBufferData<T: ContiguousBytes>(_ buffer: Buffer, data: [T], destinationOffsetInBytes: UInt = 0) {
        let dataSizeInBytes = UInt(data.count * MemoryLayout<T>.stride)
        data.withUnsafeBytes { ptr in
            updateBufferData(buffer, source: ptr.baseAddress!, sourceSizeInBytes: dataSizeInBytes, destinationOffsetInBytes: destinationOffsetInBytes)
        }
    }
    
    func updateBufferData<T: ContiguousBytes>(_ buffer: Buffer, data: [T], count: UInt, destinationOffsetInBytes: UInt = 0) {
        let dataSizeInBytes = count * UInt(MemoryLayout<T>.stride)
        data.withUnsafeBytes { ptr in
            updateBufferData(buffer, source: ptr.baseAddress!, sourceSizeInBytes: dataSizeInBytes, destinationOffsetInBytes: destinationOffsetInBytes)
        }
    }
    
    func updateBufferData<T>(_ buffer: Buffer, data: inout T, destinationOffsetInBytes: UInt = 0) {
        let sizeInBytes = UInt(MemoryLayout<T>.stride)
        withUnsafePointer(to: &data) { ptr in
            updateBufferData(buffer, source: ptr, sourceSizeInBytes: sizeInBytes, destinationOffsetInBytes: destinationOffsetInBytes)
        }
    }
    
    func updateTextureData<T: ContiguousBytes>(_ texture: Texture, data: [T], destinationOffsetInBytes: UInt = 0) {
        let dataSizeInBytes = UInt(data.count * MemoryLayout<T>.stride)
        data.withUnsafeBytes { ptr in
            updateTextureData(texture, source: ptr.baseAddress!, sourceSizeInBytes: dataSizeInBytes, subResource: destinationOffsetInBytes)
        }
    }
    
    func updateTextureData<T: ContiguousBytes>(_ texture: Texture, data: [T], count: UInt, destinationOffsetInBytes: UInt = 0) {
        let dataSizeInBytes = count * UInt(MemoryLayout<T>.stride)
        data.withUnsafeBytes { ptr in
            updateTextureData(texture, source: ptr.baseAddress!, sourceSizeInBytes: dataSizeInBytes, subResource: destinationOffsetInBytes)
        }
    }
    
    func updateTextureData<T>(_ texture: Texture, data: inout T, destinationOffsetInBytes: UInt = 0) {
        let sizeInBytes = UInt(MemoryLayout<T>.stride)
        withUnsafePointer(to: &data) { ptr in
            updateTextureData(texture, source: ptr, sourceSizeInBytes: sizeInBytes, subResource: destinationOffsetInBytes)
        }
    }
    
    func syncUpcopyQueue() {
        // Default implementation does nothing.
    }
    
    func dispose() {
        defaultSampler?.dispose()
        dispose(disposing: true)
    }
    
    func createDefaultSampler() {
        if defaultSampler == nil {
            var samplerStateDescription = SamplerStateDescription.default
            samplerStateDescription.addressU = .wrap
            samplerStateDescription.addressV = .wrap
            samplerStateDescription.addressW = .wrap
            defaultSampler = factory.createSamplerState(description: &samplerStateDescription)
        }
    }
    
    // MARK: Abstract methods to be implemented by conforming classes
    func createDeviceInternal() {
        fatalError("createDeviceInternal() must be implemented by conforming classes.")
    }
    
    func updateBufferData(buffer: Buffer, source: UnsafeRawPointer, sourceSizeInBytes: UInt, destinationOffsetInBytes: UInt) {
        fatalError("updateBufferData(source:sourceSizeInBytes:destinationOffsetInBytes:) must be implemented by conforming classes.")
    }
    
    func createSwapChain(description: SwapChainDescription) -> SwapChain {
        fatalError("createSwapChain(description:) must be implemented by conforming classes.")
    }
    
    func updateTextureData(texture: Texture, source: UnsafeRawPointer, sourceSizeInBytes: UInt, subResource: UInt) {
        fatalError("updateTextureData(source:sourceSizeInBytes:subResource:) must be implemented by conforming classes.")
    }
    
    func mapMemory(resource: GraphicsResource, mode: MapMode, subResource: UInt) -> MappedResource {
        fatalError("mapMemory(resource:mode:subResource:) must be implemented by conforming classes.")
    }
    
    func unmapMemory(resource: GraphicsResource, subResource: UInt) {
        fatalError("unmapMemory(resource:subResource:) must be implemented by conforming classes.")
    }
    
    func generateTextureMipmapping(texture: Texture) -> Bool {
        fatalError("generateTextureMipmapping(texture:) must be implemented by conforming classes.")
    }
    
    func dispose(disposing: Bool) {
        fatalError("dispose(disposing:) must be implemented by conforming classes.")
    }
}
