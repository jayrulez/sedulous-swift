import Foundation

/// Identifies how to bind a texture.
public struct TextureFlags: OptionSet, Hashable, Sendable {
    public let rawValue: UInt8

    /// No option.
    public static let none = TextureFlags([])
    /// A texture usable as a ShaderResourceView.
    public static let shaderResource = TextureFlags(rawValue: 1)
    /// A texture usable as render target.
    public static let renderTarget = TextureFlags(rawValue: 2)
    /// A texture usable as an unordered access buffer.
    public static let unorderedAccess = TextureFlags(rawValue: 4)
    /// A texture usable as a depth stencil buffer.
    public static let depthStencil = TextureFlags(rawValue: 8)
    /// Enables MIP map generation by GPU.
    public static let generateMipmaps = TextureFlags(rawValue: 0x10)

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}
