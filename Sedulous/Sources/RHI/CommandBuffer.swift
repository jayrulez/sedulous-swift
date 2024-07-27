import Foundation

/// A command buffer stores commands until the buffer is committed for execution by the GPU.
/// CommandBuffers are transient single-use objects and do not support reuse.
public protocol CommandBuffer {
    /// Available states for a command buffer.
    enum CommandBufferState {
        /// Before Begin has been called or after the reset method.
        case initial
        /// Between Begin and End. The command buffer is in a state where it can record commands.
        case recording
        /// After End, the command buffer is in a state where it has finished recording commands and can be committed.
        case executable
        /// After commit, the command buffer is in a state where it is waiting to be executed by the command queue.
        case committed
    }
    
    /// Gets or sets the state of this command buffer.
    var state: CommandBufferState { get set }
    
    /// Gets or sets a string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }
    
    /// Gets the generic graphics context.
    var graphicsContext: GraphicsContext { get }
    
    /// Set the initialize state for this command buffer.
    /// This function must be called before other graphics commands can be issued.
    func begin()
    
    /// Completes the command buffer.
    func end()
    
    /// Reset the command buffer to the initial state.
    func reset()
    
    /// Set an array of vertex buffers to the input-assembler stage.
    func setVertexBuffers(_ buffers: [Buffer])
    
    /// Set buffers to the input-assembler stage.
    func setVertexBuffer(slot: UInt, buffer: Buffer, offset: UInt)
    
    /// Set an array of buffers to the input-assembler stage.
    func setVertexBuffers(_ buffers: [Buffer], offsets: [Int]?)
    
    /// Set an array of index buffers to the input-assembler stage.
    func setIndexBuffer(buffer: Buffer, format: IndexFormat, offset: UInt)
    
    /// Set scissor rectangles in a specific slot.
    func setScissorRectangles(_ rectangles: [Rectangle])
    
    /// Set a viewport in a specific slot.
    func setViewports(_ viewports: [Viewport])
    
    /// Sets a resource barrier for a texture.
    func resourceBarrierUnorderedAccessView(_ buffer: Buffer)
    
    /// Sets a resource barrier for a texture.
    func resourceBarrierUnorderedAccessView(_ texture: Texture)
    
    /// Sets the graphics pipeline state object for this command buffer.
    func setGraphicsPipelineState(_ pipeline: GraphicsPipelineState)
    
    /// Sets the compute pipeline state object for this command buffer.
    func setComputePipelineState(_ pipeline: ComputePipelineState)
    
    /// Sets the raytracing pipeline state object for this command buffer.
    func setRaytracingPipelineState(_ pipeline: RaytracingPipelineState)
    
    /// Set the active resource set for the given index.
    func setResourceSet(_ resourceSet: ResourceSet, index: UInt, constantBufferOffsets: [UInt]?)
    
    /// Begin a render pass.
    func beginRenderPass(description: inout RenderPassDescription)
    
    /// End a render pass.
    func endRenderPass()
    
    /// Fill the buffer with a data array.
    func updateBufferData<T: ContiguousBytes>(_ buffer: Buffer, data: [T], destinationOffsetInBytes: UInt)
    
    /// Fill the buffer with a data array.
    func updateBufferData<T: ContiguousBytes>(_ buffer: Buffer, data: [T], count: UInt, destinationOffsetInBytes: UInt)
    
    /// Fill the buffer with a data array.
    func updateBufferData<T>(_ buffer: Buffer, data: inout T, destinationOffsetInBytes: UInt)
    
    /// Fill the buffer from a pointer.
    func updateBufferData(_ buffer: Buffer, source: UnsafeRawPointer, sourceSizeInBytes: UInt, destinationOffsetInBytes: UInt)
    
    /// Copy this buffer in the destination buffer.
    func copyBufferDataTo(_ origin: Buffer, destination: Buffer, sizeInBytes: UInt, sourceOffset: UInt, destinationOffset: UInt)
    
    /// Copies all subresources from this texture to another texture.
    func copyTextureDataTo(_ source: Texture, destination: Texture)
    
    /// Copies one subresource from this texture to another texture.
    func copyTextureDataTo(_ source: Texture, destination: Texture, mipLevel: UInt, arrayLayer: UInt)
    
    /// Copies a region from this texture to another texture.
    func copyTextureDataTo(_ source: Texture, sourceX: UInt, sourceY: UInt, sourceZ: UInt, sourceMipLevel: UInt, sourceBasedArrayLayer: UInt, destination: Texture, destinationX: UInt, destinationY: UInt, destinationZ: UInt, destinationMipLevel: UInt, destinationBasedArrayLayer: UInt, width: UInt, height: UInt, depth: UInt, layerCount: UInt)
    
    /// Copies all subresources from this texture to another texture with format conversion and preparing to present in swapchain.
    func blit(_ source: Texture, destination: Texture)
    
    /// Copies all subresources from this texture to another texture with format conversion and preparing to present in swapchain.
    func blit(_ source: Texture, sourceX: UInt, sourceY: UInt, sourceZ: UInt, sourceMipLevel: UInt, sourceBasedArrayLayer: UInt, destination: Texture, destinationX: UInt, destinationY: UInt, destinationZ: UInt, destinationMipLevel: UInt, destinationBasedArrayLayer: UInt, layerCount: UInt)
    
    /// Draw non-indexed, non-instanced primitives.
    func draw(vertexCount: UInt, startVertexLocation: UInt)
    
    /// Draw non-indexed, instanced primitives.
    func drawInstanced(vertexCountPerInstance: UInt, instanceCount: UInt, startVertexLocation: UInt, startInstanceLocation: UInt)
    
    /// Draw instanced, GPU-generated primitives.
    func drawInstancedIndirect(argBuffer: Buffer, offset: UInt, drawCount: UInt, stride: UInt)
    
    /// Draw indexed, non-instanced primitives.
    func drawIndexed(indexCount: UInt, startIndexLocation: UInt, baseVertexLocation: UInt)
    
    /// Draw indexed, instanced primitives.
    func drawIndexedInstanced(indexCountPerInstance: UInt, instanceCount: UInt, startIndexLocation: UInt, baseVertexLocation: UInt, startInstanceLocation: UInt)
    
    /// Draw indexed, instanced, GPU-generated primitives.
    func drawIndexedInstancedIndirect(argBuffer: Buffer, offset: UInt, drawCount: UInt, stride: UInt)
    
    /// Execute commands in a compute shader from a thread group.
    func dispatch(groupCountX: UInt, groupCountY: UInt, groupCountZ: UInt)
    
    /// Commits this command buffer to the command queue waiting to be executed on GPU after submit.
    func commit()
    
    /// Execute a command list over one or more thread groups.
    func dispatchIndirect(argBuffer: Buffer, offset: UInt)
    
    /// Generates mipmaps for the given texture.
    func generateMipmaps(_ texture: Texture)
    
    /// Marks the beginning of a section of event code.
    func beginDebugMarker(_ label: String)
    
    /// Marks the end of a section of event code.
    func endDebugMarker()
    
    /// Marks a single point of execution in code.
    func insertDebugMarker(_ label: String)
    
    /// Write a device timestamp into a query heap.
    func writeTimestamp(heap: QueryHeap, index: UInt)
    
    /// Begins a GPU query.
    func beginQuery(heap: QueryHeap, index: UInt)
    
    /// Ends a GPU query.
    func endQuery(heap: QueryHeap, index: UInt)
    
    /// Perform a bottom-level acceleration structure build on the GPU.
    func buildRaytracingAccelerationStructure(blas: BottomLevelASDescription) -> BottomLevelAS
    
    /// Perform a top-level acceleration structure build on the GPU.
    func buildRaytracingAccelerationStructure(tlas: TopLevelASDescription) -> TopLevelAS
    
    /// Refit a top-level acceleration structure build on the GPU.
    func updateRaytracingAccelerationStructure(tlas: inout TopLevelAS, newDescription: TopLevelASDescription)
    
    /// Launch threads of a ray generation shader.
    func dispatchRays(_ description: DispatchRaysDescription)
    
    /// Clear all cached values of this command buffer.
    func clearCache()
}

public extension CommandBuffer {
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
    
    func dispatch1D(threadCountX: UInt, groupSizeX: UInt = 64) {
        dispatch(groupCountX: (threadCountX + groupSizeX - 1) / groupSizeX, groupCountY: 1, groupCountZ: 1)
    }
    
    func dispatch2D(threadCountX: UInt, threadCountY: UInt, groupSizeX: UInt = 8, groupSizeY: UInt = 8) {
        dispatch(groupCountX: (threadCountX + groupSizeX - 1) / groupSizeX, groupCountY: (threadCountY + groupSizeY - 1) / groupSizeY, groupCountZ: 1)
    }
    
    func dispatch3D(threadCountX: UInt, threadCountY: UInt, threadCountZ: UInt, groupSizeX: UInt, groupSizeY: UInt, groupSizeZ: UInt) {
        dispatch(groupCountX: (threadCountX + groupSizeX - 1) / groupSizeX, groupCountY: (threadCountY + groupSizeY - 1) / groupSizeY, groupCountZ: (threadCountZ + groupSizeZ - 1) / groupSizeZ)
    }
    
    func clearCache() {
        // Clear cached pipeline states here
    }
}
