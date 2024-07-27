import Foundation

/// Blend factors, which modulate values for the pixel shader and render target.
public enum Blend: UInt8, Sendable {
    /// The data source is the color black (0, 0, 0, 0). No pre-blend operation.
    case zero = 1
    /// The data source is the color white (1, 1, 1, 1). No pre-blend operation.
    case one = 2
    /// The data source is color data (RGB) from a pixel shader. No pre-blend operation.
    case sourceColor = 3
    /// The data source is color data (RGB) from a pixel shader. The pre-blend operation inverts the data, generating 1 - RGB.
    case inverseSourceColor = 4
    /// The data source is alpha data (A) from a pixel shader. No pre-blend operation.
    case sourceAlpha = 5
    /// The data source is alpha data (A) from a pixel shader. The pre-blend operation inverts the data, generating 1 - A.
    case inverseSourceAlpha = 6
    /// The data source is alpha data from a rendertarget. No pre-blend operation.
    case destinationAlpha = 7
    /// The data source is alpha data from a rendertarget. The pre-blend operation inverts the data, generating 1 - A.
    case inverseDestinationAlpha = 8
    /// The data source is color data from a rendertarget. No pre-blend operation.
    case destinationColor = 9
    /// The data source is color data from a rendertarget. The pre-blend operation inverts the data, generating 1 - RGB.
    case inverseDestinationColor = 10
    /// The data source is alpha data from a pixel shader. The pre-blend operation clamps the data to 1 or less.
    case sourceAlphaSaturate = 11
    /// The data source is the blend factor set with BlendStates. No pre-blend operation.
    case blendFactor = 14
    /// The data source is the blend factor set with SetBlendState. The pre-blend operation inverts the blend factor, generating 1 - blend_factor.
    case inverseBlendFactor = 15
    /// The data sources are both color data output by a pixel shader. There is no pre-blend operation. This options supports dual-source color blending.
    case secondarySourceColor = 16
    /// The data sources are both color data output by a pixel shader. The pre-blend operation inverts the data, generating 1 - RGB. This options supports dual-source color blending.
    case inverseSecondarySourceColor = 17
    /// The data sources are alpha data output by a pixel shader. There is no pre-blend operation. This options supports dual-source color blending.
    case secondarySourceAlpha = 18
    /// The data sources are alpha data output by a pixel shader. The pre-blend operation inverts the data, generating 1 - A. This options supports dual-source color blending.
    case inverseSecondarySourceAlpha = 19
}
