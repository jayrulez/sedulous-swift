import Foundation

/// Describes the blend state.
struct BlendStateRenderTargetDescription: Equatable, Hashable {
    /// Enable (or disable) blending.
    var blendEnable: Bool

    /// This blend option specifies the operation to perform on the RGB value that the pixel shader outputs.
    /// The BlendOp member defines how to combine the SrcBlend and DestBlend operations.
    var sourceBlendColor: Blend

    /// This blend option specifies the operation to perform on the current RGB value in the render target.
    /// The BlendOp member defines how to combine the SrcBlend and DestBlend operations.
    var destinationBlendColor: Blend

    /// This blend operation defines how to combine the SrcBlend and DestBlend operations.
    var blendOperationColor: BlendOperation

    /// This blend option specifies the operation to perform on the alpha value that the pixel shader outputs.
    /// Blend options that end in _COLOR are not allowed. The BlendOpAlpha member defines how to combine the SrcBlendAlpha
    /// and DestBlendAlpha operations.
    var sourceBlendAlpha: Blend

    /// This blend option specifies the operation to perform on the current alpha value in the render target.
    /// Blend options that end in _COLOR are not allowed. The BlendOpAlpha member defines how to combine the SrcBlendAlpha
    /// and DestBlendAlpha operations.
    var destinationBlendAlpha: Blend

    /// This blend operation defines how to combine the SrcBlendAlpha and DestBlendAlpha operations.
    var blendOperationAlpha: BlendOperation

    /// A write mask.
    var colorWriteChannels: ColorWriteChannels

    /// Gets default values for BlendStateDescription.
    static var `default`: BlendStateRenderTargetDescription {
        var defaultInstance = BlendStateRenderTargetDescription(
            blendEnable: false,
            sourceBlendColor: .one,
            destinationBlendColor: .zero,
            blendOperationColor: .add,
            sourceBlendAlpha: .one,
            destinationBlendAlpha: .zero,
            blendOperationAlpha: .add,
            colorWriteChannels: .all
        )
        defaultInstance.setDefault()
        return defaultInstance
    }

    /// Default BlendStateDescription values.
    mutating func setDefault() {
        blendEnable = false
        sourceBlendColor = .one
        destinationBlendColor = .zero
        blendOperationColor = .add
        sourceBlendAlpha = .one
        destinationBlendAlpha = .zero
        blendOperationAlpha = .add
        colorWriteChannels = .all
    }

    /// Returns a hash code for this instance.
    /// - Parameter other: Other used to compare.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    static func ==(lhs: BlendStateRenderTargetDescription, rhs: BlendStateRenderTargetDescription) -> Bool {
        return lhs.blendEnable == rhs.blendEnable &&
            lhs.sourceBlendColor == rhs.sourceBlendColor &&
            lhs.destinationBlendColor == rhs.destinationBlendColor &&
            lhs.blendOperationColor == rhs.blendOperationColor &&
            lhs.sourceBlendAlpha == rhs.sourceBlendAlpha &&
            lhs.destinationBlendAlpha == rhs.destinationBlendAlpha &&
            lhs.blendOperationAlpha == rhs.blendOperationAlpha &&
            lhs.colorWriteChannels == rhs.colorWriteChannels
    }

    /// Returns a hash code for this instance.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    func hash(into hasher: inout Hasher) {
        hasher.combine(blendEnable)
        hasher.combine(sourceBlendColor)
        hasher.combine(destinationBlendColor)
        hasher.combine(blendOperationColor)
        hasher.combine(sourceBlendAlpha)
        hasher.combine(destinationBlendAlpha)
        hasher.combine(blendOperationAlpha)
        hasher.combine(colorWriteChannels)
    }
}
