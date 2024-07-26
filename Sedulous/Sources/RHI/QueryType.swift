import Foundation

/// Specifies the type of query.
public enum QueryType: Int {
    /// Indicates the query is for high definition GPU and CPU timestamps.
    case Timestamp
    /// Indicates the query is for depth/stencil occlusion counts.
    case Occlusion
    /// Indicates the query is for a binary depth/stencil occlusion statistics.
    case BinaryOcclusion
}
