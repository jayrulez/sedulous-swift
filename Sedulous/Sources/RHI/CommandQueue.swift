import Foundation

/// A pool of `CommandBuffer`.
public protocol CommandQueue {
    /// The command buffer array size.
    static var commandBufferArraySize: Int { get }

    /// A string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }

    /// Gets the next `CommandBuffer`.
    ///
    /// - Returns: The `CommandBuffer`.
    func commandBuffer() -> CommandBuffer

    /// Submits a `CommandBuffer` list to be executed by the GPU.
    func submit()

    /// Waits for all command buffers to be executed.
    func waitIdle()
}

public extension CommandQueue {
    static var commandBufferArraySize: Int {
        return 64
    }
}
