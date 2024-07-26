import Foundation

/// Filtering options during texture sampling.
enum TextureFilter: UInt8 {
    /// Use point sampling for minification, magnification, and mip-level sampling.
    case minPointMagPointMipPoint
    /// Use point sampling for minification and magnification; use linear interpolation for mip-level sampling.
    case minPointMagPointMipLinear
    /// Use point sampling for minification; use linear interpolation for magnification; use point sampling for mip-level sampling.
    case minPointMagLinearMipPoint
    /// Use point sampling for minification; use linear interpolation for magnification and mip-level sampling.
    case minPointMagLinearMipLinear
    /// Use linear interpolation for minification; use point sampling for magnification and mip-level sampling.
    case minLinearMagPointMipPoint
    /// Use linear interpolation for minification; use point sampling for magnification; use linear interpolation for mip-level sampling.
    case minLinearMagPointMipLinear
    /// Use linear interpolation for minification and magnification; use point sampling for mip-level sampling.
    case minLinearMagLinearMipPoint
    /// Use linear interpolation for minification, magnification, and mip-level sampling.
    case minLinearMagLinearMipLinear
    /// Use anisotropic interpolation for minification, magnification, and mip-level sampling.
    case anisotropic
}
