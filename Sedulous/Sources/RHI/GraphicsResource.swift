import Foundation

/// A protocol that provides common actions on all resources.
public protocol GraphicsResource {
    /// The device context reference.
    var context: GraphicsContext { get }

    /// Initializes a new instance of the `GraphicsResource` class.
    /// - Parameter context: The device context.
    init(context: GraphicsContext)
}
