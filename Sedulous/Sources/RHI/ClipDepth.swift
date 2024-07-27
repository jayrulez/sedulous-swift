import Foundation

/// Define the type of depth in the clip space depth.
public enum ClipDepth: UInt8 {
    /// The depth in clip space is in the [0, 1] range.
    case zeroToOne
    /// The depth in clip space is in the [-1, 1] range.
    case negativeOneToOne
}
