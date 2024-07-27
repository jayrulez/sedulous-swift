import Foundation

/// Struct containing the sub resource info.
public struct SubResourceInfo {
    /// The size in bytes.
    public var sizeInBytes: UInt

    /// The offset.
    public var offset: UInt64

    /// The row pitch.
    public var rowPitch: UInt

    /// The slice pitch.
    public var slicePitch: UInt

    /// The mip width.
    public var mipWidth: UInt

    /// The mip height.
    public var mipHeight: UInt

    /// The mip depth.
    public var mipDepth: UInt

    /// The mip level.
    public var mipLevel: UInt

    /// The array layer.
    public var arrayLayer: UInt

    /// Initializes a new instance of the `SubResourceInfo` struct.
    /// - Parameters:
    ///   - sizeInBytes: The size in bytes.
    ///   - offset: The offset.
    ///   - rowPitch: The row pitch.
    ///   - slicePitch: The slice pitch.
    ///   - mipWidth: The mip width.
    ///   - mipHeight: The mip height.
    ///   - mipDepth: The mip depth.
    ///   - mipLevel: The mip level.
    ///   - arrayLayer: The array layer.
    public init(sizeInBytes: UInt, offset: UInt64, rowPitch: UInt, slicePitch: UInt, mipWidth: UInt, mipHeight: UInt, mipDepth: UInt, mipLevel: UInt, arrayLayer: UInt) {
        self.sizeInBytes = sizeInBytes
        self.offset = offset
        self.rowPitch = rowPitch
        self.slicePitch = slicePitch
        self.mipWidth = mipWidth
        self.mipHeight = mipHeight
        self.mipDepth = mipDepth
        self.mipLevel = mipLevel
        self.arrayLayer = arrayLayer
    }
}
