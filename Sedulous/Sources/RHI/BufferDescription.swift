import Foundation

/// Contains properties that describe the characteristics of a new buffer object.
public struct BufferDescription: Equatable, Hashable {
    /// Retrieves or sets the size of the new buffer.
    var sizeInBytes: UInt32

    /// Buffer flags describing buffer type.
    var flags: BufferFlags

    /// Specifies the types of CPU access allowed for this buffer.
    var cpuAccess: ResourceCpuAccess

    /// Usage of this buffer.
    var usage: ResourceUsage

    /// The structure byte stride.
    var structureByteStride: Int

    /// Initializes a new instance of the `BufferDescription` struct.
    /// - Parameters:
    ///   - sizeInBytes: Size of the buffer in bytes.
    ///   - flags: Buffer flags describing the buffer type.
    ///   - usage: Usage for this buffer.
    ///   - cpuAccess: Describe the type of CPU access allowed for.
    ///   - structureByteStride: The structure byte stride.
    public init(sizeInBytes: UInt32, flags: BufferFlags, usage: ResourceUsage, cpuAccess: ResourceCpuAccess = .none, structureByteStride: Int = 0) {
        self.sizeInBytes = sizeInBytes
        self.flags = flags
        self.cpuAccess = cpuAccess
        self.usage = usage
        self.structureByteStride = structureByteStride
    }

    /// Determines whether the specified parameter is equal to this instance.
    /// - Parameter other: Other used to compare.
    /// - Returns: `true` if the specified `Object` is equal to this instance; otherwise, `false`.
    public static func ==(lhs: BufferDescription, rhs: BufferDescription) -> Bool {
        return lhs.sizeInBytes == rhs.sizeInBytes &&
            lhs.flags == rhs.flags &&
            lhs.cpuAccess == rhs.cpuAccess &&
            lhs.usage == rhs.usage &&
            lhs.structureByteStride == rhs.structureByteStride
    }

    /// Determines whether the specified `Object` is equal to this instance.
    /// - Parameter obj: The `Object` to compare with this instance.
    /// - Returns: `true` if the specified `Object` is equal to this instance; otherwise, `false`.
    public func isEqual(_ obj: Any?) -> Bool {
        guard let other = obj as? BufferDescription else { return false }
        return self == other
    }

    /// Returns a hash code for this instance.
    /// - Parameter hasher: The hasher to use when combining the components of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sizeInBytes)
        hasher.combine(flags)
        hasher.combine(cpuAccess)
        hasher.combine(usage)
        hasher.combine(structureByteStride)
    }

    /// Gets the cpu access flags from resource usage.
    /// - Parameter usage: The usage.
    /// - Returns: The cpu access flags.
    private static func getCpuAccessFromResourceUsage(_ usage: ResourceUsage) -> ResourceCpuAccess {
        switch usage {
        case .dynamic:
            return .write
        case .staging:
            return [.write, .read]
        default:
            return .none
        }
    }
}
