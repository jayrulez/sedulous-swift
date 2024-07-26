import Foundation

/// Describes the blend state.
struct BlendStateDescription: Equatable, Hashable {
    /// Specifies whether to use alpha-to-coverage as a multisampling technique when setting a pixel to a render target.
    var alphaToCoverageEnable: Bool

    /// Specifies whether to enable independent blending in simultaneous render targets. Set to TRUE to enable independent blending.
    /// If set to FALSE, only the RenderTarget[0] members are used; RenderTarget[1..7] are ignored.
    var independentBlendEnable: Bool

    /// RenderTarget blend description 0 / 7.
    var renderTarget0: BlendStateRenderTargetDescription

    /// RenderTarget blend description 1 / 7.
    var renderTarget1: BlendStateRenderTargetDescription

    /// RenderTarget blend description 2 / 7.
    var renderTarget2: BlendStateRenderTargetDescription

    /// RenderTarget blend description 3 / 7.
    var renderTarget3: BlendStateRenderTargetDescription

    /// RenderTarget blend description 4 / 7.
    var renderTarget4: BlendStateRenderTargetDescription

    /// RenderTarget blend description 5 / 7.
    var renderTarget5: BlendStateRenderTargetDescription

    /// RenderTarget blend description 6 / 7.
    var renderTarget6: BlendStateRenderTargetDescription

    /// RenderTarget blend description 7 / 7.
    var renderTarget7: BlendStateRenderTargetDescription

    /// Gets default values for BlendStateDescription.
    static var `default`: BlendStateDescription {
        var defaultInstance = BlendStateDescription(
            alphaToCoverageEnable: false,
            independentBlendEnable: false,
            renderTarget0: .default,
            renderTarget1: .default,
            renderTarget2: .default,
            renderTarget3: .default,
            renderTarget4: .default,
            renderTarget5: .default,
            renderTarget6: .default,
            renderTarget7: .default
        )
        defaultInstance.setDefault()
        return defaultInstance
    }

    /// Default BlendStateDescription values.
    mutating func setDefault() {
        alphaToCoverageEnable = false
        independentBlendEnable = false
        renderTarget0 = .default
        renderTarget1 = .default
        renderTarget2 = .default
        renderTarget3 = .default
        renderTarget4 = .default
        renderTarget5 = .default
        renderTarget6 = .default
        renderTarget7 = .default
    }

    /// Returns a hash code for this instance.
    /// - Parameter other: Other used to compare.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    static func ==(lhs: BlendStateDescription, rhs: BlendStateDescription) -> Bool {
        return lhs.alphaToCoverageEnable == rhs.alphaToCoverageEnable &&
            lhs.independentBlendEnable == rhs.independentBlendEnable &&
            lhs.renderTarget0 == rhs.renderTarget0 &&
            lhs.renderTarget1 == rhs.renderTarget1 &&
            lhs.renderTarget2 == rhs.renderTarget2 &&
            lhs.renderTarget3 == rhs.renderTarget3 &&
            lhs.renderTarget4 == rhs.renderTarget4 &&
            lhs.renderTarget5 == rhs.renderTarget5 &&
            lhs.renderTarget6 == rhs.renderTarget6 &&
            lhs.renderTarget7 == rhs.renderTarget7
    }

    /// Returns a hash code for this instance.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    func hash(into hasher: inout Hasher) {
        hasher.combine(alphaToCoverageEnable)
        hasher.combine(independentBlendEnable)
        hasher.combine(renderTarget0)
        hasher.combine(renderTarget1)
        hasher.combine(renderTarget2)
        hasher.combine(renderTarget3)
        hasher.combine(renderTarget4)
        hasher.combine(renderTarget5)
        hasher.combine(renderTarget6)
        hasher.combine(renderTarget7)
    }
}
