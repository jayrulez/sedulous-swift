import Foundation

/// Specifies texture addressing mode.
enum AddressMode: UInt8 {
    /// Point/nearest neighbor filtering, clamped texture coordinates.
    case pointClamp
    /// Point/nearest neighbor filtering, wrapped texture coordinates.
    case pointWrap
    /// Bilinear filtering, clamped texture coordinates.
    case linearClamp
    /// Bilinear filtering, wrapped texture coordinates.
    case linearWrap
    /// Anisotropic filtering, clamped texture coordinates.
    case anisotropicClamp
    /// Anisotropic filtering, wrapped texture coordinates.
    case anisotropicWrap
}