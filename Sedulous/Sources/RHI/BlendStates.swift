import Foundation

/// Default known values for `BlendStateDescription`.
struct BlendStates {
    /// Not blending.
    static let opaque: BlendStateDescription = {
        var description = BlendStateDescription.default
        description.renderTarget0.blendEnable = false
        description.renderTarget0.sourceBlendColor = .one
        description.renderTarget0.destinationBlendColor = .zero
        return description
    }()

    /// Premultiplied alpha blending.
    static let alphaBlend: BlendStateDescription = {
        var description = BlendStateDescription.default
        description.renderTarget0.blendEnable = true
        description.renderTarget0.sourceBlendColor = .one
        description.renderTarget0.destinationBlendColor = .inverseSourceAlpha
        description.renderTarget0.sourceBlendAlpha = .one
        description.renderTarget0.destinationBlendAlpha = .inverseSourceAlpha
        return description
    }()

    /// Additive alpha blending.
    static let additive: BlendStateDescription = {
        var description = BlendStateDescription.default
        description.renderTarget0.blendEnable = true
        description.renderTarget0.blendOperationColor = .add
        description.renderTarget0.blendOperationAlpha = .add
        description.renderTarget0.sourceBlendColor = .one
        description.renderTarget0.destinationBlendColor = .one
        description.renderTarget0.sourceBlendAlpha = .one
        description.renderTarget0.destinationBlendAlpha = .one
        return description
    }()

    /// Additive alpha blending.
    static let multiplicative: BlendStateDescription = {
        var description = BlendStateDescription.default
        description.renderTarget0.blendEnable = true
        description.renderTarget0.blendOperationColor = .add
        description.renderTarget0.blendOperationAlpha = .add
        description.renderTarget0.sourceBlendColor = .destinationColor
        description.renderTarget0.destinationBlendColor = .inverseSourceAlpha
        description.renderTarget0.sourceBlendAlpha = .one
        description.renderTarget0.destinationBlendAlpha = .one
        return description
    }()

    /// Non premultiplied alpha blending.
    static let nonPremultiplied: BlendStateDescription = {
        var description = BlendStateDescription.default
        description.renderTarget0.blendEnable = true
        description.renderTarget0.sourceBlendColor = .sourceAlpha
        description.renderTarget0.destinationBlendColor = .inverseSourceAlpha
        return description
    }()
}
