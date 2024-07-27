import Foundation

/// Represents a Texture graphics resource.
public protocol Texture: GraphicsResource {
    /// The TextureDescription struct.
    var description: TextureDescription { get }
    
    /// A string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }
    
    /// A value indicating whether this texture could be attached to a framebuffer.
    var couldBeAttachedToFramebuffer: Bool { get }
    
    /// Initializes a new instance of the Texture class.
    /// - Parameters:
    ///   - context: The graphics context.
    ///   - description: The texture description.
    init(context: GraphicsContext, description: TextureDescription)
}

public extension Texture {
    var couldBeAttachedToFramebuffer: Bool {
        return true
    }
}
