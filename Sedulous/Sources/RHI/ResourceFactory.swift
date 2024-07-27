import Foundation

/// Factory for creating GPU device resources.
protocol ResourceFactory: AnyObject {
    var graphicsContext: GraphicsContext { get }

    func createCommandQueue(queueType: CommandQueueType) -> CommandQueue
    func createGraphicsPipeline(description: inout GraphicsPipelineDescription) -> GraphicsPipelineState
    func createComputePipeline(description: inout ComputePipelineDescription) -> ComputePipelineState
    func createRaytracingPipeline(description: inout RaytracingPipelineDescription) -> RaytracingPipelineState
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

    func createRaytracingPipeline(description: inout RaytracingPipelineDescription) -> RaytracingPipelineState {
        graphicsContext.validationLayer?.createRaytracingPipelineValidation(&description)
        return createRaytracingPipelineInternal(description: &description)
    }

    func createTexture(description: inout TextureDescription, debugName: String? = nil) -> Texture {
        var samplerState = SamplerStates.linearWrap
        let texture = createTexture(data: nil, description: &description, samplerState: &samplerState)
        texture.name = debugName
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
        texture.name = debugName
        return texture
    }

    func createTexture(data: [DataBox]? = nil, description: inout TextureDescription, samplerState: inout SamplerStateDescription, debugName: String? = nil) -> Texture {
        graphicsContext.validationLayer?.createTextureValidation(data ?? [], description: &description, samplerState: &samplerState)
        let texture = createTextureInternal(data: data, description: &description, samplerState: &samplerState)
        texture.name = debugName
        return texture
    }

    func createBuffer(description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        let buffer = createBuffer(data: nil, description: &description)
        buffer.name = debugName
        return buffer
    }

    func createBuffer<T: Any>(_ data: [T], description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        var data = data
        return data.withUnsafeMutableBytes { dataPtr in
            let buffer = createBuffer(data: dataPtr.baseAddress!, description: &description)
            buffer.name = debugName
            return buffer
        }
    }

    func createBuffer<T: Any>(data: inout T, description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        let buffer = withUnsafePointer(to: &data) {
            createBuffer(data: UnsafeRawPointer($0), description: &description)
        }
        buffer.name = debugName
        return buffer
    }

    func createBuffer(data: UnsafeRawPointer? = nil, description: inout BufferDescription, debugName: String? = nil) -> Buffer {
        graphicsContext.validationLayer?.createBufferValidation(data!, description: &description)
        let buffer = createBufferInternal(data: data, description: &description)
        buffer.name = debugName
        return buffer
    }

    func createShader(description: inout ShaderDescription) -> Shader {
        graphicsContext.validationLayer?.createShaderValidation(&description)
        return createShaderInternal(description: &description)
    }

    func createSamplerState(description: inout SamplerStateDescription) -> SamplerState {
        graphicsContext.validationLayer?.createSamplerStateValidation(&description)
        return createSamplerStateInternal(description: &description)
    }

    func createFrameBuffer(width: UInt, height: UInt, colorTargetPixelFormat: PixelFormat = .r8g8b8a8_UNorm, depthTargetPixelFormat: PixelFormat = .d24_UNorm_S8_UInt, debugName: String? = nil) -> FrameBuffer {
        var textureDescription = TextureDescription(
            format: colorTargetPixelFormat,
            width: width,
            height: height,
            depth: 1,
            arraySize: 1,
            faces: 1,
            flags: [.shaderResource, .renderTarget],
            cpuAccess: .none,
            mipLevels: 1,
            type: .texture2D,
            usage: .default,
            sampleCount: .none
        )

        let rTColorTarget = createTexture(description: &textureDescription, debugName: debugName.map { "\($0)_Color" })

        textureDescription = TextureDescription(
            format: depthTargetPixelFormat,
            width: width,
            height: height,
            depth: 1,
            arraySize: 1,
            faces: 1,
            flags: .depthStencil,
            cpuAccess: .none,
            mipLevels: 1,
            type: .texture2D,
            usage: .default,
            sampleCount: .none
        )

        let rTDepthTarget = createTexture(description: &textureDescription, debugName: debugName.map { "\($0)_Depth" })

        let depthAttachment = FrameBufferAttachment(texture: rTDepthTarget, mipSlice: 0, arraySlice: 1)
        let colorsAttachment = [FrameBufferAttachment(texture: rTColorTarget, mipSlice: 0, arraySlice: 1)]

        return createFrameBuffer(depthTarget: depthAttachment, colorTargets: colorsAttachment)
    }

    func createFrameBuffer(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool = true) -> FrameBuffer {
        return createFrameBufferInternal(depthTarget: depthTarget, colorTargets: colorTargets, disposeAttachments: disposeAttachments)
    }

    func createResourceLayout(description: inout ResourceLayoutDescription) -> ResourceLayout {
        graphicsContext.validationLayer?.createResourceLayoutValidation(&description)
        return createResourceLayoutInternal(description: &description)
    }

    func createResourceSet(description: inout ResourceSetDescription) -> ResourceSet {
        graphicsContext.validationLayer?.createResourceSetValidation(&description)
        return createResourceSetInternal(description: &description)
    }

    // Abstract methods that need to be implemented by the conforming class
    func createCommandQueueInternal(queueType: CommandQueueType) -> CommandQueue
    func createGraphicsPipelineInternal(description: inout GraphicsPipelineDescription) -> GraphicsPipelineState
    func createComputePipelineInternal(description: inout ComputePipelineDescription) -> ComputePipelineState
    func createRaytracingPipelineInternal(description: inout RaytracingPipelineDescription) -> RaytracingPipelineState
    func createTextureInternal(data: [DataBox]?, description: inout TextureDescription, samplerState: inout SamplerStateDescription) -> Texture
    func createBufferInternal(data: UnsafeRawPointer?, description: inout BufferDescription) -> Buffer
    func createQueryHeap(description: inout QueryHeapDescription) -> QueryHeap
    func createShaderInternal(description: inout ShaderDescription) -> Shader
    func createSamplerStateInternal(description: inout SamplerStateDescription) -> SamplerState
    func createFrameBufferInternal(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool) -> FrameBuffer
    func createResourceLayoutInternal(description: inout ResourceLayoutDescription) -> ResourceLayout
    func createResourceSetInternal(description: inout ResourceSetDescription) -> ResourceSet
    func getTextureFromNativePointerInternal(_ texturePointer: UnsafeRawPointer, description: inout TextureDescription) -> Texture
}
