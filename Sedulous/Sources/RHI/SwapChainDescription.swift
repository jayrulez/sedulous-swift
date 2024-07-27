import Foundation

/// Represents the required information to create a new swap chain depending on the platform.
public struct SwapChainDescription: Equatable, Hashable {
    /// Surface information.
    public var surfaceInfo: SurfaceInfo
    /// The swap chain buffers width.
    public var width: UInt
    /// The swap chain buffers height.
    public var height: UInt
    /// The refresh rate.
    public var refreshRate: UInt
    /// The pixel format of the color target.
    public var colorTargetFormat: PixelFormat
    /// The color texture flags for binding to pipeline stages. The flags can be combined by a logical OR.
    public var colorTargetFlags: TextureFlags
    /// The pixel format of the depth stencil target.
    public var depthStencilTargetFormat: PixelFormat
    /// The depth texture flags for binding to pipeline stages. The flags can be combined by a logical OR.
    public var depthStencilTargetFlags: TextureFlags
    /// The sample count of this swap chain.
    public var sampleCount: TextureSampleCount
    /// Whether the output is in windowed mode.
    public var isWindowed: Bool

    public init(surfaceInfo: SurfaceInfo, width: UInt, height: UInt, refreshRate: UInt, colorTargetFormat: PixelFormat, colorTargetFlags: TextureFlags, depthStencilTargetFormat: PixelFormat, depthStencilTargetFlags: TextureFlags, sampleCount: TextureSampleCount, isWindowed: Bool) {
        self.surfaceInfo = surfaceInfo
        self.width = width
        self.height = height
        self.refreshRate = refreshRate
        self.colorTargetFormat = colorTargetFormat
        self.colorTargetFlags = colorTargetFlags
        self.depthStencilTargetFormat = depthStencilTargetFormat
        self.depthStencilTargetFlags = depthStencilTargetFlags
        self.sampleCount = sampleCount
        self.isWindowed = isWindowed
    }

    public static func ==(lhs: SwapChainDescription, rhs: SwapChainDescription) -> Bool {
        return lhs.surfaceInfo == rhs.surfaceInfo &&
               lhs.width == rhs.width &&
               lhs.height == rhs.height &&
               lhs.refreshRate == rhs.refreshRate &&
               lhs.colorTargetFormat == rhs.colorTargetFormat &&
               lhs.colorTargetFlags == rhs.colorTargetFlags &&
               lhs.depthStencilTargetFormat == rhs.depthStencilTargetFormat &&
               lhs.depthStencilTargetFlags == rhs.depthStencilTargetFlags &&
               lhs.sampleCount == rhs.sampleCount &&
               lhs.isWindowed == rhs.isWindowed
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(surfaceInfo)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(refreshRate)
        hasher.combine(colorTargetFormat)
        hasher.combine(colorTargetFlags)
        hasher.combine(depthStencilTargetFormat)
        hasher.combine(depthStencilTargetFlags)
        hasher.combine(sampleCount)
        hasher.combine(isWindowed)
    }
}
