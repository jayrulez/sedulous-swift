import Foundation

/// This protocol describes the elements inside a `ResourceLayout`.
public protocol ResourceSet: AnyObject {
    /// The resourceSet description.
    var description: ResourceSetDescription { get }

    /// A string identifying this instance. Can be used in graphics debugger tools.
    var name: String { get set }

    /// Initializes a new instance of the `ResourceSet`.
    /// - Parameter description: The resourceSet description.
    init(description: ResourceSetDescription)
}