import Foundation

/// Primitive fill mode.
public enum FillMode: UInt8, Sendable {
    /// Draw lines connecting the vertices. Adjacent vertices are not drawn.
    case wireframe = 2
    /// Fill the triangles formed by the vertices. Adjacent vertices are not drawn.
    case solid
}
