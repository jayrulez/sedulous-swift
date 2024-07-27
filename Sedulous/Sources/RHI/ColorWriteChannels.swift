import Foundation

/// Identify which components of each pixel of a render target are writable during blending.
public struct ColorWriteChannels: OptionSet, Hashable, Sendable {
    public let rawValue: Int

    /// None of the data are stored.
    public static let none: ColorWriteChannels = []
    /// Allow data to be stored in the red component.
    public static let red = ColorWriteChannels(rawValue: 1 << 0)
    /// Allow data to be stored in the green component.
    public static let green = ColorWriteChannels(rawValue: 1 << 1)
    /// Allow data to be stored in the blue component.
    public static let blue = ColorWriteChannels(rawValue: 1 << 2)
    /// Allow data to be stored in the alpha component.
    public static let alpha = ColorWriteChannels(rawValue: 1 << 3)
    /// Allow data to be stored in all components.
    public static let all: ColorWriteChannels = [.red, .green, .blue, .alpha]

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}