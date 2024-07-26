import Foundation

/// Specifies the vertex element usage.
enum VertexElementUsage: UInt8 {
    /// Used for position.
    case position
    /// Used for color.
    case color
    /// Used for texture coordinate.
    case textureCoordinate
    /// Used for normal.
    case normal
    /// Used for binormal.
    case binormal
    /// Used for tangent.
    case tangent
    /// Used for blend indices.
    case blendIndices
    /// Used for blend weights.
    case blendWeight
    /// Used for depth.
    case depth
    /// Used for fog.
    case fog
    /// Used for point size.
    case pointSize
    /// Used for sample.
    case sample
    /// Used for tessellation factor.
    case tessellateFactor
}
