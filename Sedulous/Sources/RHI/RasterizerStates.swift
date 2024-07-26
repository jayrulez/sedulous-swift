import Foundation

/// Default known values for RasterizerStateDescription.
public struct RasterizerStates : Sendable {
    /// Cull primitives with clockwise winding order.
    public static let cullFront: RasterizerStateDescription = {
        var desc = RasterizerStateDescription.default
        desc.cullMode = .front
        return desc
    }()

    /// Cull primitives with counter-clockwise winding order.
    public static let cullBack: RasterizerStateDescription = RasterizerStateDescription.default

    /// Not cull primitives.
    public static let none: RasterizerStateDescription = {
        var desc = RasterizerStateDescription.default
        desc.cullMode = .none
        return desc
    }()

    /// Cull primitives with clockwise winding order and wireframe enable.
    public static let wireframeCullFront: RasterizerStateDescription = {
        var desc = RasterizerStateDescription.default
        desc.cullMode = .front
        desc.fillMode = .wireframe
        return desc
    }()

    /// Cull primitives with counter-clockwise winding order and wireframe enable.
    public static let wireframeCullBack: RasterizerStateDescription = {
        var desc = RasterizerStateDescription.default
        desc.fillMode = .wireframe
        return desc
    }()

    /// Not cull primitives and wireframe enable.
    public static let wireframeCullNone: RasterizerStateDescription = {
        var desc = RasterizerStateDescription.default
        desc.cullMode = .none
        desc.fillMode = .wireframe
        return desc
    }()
}
