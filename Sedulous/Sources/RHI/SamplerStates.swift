import Foundation

/// Describes a sampler state.
public struct SamplerStates {
    /// SamplerState description using point filter (bilinear) and clamp address mode for UVW.
    public static let pointClamp: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.filter = .minPointMagPointMipPoint
        return description
    }()

    /// SamplerState description using point filter (bilinear) and wrap address mode for UVW.
    public static let pointWrap: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.filter = .minPointMagPointMipPoint
        description.addressU = .wrap
        description.addressV = .wrap
        description.addressW = .wrap
        return description
    }()

    /// SamplerState description using point filter (bilinear) and mirror address mode for UVW.
    public static let pointMirror: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.filter = .minPointMagPointMipPoint
        description.addressU = .mirror
        description.addressV = .mirror
        description.addressW = .mirror
        return description
    }()

    /// SamplerState description using linear filter (trilinear) and clamp address mode for UVW.
    public static let linearClamp: SamplerStateDescription = {
        return SamplerStateDescription.default
    }()

    /// SamplerState description using linear filter (trilinear) and wrap address mode for UVW.
    public static let linearWrap: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.addressU = .wrap
        description.addressV = .wrap
        description.addressW = .wrap
        return description
    }()

    /// SamplerState description using linear filter (trilinear) and mirror address mode for UVW.
    public static let linearMirror: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.addressU = .mirror
        description.addressV = .mirror
        description.addressW = .mirror
        return description
    }()

    /// SamplerState description using anisotropic filter and clamp address mode for UVW.
    public static let anisotropicClamp: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.filter = .anisotropic
        return description
    }()

    /// SamplerState description using anisotropic filter and wrap address mode for UVW.
    public static let anisotropicWrap: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.filter = .anisotropic
        description.addressU = .wrap
        description.addressV = .wrap
        description.addressW = .wrap
        return description
    }()

    /// SamplerState description using anisotropic filter and mirror address mode for UVW.
    public static let anisotropicMirror: SamplerStateDescription = {
        var description = SamplerStateDescription.default
        description.filter = .anisotropic
        description.addressU = .mirror
        description.addressV = .mirror
        description.addressW = .mirror
        return description
    }()
}
