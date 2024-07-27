import Foundation

/// Texture type.
public enum TextureType: UInt8 {
    /// Represent a 2D texture.
    case texture2D
    /// Represent a 2D texture array.
    case texture2DArray
    /// Represent a 1D texture.
    case texture1D
    /// Represent a 1D texture array.
    case texture1DArray
    /// Represent a Cubemap texture.
    case textureCube
    /// Represent a TextureCube array.
    case textureCubeArray
    /// Represent a 3D texture.
    case texture3D
}
