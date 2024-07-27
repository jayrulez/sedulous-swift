import Foundation

public struct ClearValue: Hashable, Equatable {
    /// The array of color clear value to use when clearing each color attachment.
    public var colorValues: [SIMD4<Float>]

    /// The depth clear value to use when clearing a depth/stencil attachment.
    public var depth: Float

    /// The stencil clear value to use when clearing a depth/stencil attachment.
    public var stencil: UInt8

    /// Kind of clear to perform
    public var flags: ClearFlags

    /// Gets default values for None clear value.
    public static var none: ClearValue {
        return ClearValue(flags: .none, colorValues: [])
    }

    /// Gets default values for clear value.
    /// <remarks>That mean one ColorAttachment using CornflowerBlue as clear color and depth = 1 / stencil = 0.</remarks>
    public static var `default`: ClearValue {
        return ClearValue(flags: .all, depth: 1.0, stencil: 0, colorValues: [Color.cornflowerBlue.toVector4()])
    }

    /// Initializes a new instance of the `ClearValue` struct.
    /// - Parameters:
    ///   - flags: Identify the textures to clear.
    ///   - colorValues: The array of values to clear the color attachments.
    public init(flags: ClearFlags, colorValues: [Color]) {
        self.init(flags: flags, depth: 1.0, stencil: 0, colorValues: colorValues)
    }

    /// Initializes a new instance of the `ClearValue` struct.
    /// - Parameters:
    ///   - flags: Identify the textures to clear.
    ///   - colorValue: The value to clear the color attachment.
    public init(flags: ClearFlags, colorValue: Color) {
        self.init(flags: flags, depth: 1.0, stencil: 0, colorValue: colorValue)
    }

    /// Initializes a new instance of the `ClearValue` struct.
    /// - Parameters:
    ///   - flags: Identify the textures to clear.
    ///   - colorValues: The array of values to clear the color attachments.
    public init(flags: ClearFlags, colorValues: [SIMD4<Float>]) {
        self.init(flags: flags, depth: 1.0, stencil: 0, colorValues: colorValues)
    }

    /// Initializes a new instance of the `ClearValue` struct.
    /// - Parameters:
    ///   - flags: Identify the textures to clear.
    ///   - depth: The value to clear the depth buffer.
    ///   - stencil: The value to clear the stencil buffer.
    ///   - colorValues: The array of values to clear the color attachments.
    public init(flags: ClearFlags, depth: Float, stencil: UInt8, colorValues: [Color]) {
        self.flags = flags
        self.depth = depth
        self.stencil = stencil
        self.colorValues = colorValues.map { $0.toVector4() }
    }

    /// Initializes a new instance of the `ClearValue` struct.
    /// - Parameters:
    ///   - flags: Identify the textures to clear.
    ///   - depth: The value to clear the depth buffer.
    ///   - stencil: The value to clear the stencil buffer.
    ///   - colorValue: The value to clear the color attachment.
    public init(flags: ClearFlags, depth: Float, stencil: UInt8, colorValue: Color) {
        self.flags = flags
        self.depth = depth
        self.stencil = stencil
        self.colorValues = [colorValue.toVector4()]
    }

    /// Initializes a new instance of the `ClearValue` struct.
    /// - Parameters:
    ///   - flags: Identify the textures to clear.
    ///   - depth: The value to clear the depth buffer.
    ///   - stencil: The value to clear the stencil buffer.
    ///   - colorValues: The array of values to clear the color attachments.
    public init(flags: ClearFlags, depth: Float, stencil: UInt8, colorValues: [SIMD4<Float>]) {
        self.flags = flags
        self.depth = depth
        self.stencil = stencil
        self.colorValues = colorValues
    }

    public static func ==(lhs: ClearValue, rhs: ClearValue) -> Bool {
        return lhs.flags == rhs.flags &&
            lhs.colorValues == rhs.colorValues &&
            lhs.depth == rhs.depth &&
            lhs.stencil == rhs.stencil
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(flags)
        hasher.combine(colorValues)
        hasher.combine(depth)
        hasher.combine(stencil)
    }
}