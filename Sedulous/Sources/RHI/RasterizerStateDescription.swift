import Foundation

/// Describes a rasterizer state.
public struct RasterizerStateDescription: Equatable, Hashable, Sendable {
    /// Determines the fill mode to use when rendering.
    public var fillMode: FillMode = .solid

    /// Indicates triangles facing the specified direction are not drawn.
    public var cullMode: CullMode = .none

    /// Determines if a triangle is front- or back-facing. If this parameter is TRUE, a triangle will be considered front-facing
    /// if its vertices are counter-clockwise on the render target and considered back-facing if they are clockwise.
    /// If this parameter is FALSE, the opposite is true.
    public var frontCounterClockwise: Bool = false

    /// Depth value added to a given pixel. For info about depth bias.
    public var depthBias: Int = 0

    /// Maximum depth bias of a pixel.
    public var depthBiasClamp: Float = 0

    /// Scalar on a given pixel's slope.
    public var slopeScaledDepthBias: Float = 0

    /// Enable clipping based on distance.
    public var depthClipEnable: Bool = false

    /// Enable scissor-rectangle culling. All pixels outside an active scissor rectangle are culled.
    public var scissorEnable: Bool = false

    /// Specifies whether to enable line antialiasing; only applies if doing line drawing and MultisampleEnable is FALSE.
    public var antialiasedLineEnable: Bool = false

    /// Gets default values for RasterizerStateDescription.
    public static var `default`: RasterizerStateDescription {
        var defaultInstance = RasterizerStateDescription()
        defaultInstance.setDefault()
        return defaultInstance
    }

    /// Default rasterizer state description values.
    public mutating func setDefault() {
        fillMode = .solid
        cullMode = .back
        frontCounterClockwise = false
        depthBias = 0
        slopeScaledDepthBias = 0.0
        depthBiasClamp = 0.0
        depthClipEnable = true
        scissorEnable = false
        antialiasedLineEnable = false
    }

    public static func == (lhs: RasterizerStateDescription, rhs: RasterizerStateDescription) -> Bool {
        return lhs.fillMode == rhs.fillMode &&
            lhs.cullMode == rhs.cullMode &&
            lhs.frontCounterClockwise == rhs.frontCounterClockwise &&
            lhs.depthBias == rhs.depthBias &&
            lhs.depthBiasClamp == rhs.depthBiasClamp &&
            lhs.slopeScaledDepthBias == rhs.slopeScaledDepthBias &&
            lhs.depthClipEnable == rhs.depthClipEnable &&
            lhs.scissorEnable == rhs.scissorEnable &&
            lhs.antialiasedLineEnable == rhs.antialiasedLineEnable
    }

    public func hash(into hasher: inout Hasher) {
        var cullMode: CullMode
        switch self.cullMode {
        case .front:
            cullMode = frontCounterClockwise ? .back : .front
        case .back:
            cullMode = frontCounterClockwise ? .front : .back
        case .none:
            cullMode = self.cullMode
        }

        hasher.combine(fillMode)
        hasher.combine(cullMode)
        hasher.combine(depthBias)
        hasher.combine(depthBiasClamp)
        hasher.combine(slopeScaledDepthBias)
        hasher.combine(depthClipEnable)
        hasher.combine(scissorEnable)
        hasher.combine(antialiasedLineEnable)
    }
}
