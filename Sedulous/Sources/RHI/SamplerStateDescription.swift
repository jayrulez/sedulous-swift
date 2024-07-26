import Foundation

/// Describes a sampler state.
public struct SamplerStateDescription: Equatable, Hashable, Sendable {
    /// Filtering method to use when sampling a texture.
    var filter: TextureFilter
    /// Method to use for resolving a u texture coordinate that is outside the 0 to 1 range.
    var addressU: TextureAddressMode
    /// Method to use for resolving a v texture coordinate that is outside the 0 to 1 range.
    var addressV: TextureAddressMode
    /// Method to use for resolving a w texture coordinate that is outside the 0 to 1 range.
    var addressW: TextureAddressMode
    /// Offset from the calculated mipmap level. For example, if Direct3D calculates that a
    /// texture should be sampled at mipmap level 3 and MipLODBias is 2, then the texture will be sampled at mipmap level 5.
    var mipLODBias: Float
    /// Clamping value used if D3D11_FILTER_ANISOTROPIC or D3D11_FILTER_COMPARISON_ANISOTROPIC is
    /// specified in Filter. Valid values are between 1 and 16.
    var maxAnisotropy: UInt
    /// A function that compares sampled data against existing sampled data.
    var comparisonFunc: ComparisonFunction
    /// Border color `SamplerBorderColor`.
    var borderColor: SamplerBorderColor
    /// Lower end of the mipmap range to clamp access to, where 0 is the largest and most detailed mipmap level
    /// and any level higher than that is less detailed.
    var minLOD: Float
    /// Upper end of the mipmap range to clamp access to, where 0 is the largest and most detailed mipmap level and any level
    /// higher than that is less detailed. This value must be greater than or equal to MinLOD.
    var maxLOD: Float

    static var `default`: SamplerStateDescription {
        return SamplerStateDescription(
            filter: .minLinearMagLinearMipLinear,
            addressU: .clamp,
            addressV: .clamp,
            addressW: .clamp,
            mipLODBias: 0.0,
            maxAnisotropy: 1,
            comparisonFunc: .never,
            borderColor: .opaqueWhite,
            minLOD: -1000.0,
            maxLOD: 1000.0
        )
    }

    /// Mutating function to set the default values.
    mutating func setDefault() {
        self = SamplerStateDescription.default
    }
}
