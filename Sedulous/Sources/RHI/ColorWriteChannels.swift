import Foundation

/// Identify which components of each pixel of a render target are writable during blending.
struct ColorWriteChannels: OptionSet, Hashable {
    let rawValue: Int

    /// None of the data are stored.
    static let none: ColorWriteChannels = []
    /// Allow data to be stored in the red component.
    static let red = ColorWriteChannels(rawValue: 1 << 0)
    /// Allow data to be stored in the green component.
    static let green = ColorWriteChannels(rawValue: 1 << 1)
    /// Allow data to be stored in the blue component.
    static let blue = ColorWriteChannels(rawValue: 1 << 2)
    /// Allow data to be stored in the alpha component.
    static let alpha = ColorWriteChannels(rawValue: 1 << 3)
    /// Allow data to be stored in all components.
    static let all: ColorWriteChannels = [.red, .green, .blue, .alpha]
}