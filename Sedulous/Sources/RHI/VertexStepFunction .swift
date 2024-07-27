import Foundation

/// The frequency with which the vertex function fetches attributes data.
public enum VertexStepFunction {
    /// Input data is per-vertex data.
    case perVertexData
    /// Input data is per-instance data.
    case perInstanceData
}
