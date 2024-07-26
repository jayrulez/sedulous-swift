import Foundation

/// Struct representing an indirect dispatch of a Command Buffer.
struct IndirectDispatchArgs {
    /// The thread group X size.
    var threadGroupCountX: UInt32
    
    /// The thread group Y size.
    var threadGroupCountY: UInt32
    
    /// The thread group Z size.
    var threadGroupCountZ: UInt32
    
    /// Initializes a new instance of the `IndirectDispatchArgs` struct.
    /// - Parameters:
    ///   - threadGroupCountX: The thread group X size.
    ///   - threadGroupCountY: The thread group Y size.
    ///   - threadGroupCountZ: The thread group Z size.
    init(threadGroupCountX: UInt32, threadGroupCountY: UInt32, threadGroupCountZ: UInt32) {
        self.threadGroupCountX = threadGroupCountX
        self.threadGroupCountY = threadGroupCountY
        self.threadGroupCountZ = threadGroupCountZ
    }
}
