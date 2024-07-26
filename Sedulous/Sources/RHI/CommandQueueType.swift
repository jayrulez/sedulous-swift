import Foundation

/// Specifies the elements type of a CommandQueue.
enum CommandQueueType: Int {
    /// Specifies a command buffer that the GPU can execute. A direct command list doesn't inherit any GPU state.
    case graphics = 0
    /// Specifies a command buffer for computing.
    case compute = 2
    /// Specifies a command buffer for copying (drawing).
    case copy = 3
}
