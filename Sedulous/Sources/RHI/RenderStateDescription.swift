import Foundation

/// This struct represent all the parameters in the render states.
public struct RenderStateDescription: Equatable, Hashable {
    /// Gets or sets the Rasterizer State.
    public var rasterizerState: RasterizerStateDescription

    /// Gets or sets the DepthStencil state.
    public var depthStencilState: DepthStencilStateDescription

    /// Gets or sets the BlendState state.
    public var blendState: BlendStateDescription

    /// The reference value to use when doing a stencil test.
    public var stencilReference: Int

    /// Array of blend factors, one for each RGBA component.
    /// The blend factors modulate values for the pixel shader, render target, or both.
    public var blendFactor: SIMD4<Float>?

    /// 32-bit sample coverage. The default value is 0xFFFFFF.
    public var sampleMask: Int?

    /// Gets default values for RenderStateDescription.
    public static var `default`: RenderStateDescription {
        var defaultInstance = RenderStateDescription(
            rasterizerState: .default,
            depthStencilState: .default,
            blendState: .default,
            stencilReference: 0,
            blendFactor: nil,
            sampleMask: 0xFFFFFF
        )
        defaultInstance.setDefault()
        return defaultInstance
    }

    /// Default RenderStateDescription values.
    public mutating func setDefault() {
        rasterizerState = .default
        depthStencilState = .default
        blendState = .default
        stencilReference = 0
        blendFactor = nil
        sampleMask = 0xFFFFFF
    }

    /// Equatable conformance.
    public static func == (lhs: RenderStateDescription, rhs: RenderStateDescription) -> Bool {
        return lhs.rasterizerState == rhs.rasterizerState &&
               lhs.depthStencilState == rhs.depthStencilState &&
               lhs.blendState == rhs.blendState &&
               lhs.stencilReference == rhs.stencilReference &&
               lhs.blendFactor == rhs.blendFactor &&
               lhs.sampleMask == rhs.sampleMask
    }

    /// Hashable conformance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(rasterizerState)
        hasher.combine(depthStencilState)
        hasher.combine(blendState)
        hasher.combine(stencilReference)
        hasher.combine(blendFactor)
        hasher.combine(sampleMask)
    }
}
