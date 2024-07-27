import Foundation

/// Stencil operations that can be performed based on the results of stencil test.
public struct DepthStencilOperationDescription: Equatable, Hashable, Sendable {
    /// The stencil operation to perform when stencil testing fails.
    public var stencilFailOperation: StencilOperation

    /// The stencil operation to perform when stencil testing passes and depth testing fails.
    public var stencilDepthFailOperation: StencilOperation

    /// The stencil operation to perform when stencil testing and depth testing both pass.
    public var stencilPassOperation: StencilOperation

    /// A function that compares stencil data against existing stencil data.
    public var stencilFunction: ComparisonFunction

    /// Initializes a new instance of the DepthStencilOperationDescription struct.
    /// - Parameters:
    ///   - stencilFailOperation: The stencil operation to perform when stencil testing fails.
    ///   - stencilDepthFailOperation: The stencil operation to perform when stencil testing passes and depth testing fails.
    ///   - stencilPassOperation: The stencil operation to perform when stencil testing and depth testing both pass.
    ///   - stencilFunction: A function that compares stencil data against existing stencil data.
    public init(stencilFailOperation: StencilOperation, stencilDepthFailOperation: StencilOperation, stencilPassOperation: StencilOperation, stencilFunction: ComparisonFunction) {
        self.stencilFailOperation = stencilFailOperation
        self.stencilDepthFailOperation = stencilDepthFailOperation
        self.stencilPassOperation = stencilPassOperation
        self.stencilFunction = stencilFunction
    }

    /// Determines whether the specified parameter is equal to this instance.
    /// - Parameter other: Other used to compare.
    /// - Returns: A Boolean value indicating whether the two objects are equal.
    public static func ==(lhs: DepthStencilOperationDescription, rhs: DepthStencilOperationDescription) -> Bool {
        return lhs.stencilFailOperation == rhs.stencilFailOperation &&
               lhs.stencilDepthFailOperation == rhs.stencilDepthFailOperation &&
               lhs.stencilPassOperation == rhs.stencilPassOperation &&
               lhs.stencilFunction == rhs.stencilFunction
    }

    /// Returns a hash code for this instance.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(stencilFailOperation)
        hasher.combine(stencilDepthFailOperation)
        hasher.combine(stencilPassOperation)
        hasher.combine(stencilFunction)
    }
}
