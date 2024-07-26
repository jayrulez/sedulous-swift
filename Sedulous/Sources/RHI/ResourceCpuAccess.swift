import Foundation

/// Specifies the types of CPU access allowed for a resource.
public struct ResourceCpuAccess: OptionSet, Hashable, Sendable {
    public let rawValue: UInt8

    /// None (default value).
    public static let none: ResourceCpuAccess = []
    /// The CPU can write to this resource.
    public static let write = ResourceCpuAccess(rawValue: 1 << 0)
    /// The CPU can read from this resource.
    public static let read = ResourceCpuAccess(rawValue: 1 << 1)

    public init(rawValue: UInt8) {
    self.rawValue = rawValue
    }
}
