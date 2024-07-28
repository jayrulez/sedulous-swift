import Foundation

/// The index data format.
public enum IndexFormat: UInt8, Sendable {
    /// Unsigned 16 bits integer format.
    case uint16
    /// Unsigned 32 bits integer format.
    case uint32
}
