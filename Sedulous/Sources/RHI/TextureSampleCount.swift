import Foundation

/// Describes the number of samples to use in a `Texture`.
public enum TextureSampleCount: UInt8 {
    /// No multisample.
    case none
    /// Multisample count of 2 pixels.
    case count2
    /// Multisample count of 4 pixels.
    case count4
    /// Multisample count of 8 pixels.
    case count8
    /// Multisample count of 16 pixels.
    case count16
    /// Multisample count of 32 pixels.
    case count32
}
