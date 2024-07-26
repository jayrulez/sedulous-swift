import Foundation

/// Identifies how to bind a texture.
struct TextureFlags: OptionSet, Hashable {
    let rawValue: UInt8

    /// No option.
    static let none = TextureFlags([])
    /// A texture usable as a ShaderResourceView.
    static let shaderResource = TextureFlags(rawValue: 1)
    /// A texture usable as render target.
    static let renderTarget = TextureFlags(rawValue: 2)
    /// A texture usable as an unordered access buffer.
    static let unorderedAccess = TextureFlags(rawValue: 4)
    /// A texture usable as a depth stencil buffer.
    static let depthStencil = TextureFlags(rawValue: 8)
    /// Enables MIP map generation by GPU.
    static let generateMipmaps = TextureFlags(rawValue: 0x10)

    init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}
