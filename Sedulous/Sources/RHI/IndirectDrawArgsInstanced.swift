import Foundation

/// The arguments of an instanced indirect draw call.
public struct IndirectDrawArgsInstanced {
    /// The vertex count per instance.
    public var vertexCountPerInstance: UInt32
    
    /// The instance count.
    public var instanceCount: UInt32
    
    /// The start vertex location.
    public var startVertexLocation: UInt32
    
    /// The start instance location.
    public var startInstanceLocation: UInt32
    
    /// Initializes a new instance of the IndirectDrawArgsInstanced struct.
    /// - Parameters:
    ///   - vertexCountPerInstance: The vertex count per instance.
    ///   - instanceCount: The instance count.
    ///   - startVertexLocation: The start vertex location.
    ///   - startInstanceLocation: The start instance location.
    public init(vertexCountPerInstance: UInt32, instanceCount: UInt32, startVertexLocation: UInt32, startInstanceLocation: UInt32) {
        self.vertexCountPerInstance = vertexCountPerInstance
        self.instanceCount = instanceCount
        self.startVertexLocation = startVertexLocation
        self.startInstanceLocation = startInstanceLocation
    }
}
