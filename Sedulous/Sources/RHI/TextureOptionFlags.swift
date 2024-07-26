import Foundation

/// Identifies expected texture use during rendering.
enum TextureOptionFlags: UInt8 {
    /// The default value.
    case none
    /// Specifies a textureCube access.
    case textureCube
}
