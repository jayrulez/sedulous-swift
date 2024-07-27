import Foundation

/// Protocol representing a single shader program.
public protocol Shader: GraphicsResource {
    /// Gets the shader description.
    var description: ShaderDescription { get }
    
    /// Gets or sets a string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }
    
    /// Initializes a new instance of the Shader.
    /// - Parameters:
    ///   - context: The graphics context.
    ///   - description: The shader description.
    init(context: GraphicsContext, description: ShaderDescription)
}

/// Default implementation of equality and hashability for Shader protocol
extension Shader {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(description.hashValue)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.description == rhs.description
    }
}
