import Foundation

/// Describes a 2D texture.
public struct TextureDescription: Equatable, Hashable {
    /// Texture type `TextureType`.
    public var type: TextureType
    /// Texture format `PixelFormat`.
    public var format: PixelFormat
    /// Texture width (in texels).
    public var width: UInt
    /// Texture height (in texels).
    public var height: UInt
    /// Texture depth (in texels).
    public var depth: UInt
    /// Number of textures in the texture array.
    public var arraySize: UInt
    /// Number of texture faces useful in TextureCube and TextureCubeArray.
    public var faces: UInt
    /// The maximum number of mipmap levels in the texture.
    public var mipLevels: UInt
    /// The texture flags `TextureFlags`.
    public var flags: TextureFlags
    /// Value that identifies how the texture is to be read from and written to.
    public var usage: ResourceUsage
    /// The number of samples in this texture.
    public var sampleCount: TextureSampleCount
    /// Flags `ResourceCpuAccess` to specify the type of CPU access allowed.
    public var cpuAccess: ResourceCpuAccess

    private static var defaultValues: TextureDescription {
        return TextureDescription(
            type: .texture2D,
            format: .R8G8B8A8_UNorm,
            width: 1,
            height: 1,
            depth: 1,
            arraySize: 1,
            faces: 1,
            mipLevels: 1,
            flags: .shaderResource,
            usage: .default,
            sampleCount: .none,
            cpuAccess: .none
        )
    }

    /// Create a Texture 1D description.
    /// - Parameters:
    ///   - width: The texture width.
    ///   - format: The texture format.
    /// - Returns: The new texture 1D description.
    public static func createTexture1DDescription(width: UInt, format: PixelFormat = .R8G8B8A8_UNorm) -> TextureDescription {
        var description = defaultValues
        description.type = .texture1D
        description.width = width
        description.format = format
        return description
    }

    /// Create a Texture 2D description.
    /// - Parameters:
    ///   - width: The texture width.
    ///   - height: The texture height.
    ///   - format: The texture format.
    /// - Returns: The new texture 2D description.
    public static func createTexture2DDescription(width: UInt, height: UInt, format: PixelFormat = .R8G8B8A8_UNorm) -> TextureDescription {
        var description = defaultValues
        description.type = .texture2D
        description.width = width
        description.height = height
        description.format = format
        return description
    }

    /// Create a Texture 3D description.
    /// - Parameters:
    ///   - width: The texture width.
    ///   - height: The texture height.
    ///   - depth: The texture depth.
    ///   - format: The texture format.
    /// - Returns: The new texture 3D description.
    public static func createTexture3DDescription(width: UInt, height: UInt, depth: UInt, format: PixelFormat = .R8G8B8A8_UNorm) -> TextureDescription {
        var description = defaultValues
        description.type = .texture3D
        description.width = width
        description.height = height
        description.depth = depth
        description.format = format
        return description
    }

    /// Create a Texture cube description.
    /// - Parameters:
    ///   - width: The texture width.
    ///   - height: The texture height.
    ///   - format: The texture format.
    /// - Returns: The new texture cube description.
    public static func createTextureCubeDescription(width: UInt, height: UInt, format: PixelFormat = .R8G8B8A8_UNorm) -> TextureDescription {
        var description = defaultValues
        description.type = .textureCube
        description.width = width
        description.height = height
        description.format = format
        return description
    }

    public static func ==(lhs: TextureDescription, rhs: TextureDescription) -> Bool {
        return lhs.type == rhs.type &&
               lhs.format == rhs.format &&
               lhs.width == rhs.width &&
               lhs.height == rhs.height &&
               lhs.depth == rhs.depth &&
               lhs.arraySize == rhs.arraySize &&
               lhs.faces == rhs.faces &&
               lhs.mipLevels == rhs.mipLevels &&
               lhs.flags == rhs.flags &&
               lhs.usage == rhs.usage &&
               lhs.sampleCount == rhs.sampleCount &&
               lhs.cpuAccess == rhs.cpuAccess
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(format)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(depth)
        hasher.combine(arraySize)
        hasher.combine(faces)
        hasher.combine(mipLevels)
        hasher.combine(flags)
        hasher.combine(usage)
        hasher.combine(sampleCount)
        hasher.combine(cpuAccess)
    }
}
