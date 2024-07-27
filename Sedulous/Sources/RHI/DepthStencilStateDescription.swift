import Foundation

/// Describes depth-stencil state.
public struct DepthStencilStateDescription: Equatable, Hashable, Sendable {
    /// Enable depth testing.
    public var depthEnable: Bool

    /// Identify a portion of the depth-stencil buffer that can be modified by depth data.
    public var depthWriteMask: Bool

    /// A function that compares depth data against existing depth data.
    public var depthFunction: ComparisonFunction

    /// Enable stencil testing.
    public var stencilEnable: Bool

    /// Identify a portion of the depth-stencil buffer for reading stencil data.
    public var stencilReadMask: UInt8

    /// Identify a portion of the depth-stencil buffer for writing stencil data.
    public var stencilWriteMask: UInt8

    /// Identify how to use the results of the depth test and the stencil test for pixels whose surface normal is facing towards the camera.
    public var frontFace: DepthStencilOperationDescription

    /// Identify how to use the results of the depth test and the stencil test for pixels whose surface normal is facing away from the camera.
    public var backFace: DepthStencilOperationDescription

    /// Initializes a new instance of the DepthStencilStateDescription struct.
    /// - Parameters:
    ///   - depthEnable: Enable depth testing.
    ///   - depthWriteMask: Identify a portion of the depth-stencil buffer that can be modified by depth data.
    ///   - depthFunction: A function that compares depth data against existing depth data.
    ///   - stencilEnable: Enable stencil testing.
    ///   - stencilReadMask: Identify a portion of the depth-stencil buffer for reading stencil data.
    ///   - stencilWriteMask: Identify a portion of the depth-stencil buffer for writing stencil data.
    ///   - frontFace: Identify how to use the results of the depth test and the stencil test for pixels whose surface normal is facing towards the camera.
    ///   - backFace: Identify how to use the results of the depth test and the stencil test for pixels whose surface normal is facing away from the camera.
    public init(depthEnable: Bool = true, depthWriteMask: Bool = true, depthFunction: ComparisonFunction = .lessEqual, stencilEnable: Bool = false, stencilReadMask: UInt8 = .max, stencilWriteMask: UInt8 = .max, frontFace: DepthStencilOperationDescription = DepthStencilOperationDescription(stencilFailOperation: .keep, stencilDepthFailOperation: .keep, stencilPassOperation: .keep, stencilFunction: .always), backFace: DepthStencilOperationDescription = DepthStencilOperationDescription(stencilFailOperation: .keep, stencilDepthFailOperation: .keep, stencilPassOperation: .keep, stencilFunction: .always)) {
        self.depthEnable = depthEnable
        self.depthWriteMask = depthWriteMask
        self.depthFunction = depthFunction
        self.stencilEnable = stencilEnable
        self.stencilReadMask = stencilReadMask
        self.stencilWriteMask = stencilWriteMask
        self.frontFace = frontFace
        self.backFace = backFace
    }

    /// Gets default values for DepthStencilStateDescription.
    public static var `default`: DepthStencilStateDescription {
        var defaultInstance = DepthStencilStateDescription()
        defaultInstance.setDefault()
        return defaultInstance
    }

    /// Default DepthStencilStateDescription values.
    public mutating func setDefault() {
        depthEnable = true
        depthWriteMask = true
        depthFunction = .lessEqual
        stencilEnable = false
        stencilReadMask = .max
        stencilWriteMask = .max
        frontFace.stencilFunction = .always
        frontFace.stencilPassOperation = .keep
        frontFace.stencilFailOperation = .keep
        frontFace.stencilDepthFailOperation = .keep
        backFace.stencilFunction = .always
        backFace.stencilPassOperation = .keep
        backFace.stencilFailOperation = .keep
        backFace.stencilDepthFailOperation = .keep
    }

    public static func ==(lhs: DepthStencilStateDescription, rhs: DepthStencilStateDescription) -> Bool {
        return lhs.depthEnable == rhs.depthEnable &&
               lhs.depthWriteMask == rhs.depthWriteMask &&
               lhs.depthFunction == rhs.depthFunction &&
               lhs.stencilEnable == rhs.stencilEnable &&
               lhs.stencilReadMask == rhs.stencilReadMask &&
               lhs.stencilWriteMask == rhs.stencilWriteMask &&
               lhs.frontFace == rhs.frontFace &&
               lhs.backFace == rhs.backFace
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(depthEnable)
        hasher.combine(depthWriteMask)
        hasher.combine(depthFunction)
        hasher.combine(stencilEnable)
        hasher.combine(stencilReadMask)
        hasher.combine(stencilWriteMask)
        hasher.combine(frontFace)
        hasher.combine(backFace)
    }
}
