import Foundation

/// Specifies polygon culling mode.
public enum CullMode: UInt8, Sendable {
    /// Always draw all triangles.
    case none = 1
    /// Do not draw triangles that are front-facing.
    case front
    /// Do not draw triangles that are back-facing.
    case back
}
