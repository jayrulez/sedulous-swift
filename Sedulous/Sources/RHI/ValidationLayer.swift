import Foundation

// Define TRACE for enabling trace notifications
#if canImport(os)
import os.log
#endif

public typealias NotifyAction = (String, String, ValidationLayer.Severity) -> Void

/// The graphics validation layer.
public class ValidationLayer {
    /// The supported notify methods.
    public enum NotifyMethod {
        /// Validation layer throws exceptions.
        case exceptions
        /// Validation layer trace info.
        case trace
        /// Validation layer fires events.
        case events
    }

    /// Severity enumerate.
    public enum Severity {
        /// Error severity.
        case error
        /// Warning severity.
        case warning
        /// The information severity.
        case information
    }

    /// Pointer to Notify function.
    private var notifyAction: NotifyAction

    public func notify(label: String, message: String, severity: Severity = .error)
    {
        self.notifyAction(label, message, .error);
    }

    /// Event that allow to obtain the error messages if NotifyMethod is set to Events.
    public var error: ((Severity, String) -> Void)?

    /// Initializes a new instance of the `ValidationLayer` class.
    /// - Parameter method: The notify method `NotifyMethod`, exception by default.
    public init(method: NotifyMethod = .exceptions) {
        switch method {
        case .exceptions:
            self.notifyAction = ValidationLayer.notifyException
        case .trace:
            self.notifyAction = ValidationLayer.notifyTrace
        case .events:
            self.notifyAction = ValidationLayer.notifyEvent
        }
    }

    /// Initializes a new instance of the `ValidationLayer` class.
    /// - Parameter function: The callback function called for every error detection.
    public init(function: @escaping NotifyAction) {
        self.notifyAction = function
    }

    /// Creates a command queue validation layer.
    /// - Parameter queueType: The queue type.
    public func createCommandQueueValidation(queueType: CommandQueueType) {
        if queueType < .graphics || queueType > .copy {
            notifyInternal(message: "Invalid queue type value, Graphics, Compute and Copy are the only valid values.")
        }
    }

    /// Creates a graphic pipeline validation.
    /// - Parameter description: The graphic pipeline description.
    public func createGraphicsPipelineValidation(description: inout GraphicsPipelineDescription) {
        if description.outputs.colorAttachments == nil && description.outputs.depthAttachment == nil {
            notifyInternal(message: "A GraphicsPipeline must contain an output description.")
        }
    }

    /// Creates a compute pipeline validation layer.
    /// - Parameter description: The compute pipeline description.
    public func createComputePipelineValidation(description: inout ComputePipelineDescription) {
        // Uncomment if needed
        // if description.shaderDescription == nil {
        //     notifyInternal(message: "The compute shader cannot be null in a ComputePipeline.")
        // }
    }

    /// Creates a texture validation layer.
    /// - Parameters:
    ///   - data: The texture data.
    ///   - description: The texture description.
    ///   - samplerState: The texture sampler state.
    public func createTextureValidation(data: [DataBox], description: inout TextureDescription, samplerState: inout SamplerStateDescription) {
        if description.width == 0 || description.height == 0 || description.depth == 0 {
            notifyInternal(message: "Width, Height, and Depth must be non-zero.")
        }
        if description.faces > 1 && description.type != .textureCube && description.type != .textureCubeArray {
            notifyInternal(message: "Number of faces could be > 1 for a texture cube and texture cube array type.")
        }
        if description.arraySize > 1 && description.type != .texture1DArray && description.type != .texture2DArray && description.type != .textureCubeArray {
            notifyInternal(message: "Array size could be > 1 for a non texture array type.")
        }
        if [.r24G8_Typeless, .d24_UNorm_S8_UInt, .r32G8X24_Typeless, .d32_Float_S8X24_UInt].contains(description.format) && !description.flags.contains(.depthStencil) {
            notifyInternal(message: "The PixelFormat can only be used in a Texture with DepthStencil flag.")
        }
        if [.texture1D, .texture1DArray].contains(description.type) && description.height > 1 {
            notifyInternal(message: "Height of a Texture1D or Texture1DArray must be 1")
        }
    }

    /// Creates the buffer validation layer.
    /// - Parameters:
    ///   - data: The buffer data.
    ///   - description: The buffer description.
    public func createBufferValidation(data: UnsafeRawPointer, description: inout BufferDescription) {
        if description.flags.contains(.bufferStructured) || description.flags.contains(.unorderedAccess) {
            if description.structureByteStride == 0 {
                notifyInternal(message: "Structured Buffer must have a non-zero StructureByteStride value.")
            }
            if description.flags.contains(.vertexBuffer) || description.flags.contains(.indexBuffer) {
                notifyInternal(message: "Structured Buffer cannot also be a VertexBuffer or IndexBuffer.")
            }
        } else if description.structureByteStride != 0 {
            notifyInternal(message: "Non-structured Buffers must have a StructureByteStride of zero.")
        }
        if description.flags.contains(.constantBuffer) && description.sizeInBytes % 16 != 0 {
            notifyInternal(message: "ConstantBuffers size must be a multiple of 16 bytes.")
        }
    }

    /// Creates a shader validation layer.
    /// - Parameter description: The shader description.
    public func createShaderValidation(description: inout ShaderDescription) {
        if description.entryPoint.isEmpty {
            notifyInternal(message: "The EntryPoint cannot be null or empty.")
        }
        if description.shaderBytes.isEmpty {
            notifyInternal(message: "The shader bytes cannot be zero.")
        }
    }

    /// Creates the sampler state validation layer.
    /// - Parameter description: The sampler state description.
    public func createSamplerStateValidation(description: inout SamplerStateDescription) {
        if description.maxAnisotropy > 16 {
            notifyInternal(message: "Out of range, the maximum value for Anisotropy is 16.")
        }
    }

    /// Creates a frame buffer validation.
    /// - Parameters:
    ///   - depthTarget: The depth frame buffer.
    ///   - colorTargets: The color frame buffers.
    ///   - disposeAttachments: If the attachments should be disposed.
    public func createFrameBufferValidation(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool) {
        if colorTargets.isEmpty {
            notifyInternal(message: "A frameBuffer must contain at least one colorTarget attachment")
        }
    }

    /// Creates the resource layout validation.
    /// - Parameter description: The resource layout description.
    public func createResourceLayoutValidation(description: inout ResourceLayoutDescription) {
        // Implement as needed
    }

    /// Creates the resource set validation.
    /// - Parameter description: The resource set description.
    public func createResourceSetValidation(description: inout ResourceSetDescription) {
        // Implement as needed
    }

    /// Updates the buffer data.
    /// - Parameters:
    ///   - inRenderPass: If the operation is made inside a render pass.
    ///   - sourceSizeInBytes: The source buffer size in bytes.
    public func updateBufferData(inRenderPass: Bool, sourceSizeInBytes: UInt32) {
        if inRenderPass {
            notifyInternal(message: "UpdateBufferData operation is not allowed inside a renderPass.")
        }
        if sourceSizeInBytes == 0 {
            notifyInternal(message: "SourceSizeInBytes must be non-zero.")
        }
    }

    /// Validation of the copy buffer operation.
    /// - Parameters:
    ///   - inRenderPass: If the operation is made inside a render pass.
    ///   - sizeInBytes: The size in bytes of the buffer.
    public func copyBufferDataTo(inRenderPass: Bool, sizeInBytes: UInt32) {
        if inRenderPass {
            notifyInternal(message: "CopyBufferDataTo operation is not allowed inside a renderPass.")
        }
        if sizeInBytes == 0 {
            notifyInternal(message: "SizeInBytes must be non-zero.")
        }
    }

    /// Validation of the copy texture data operation.
    /// - Parameter inRenderPass: If the operation is made inside a render pass.
    public func copyTextureDataTo(inRenderPass: Bool) {
        if inRenderPass {
            notifyInternal(message: "CopyBufferDataTo operation is not allowed inside a renderPass.")
        }
    }

    /// Validation of CommandBuffer.SetGraphicsPipelineState.
    /// - Parameter inRenderPass: If the operation is made inside a render pass.
    public func setGraphicsPipelineState(inRenderPass: Bool) {
        if !inRenderPass {
            notifyInternal(message: "SetGraphicsPipelineState operation is not allowed outside a renderPass.")
        }
    }

    /// Validation of CommandBuffer.SetResourceSet.
    /// - Parameters:
    ///   - inRenderPass: If the operation is made inside a render pass.
    ///   - hasComputePipeline: If the compute pipeline is bound.
    public func setResourceSet(inRenderPass: Bool, hasComputePipeline: Bool) {
        if !hasComputePipeline && !inRenderPass {
            notifyInternal(message: "SetResourceSet operation is not allowed outside a renderPass.")
        }
    }

    /// Validation of CommandBuffer.SetVertexBuffer.
    /// - Parameter inRenderPass: If the operation is made inside a render pass.
    public func setVertexBuffer(inRenderPass: Bool) {
        if !inRenderPass {
            notifyInternal(message: "SetVertexBuffer operation is not allowed outside a renderPass.")
        }
    }

    /// Validation of CommandBuffer.SetVertexBuffers.
    /// - Parameters:
    ///   - inRenderPass: If the operation is made inside a render pass.
    ///   - buffers: The buffers.
    ///   - offsets: The offsets.
    public func setVertexBuffers(inRenderPass: Bool, buffers: [Buffer], offsets: [Int]) {
        if !inRenderPass {
            notifyInternal(message: "SetVertexBuffers operation is not allowed outside a renderPass.")
        }
        if buffers.count != offsets.count {
            notifyInternal(message: "SetVertexBuffers: If offsets array is specified, it must match the buffers array length.")
        }
    }

    /// Validation of CommandBuffer.SetIndexBuffer.
    /// - Parameter inRenderPass: If the operation is made inside a render pass.
    public func setIndexBuffer(inRenderPass: Bool) {
        if !inRenderPass {
            notifyInternal(message: "SetIndexBuffer operation is not allowed outside a renderPass.")
        }
    }

    private func notifyEvent(owner: String, message: String, severity: Severity) -> Void  {
        let fullMessage = "A \(owner) error was encountered: \(message)"
        error?(severity, fullMessage)
    }

    private func notifyTrace(owner: String, message: String, severity: Severity) -> Void  {
        let fullMessage = "A \(owner) error was encountered: \(message)"
        #if canImport(os)
        os_log("%@", fullMessage)
        #else
        print(fullMessage)
        #endif
    }

    private func notifyException(owner: String, message: String, severity: Severity) -> Void {
        let fullMessage = "A \(owner) error was encountered: \(message)"
        switch severity {
        case .information:
            #if canImport(os)
            os_log("%@", fullMessage)
            #else
            print(fullMessage)
            #endif
        case .warning:
            #if canImport(os)
            os_log("%@", fullMessage)
            #else
            print("Warning: \(fullMessage)")
            #endif
        case .error:
            fatalError(fullMessage)
        }
    }

    private func notifyInternal(message: String) -> Void  {
        notifyAction("Sedulous", message, .error)
    }
}
