import Foundation

/// RGB or alpha blending operation.
public enum BlendOperation: UInt8, Sendable {
    /// Add source 1 and source 2.
    case add = 1
    /// Subtract source 1 from source 2.
    case subtract
    /// Subtract source 2 from source 1.
    case reverseSubtract
    /// Find the minimum of source 1 and source 2.
    case min
    /// Find the maximum of source 1 and source 2.
    case max
}
