import Foundation

/// Struct containing the info of an indirect indexed and instanced draw call.
struct IndirectDrawArgsIndexedInstanced {
    /// The index count per instance.
    var indexCountPerInstance: UInt32
    
    /// The instance count.
    var instanceCount: UInt32
    
    /// The start index location.
    var startIndexLocation: UInt32
    
    /// The base vertex location.
    var baseVertexLocation: Int32
    
    /// The start instance location.
    var startInstanceLocation: UInt32
    
    /// Initializes a new instance of the `IndirectDrawArgsIndexedInstanced` struct.
    /// - Parameters:
    ///   - indexCountPerInstance: The index count per instance.
    ///   - instanceCount: The instance count.
    ///   - startIndexLocation: The start index location.
    ///   - baseVertexLocation: The base vertex location.
    ///   - startInstanceLocation: The start instance location.
    init(indexCountPerInstance: UInt32, instanceCount: UInt32, startIndexLocation: UInt32, baseVertexLocation: Int32, startInstanceLocation: UInt32) {
        self.indexCountPerInstance = indexCountPerInstance
        self.instanceCount = instanceCount
        self.startIndexLocation = startIndexLocation
        self.baseVertexLocation = baseVertexLocation
        self.startInstanceLocation = startInstanceLocation
    }
}
