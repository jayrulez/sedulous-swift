import Foundation

/// Factory for creating GPU device resources.
public protocol ResourceFactory: AnyObject {
    var graphicsContext: GraphicsContext { get }

    func createCommandQueue(queueType: CommandQueueType) -> CommandQueue
    func createGraphicsPipeline(description: inout GraphicsPipelineDescription) -> GraphicsPipelineState
    func createComputePipeline(description: inout ComputePipelineDescription) -> ComputePipelineState
    func createTexture(description: inout TextureDescription, debugName: String?) -> Texture
    func getTextureFromNativePointer(_ texturePointer: UnsafeRawPointer, description: inout TextureDescription) -> Texture
    func createTexture(data: [DataBox], description: inout TextureDescription, debugName: String?) -> Texture
    func createTexture(data: [DataBox], description: inout TextureDescription, samplerState: inout SamplerStateDescription, debugName: String?) -> Texture
    func createBuffer(description: inout BufferDescription, debugName: String?) -> Buffer
    func createBuffer<T: Any>(_ data: [T], description: inout BufferDescription, debugName: String?) -> Buffer
    func createBuffer<T: Any>(data: inout T, description: inout BufferDescription, debugName: String?) -> Buffer
    func createBuffer(data: UnsafeRawPointer, description: inout BufferDescription, debugName: String?) -> Buffer
    func createQueryHeap(description: inout QueryHeapDescription) -> QueryHeap
    func createShader(description: inout ShaderDescription) -> Shader
    func createSamplerState(description: inout SamplerStateDescription) -> SamplerState
    func createFrameBuffer(width: UInt, height: UInt, colorTargetPixelFormat: PixelFormat, depthTargetPixelFormat: PixelFormat, debugName: String?) -> FrameBuffer
    func createFrameBuffer(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool) -> FrameBuffer
    func createResourceLayout(description: inout ResourceLayoutDescription) -> ResourceLayout
    func createResourceSet(description: inout ResourceSetDescription) -> ResourceSet
}

/// Default implementations for the ResourceFactory protocol.
extension ResourceFactory {
    
    func createCommandQueue(queueType: CommandQueueType = .graphics) -> CommandQueue {
        graphicsContext.validationLayer?.createCommandQueueValidation(queueType: queueType)
        return createCommandQueueInternal(queueType: queueType)
    }
    
    func createGraphicsPipeline(description: inout GraphicsPipelineDescription) -> GraphicsPipelineState {
        graphicsContext.validationLayer?.createGraphicsPipelineValidation(description: &description)
        return createGraphicsPipelineInternal(description: &description)
    }

    func createComputePipeline(description: inout ComputePipelineDescription) -> ComputePipelineState {
        graphicsContext.validationLayer?.createComputePipelineValidation(description: &description)
        return createComputePipelineInternal(description: &description)
    }

    func createTexture(description: inout TextureDescription, debugName: String? = nil) -> Texture {
        var samplerState = SamplerStates.linearWrap
        let texture = createTexture(data: nil, description: &description, samplerState: &samplerState)
        texture.name = debugName ?? .init()
        return texture
    }

    func getTextureFromNativePointer(_ texturePointer: UnsafeRawPointer, description: inout TextureDescription) -> Texture {
        if texturePointer == UnsafeRawPointer(bitPattern: 0) {
            graphicsContext.validationLayer?.notify(label: "Sedulous", message: "Texture pointer cannot be nil in getTextureFromNativePointer()")
        }
        return getTextureFromNativePointerInternal(texturePointer, description: &description)
    }

    func createTexture(data: [DataBox]? = nil, description: inout TextureDescription, debugName: String? = nil) -> Texture {
        var samplerState = SamplerStates.linearWrap
        let texture = createTexture(data: data, description: &description, samplerState: &samplerState)
        texture.name = debugName ?? .init()
        return texture
    }

    func createTexture(data: [DataBox]? = nil, description: inout TextureDescription, samplerState: inout SamplerStateDescription, debugName: String? = nil) -> Texture {
        graphicsContext.validationLayer?.createTextureValidation(data: data ?? [], description: &description, samplerState: &samplerState)
        let texture = createTextureInternal(data: data, description: &description, samplerState: &samplerState)
        texture.name = debugName ?? .init()
        return texture
    }

    func createBuffer(description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        let buffer = createBuffer(data: nil, description: &description)
        buffer.name = debugName ?? .init()
        return buffer
    }

    func createBuffer<T: Any>(_ data: [T], description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        var data = data
        return data.withUnsafeMutableBytes { dataPtr in
            let buffer = createBuffer(data: dataPtr.baseAddress!, description: &description)
            buffer.name = debugName ?? .init()
            return buffer
        }
    }

    func createBuffer<T: Any>(data: inout T, description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        let buffer = withUnsafePointer(to: &data) {
            createBuffer(data: UnsafeRawPointer($0), description: &description)
        }
        buffer.name = debugName ?? .init()
        return buffer
    }

    func createBuffer(data: UnsafeRawPointer? = nil, description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        graphicsContext.validationLayer?.createBufferValidation(data: data!, description: &description)
        let buffer = createBufferInternal(data: data, description: &description)
        buffer.name = debugName ?? .init()
        return buffer
    }

    func createShader(description: inout ShaderDescription) -> Shader {
        graphicsContext.validationLayer?.createShaderValidation(description: &description)
        return createShaderInternal(description: &description)
    }

    func createSamplerState(description: inout SamplerStateDescription) -> SamplerState {
        graphicsContext.validationLayer?.createSamplerStateValidation(description: &description)
        return createSamplerStateInternal(description: &description)
    }

    func createFrameBuffer(width: UInt, height: UInt, colorTargetPixelFormat: PixelFormat = .R8G8B8A8_UNorm, depthTargetPixelFormat: PixelFormat = .D24_UNorm_S8_UInt, debugName: String? = nil) -> FrameBuffer {
        var textureDescription = TextureDescription(
            type: .texture2D,
            format: colorTargetPixelFormat,
            width: width,
            height: height,
            depth: 1,
            arraySize: 1,
            faces: 1,
            flags: [.shaderResource, .renderTarget],
            cpuAccess: .none,
            mipLevels: 1,
            usage: .default,
            sampleCount: .none
        )

        let rTColorTarget = createTexture(description: &textureDescription, debugName: debugName.map { "\($0)_Color" })

        textureDescription = TextureDescription(
            type: .texture2D,
            format: depthTargetPixelFormat,
            width: width,
            height: height,
            depth: 1,
            arraySize: 1,
            faces: 1,
            flags: .depthStencil,
            cpuAccess: .none,
            mipLevels: 1,
            usage: .default,
            sampleCount: .none
        )

        let rTDepthTarget = createTexture(description: &textureDescription, debugName: debugName.map { "\($0)_Depth" })

        let depthAttachment = FrameBufferAttachment.init(attachedTexture: rTDepthTarget, mipSlice: 0, arraySlice: 1)
        let colorsAttachment = [FrameBufferAttachment.init(attachedTexture: rTColorTarget, mipSlice: 0, arraySlice: 1)]

        return createFrameBuffer(depthTarget: depthAttachment, colorTargets: colorsAttachment)
    }

    func createFrameBuffer(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool = true) -> FrameBuffer {
        return createFrameBufferInternal(depthTarget: depthTarget, colorTargets: colorTargets, disposeAttachments: disposeAttachments)
    }

    func createResourceLayout(description: inout ResourceLayoutDescription) -> ResourceLayout {
        graphicsContext.validationLayer?.createResourceLayoutValidation(description: &description)
        return createResourceLayoutInternal(description: &description)
    }

    func createResourceSet(description: inout ResourceSetDescription) -> ResourceSet {
        graphicsContext.validationLayer?.createResourceSetValidation(description: &description)
        return createResourceSetInternal(description: &description)
    }

    // Abstract methods that need to be implemented by the conforming class
    func createCommandQueueInternal(queueType: CommandQueueType) -> CommandQueue { fatalError("Not implemented.") }
    func createGraphicsPipelineInternal(description: inout GraphicsPipelineDescription) -> GraphicsPipelineState { fatalError("Not implemented.") }
    func createComputePipelineInternal(description: inout ComputePipelineDescription) -> ComputePipelineState { fatalError("Not implemented.") }
    func createTextureInternal(data: [DataBox]?, description: inout TextureDescription, samplerState: inout SamplerStateDescription) -> Texture { fatalError("Not implemented.") }
    func createBufferInternal(data: UnsafeRawPointer?, description: inout BufferDescription) -> Buffer { fatalError("Not implemented.") }
    func createQueryHeap(description: inout QueryHeapDescription) -> QueryHeap { fatalError("Not implemented.") }
    func createShaderInternal(description: inout ShaderDescription) -> Shader { fatalError("Not implemented.") }
    func createSamplerStateInternal(description: inout SamplerStateDescription) -> SamplerState { fatalError("Not implemented.") }
    func createFrameBufferInternal(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool) -> FrameBuffer { fatalError("Not implemented.") }
    func createResourceLayoutInternal(description: inout ResourceLayoutDescription) -> ResourceLayout { fatalError("Not implemented.") }
    func createResourceSetInternal(description: inout ResourceSetDescription) -> ResourceSet { fatalError("Not implemented.") }
    func getTextureFromNativePointerInternal(_ texturePointer: UnsafeRawPointer, description: inout TextureDescription) -> Texture { fatalError("Not implemented.") }
}
