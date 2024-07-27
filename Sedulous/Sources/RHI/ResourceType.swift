import Foundation

/// The shader resource type.
public enum ResourceType: UInt8 {
    /// A `Buffer` accessed as a uniform buffer.
    case constantBuffer
    /// A `Buffer` accessed as a read-only storage buffer.
    case structuredBuffer
    /// A `Buffer` accessed as a read-write storage buffer.
    case structuredBufferReadWrite
    /// A read-only `Texture`.
    case texture
    /// A read-write `Texture`.
    case textureReadWrite
    /// A `SamplerState`.
    case sampler
    /// A raytracing acceleration structure.
    case accelerationStructure
}
