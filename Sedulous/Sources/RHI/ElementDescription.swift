import Foundation

/// Describes an individual component of a vertex.
public struct ElementDescription: Equatable, Hashable {
    /// Use sequential offset.
    public static let appendAligned = -1

    /// Gets the type of the element.
    public var semantic: ElementSemanticType

    /// Gets the semantic index of this element.
    public var semanticIndex: UInt

    /// Gets the format of the element.
    public var format: ElementFormat

    /// Gets the offset of the element.
    public var offset: Int

    /// Initializes a new instance of the ElementDescription struct.
    /// - Parameters:
    ///   - format: The element format.
    ///   - semanticType: The element semantic.
    ///   - semanticIndex: The semantic index for this element.
    ///   - offset: The element offset.
    public init(format: ElementFormat, semanticType: ElementSemanticType, semanticIndex: UInt = 0, offset: Int = ElementDescription.appendAligned) {
        self.semantic = semanticType
        self.semanticIndex = semanticIndex
        self.format = format
        self.offset = offset
    }

    /// Determines whether the specified ElementDescription is equal to this instance.
    /// - Parameter other: The ElementDescription to compare with this instance.
    /// - Returns: `true` if the specified ElementDescription is equal to this instance; otherwise, `false`.
    public func equals(_ other: ElementDescription) -> Bool {
        return semantic == other.semantic && format == other.format
    }

    /// Determines whether the specified object is equal to this instance.
    /// - Parameter obj: The object to compare with this instance.
    /// - Returns: `true` if the specified object is equal to this instance; otherwise, `false`.
    public static func ==(lhs: ElementDescription, rhs: ElementDescription) -> Bool {
        return lhs.equals(rhs)
    }

    /// Returns a hash code for this instance.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(semantic)
        hasher.combine(semanticIndex)
        hasher.combine(format)
    }
}
