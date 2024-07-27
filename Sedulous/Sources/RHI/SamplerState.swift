import Foundation

/// This protocol represents a sampler state.
public protocol SamplerState: GraphicsResource {
    /// The sampler state description.
    var description: SamplerStateDescription { get }

    /// Gets or sets a string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }

    /// Initializes a new instance of the `SamplerState` protocol.
    /// - Parameters:
    ///   - context: The graphics context.
    ///   - description: The sampler state description.
    init(context: GraphicsContext, description: SamplerStateDescription)
}
