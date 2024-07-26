/// This protocol represents a buffer resource.
public protocol Buffer: GraphicsResource {
    /// Counter that represents every time that this buffer is updated.
    var updateCounter: Int { get set }
    
    /// Gets the buffer description.
    var description: BufferDescription { get }
    
    /// Gets or sets a string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }
    
    /// Initializes a new instance of the buffer.
    init(context: GraphicsContext, description: BufferDescription)
    
    /// Increment the update counter.
    func touch()
}

/// Default implementation for the touch method in the protocol extension
public extension Buffer {
    mutating func touch() {
        updateCounter += 1
    }
}