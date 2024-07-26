import Foundation

/// Identifies expected texture use during rendering.
public enum ResourceUsage: UInt8, Sendable {
    /// A resource that requires read and write access by the GPU, Default value.
    case `default`
    /// A resource that can only be read by the GPU. It cannot be written by the GPU, and cannot be accessed at all by the CPU.
    /// This type of resource must be initialized when it is created, since it cannot be changed after creation.
    case immutable
    /// A resource that is accessible by both the GPU (read only) and the CPU (write only).
    /// A dynamic resource is a good choice for a resource that will be updated by the CPU at least once per frame.
    case dynamic
    /// A resource that supports data transfer (copy) from the GPU to the CPU.
    case staging
}
