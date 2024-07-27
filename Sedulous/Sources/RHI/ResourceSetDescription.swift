import Foundation

/// This class describes the elements inside a `ResourceLayout`.
public struct ResourceSetDescription {
    /// The resourceLayout object.
    public var layout: ResourceLayout

    /// An array of `GraphicsResource` elements such as Textures, ConstantBuffers, Samples.
    public var resources: [GraphicsResource]

    /// Initializes a new instance of the `ResourceSetDescription` struct.
    /// - Parameters:
    ///   - layout: The resourceLayout object.
    ///   - resources: The list of resources.
    public init(layout: ResourceLayout, resources: GraphicsResource...) {
        self.layout = layout
        self.resources = resources
    }
}