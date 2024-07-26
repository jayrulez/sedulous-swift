import Foundation

/// Specifies alpha blending mode.
enum BlendMode: UInt8 {
    /// No blending.
    case opaque
    /// Premultiplied alpha blending.
    case alphaBlend
    /// Additive alpha blending.
    case additive
    /// Non premultiplied alpha blending.
    case nonPremultiplied
}
