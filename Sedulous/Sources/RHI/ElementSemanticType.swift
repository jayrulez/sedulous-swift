import Foundation

/// The semantic meaning of a vertex element.
public enum ElementSemanticType: UInt8 {
    /// Describes a position.
    case position
    /// Describes a texture coordinate.
    case texCoord
    /// Describes a normal vector.
    case normal
    /// Describes a tangent vector.
    case tangent
    /// Describes a binormal vector.
    case binormal
    /// Describes a color.
    case color
    /// Blend indices.
    case blendIndices
    /// Blend weights.
    case blendWeight
    /// Auxiliary value to count all semantics.
    case count
}
