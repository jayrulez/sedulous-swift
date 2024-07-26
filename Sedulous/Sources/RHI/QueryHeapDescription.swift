import Foundation

/// Contains properties that describe the characteristics of a new query heap object.
public struct QueryHeapDescription: Equatable, Hashable {
    /// Specifies the query heap type.
    public var type: QueryType

    /// Specifies the query heap capacity.
    public var queryCount: UInt

    /// Initializes a new instance of the `QueryHeapDescription` struct.
    /// - Parameters:
    ///   - type: The query heap type.
    ///   - queryCount: The query heap capacity.
    public init(type: QueryType, queryCount: UInt) {
        self.type = type
        self.queryCount = queryCount
    }

    /// Determines whether the specified parameter is equal to this instance.
    /// - Parameter other: Other used to compare.
    /// - Returns: `true` if the specified `QueryHeapDescription` is equal to this instance; otherwise, `false`.
    public static func == (lhs: QueryHeapDescription, rhs: QueryHeapDescription) -> Bool {
        return lhs.type == rhs.type && lhs.queryCount == rhs.queryCount
    }

    /// Returns a hash code for this instance.
    /// - Parameter hasher: The hasher to use when combining the components of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(queryCount)
    }
}
