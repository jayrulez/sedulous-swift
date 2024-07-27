import Foundation

/// Default known values for DepthStencilStateDescription.
public struct DepthStencilStates {
    /// Depth disable.
    public static let none: DepthStencilStateDescription = {
        var state = DepthStencilStateDescription.default
        state.depthEnable = false
        state.depthWriteMask = false
        return state
    }()

    /// Depth enable and writemask enable.
    public static let readWrite: DepthStencilStateDescription = {
        return DepthStencilStateDescription.default
    }()

    /// Depth enable but writemask zero.
    public static let read: DepthStencilStateDescription = {
        var state = DepthStencilStateDescription.default
        state.depthWriteMask = false
        return state
    }()
}
