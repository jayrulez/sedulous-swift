import Foundation

/// This protocol represents a set of bindable resources.
public protocol ResourceLayout : AnyObject {
    
    /// The resource layout description.
    var description: ResourceLayoutDescription { get }
    
    /// Gets or sets a string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }
    
    /// Initializes a new instance of the `ResourceLayout` class.
    /// - Parameter description: The resource layout description.
    init(description: ResourceLayoutDescription)
}