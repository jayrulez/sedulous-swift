import Foundation

/// Custom Rectangle struct
public struct Rectangle: Equatable, Hashable, Sendable {
    public var x: Float
    public var y: Float
    public var width: Float
    public var height: Float

    public init(x: Float, y: Float, width: Float, height: Float) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}

/// Abstracts a viewport used for defining rendering regions.
public struct Viewport: Equatable, Hashable, Sendable {
    /// Empty value for an undefined viewport.
    public static let empty = Viewport()

    /// The default viewport width.
    public nonisolated(unsafe) static var defaultWidth: Float = 0.0

    /// The default viewport height.
    public nonisolated(unsafe) static var defaultHeight: Float = 0.0

    /// Gets or sets the X origin of the viewport.
    public var x: Float

    /// Gets or sets the Y origin of the viewport.
    public var y: Float

    /// Gets or sets the width of the viewport.
    public var width: Float

    /// Gets or sets the height of the viewport.
    public var height: Float

    /// Gets or sets the min depth range.
    public var minDepth: Float

    /// Gets or sets the max depth range.
    public var maxDepth: Float

    /// Gets the aspect ratio used of this viewport.
    public var aspectRatio: Float {
        if width != 0 && height != 0 {
            return width / height
        }
        return 0
    }

    /// Gets the size of the viewport.
    public var size: SIMD2<Float> {
        return SIMD2(width, height)
    }

    /// Gets the rectangle of the viewport.
    public var bounds: Rectangle {
        return Rectangle(x: x, y: y, width: width, height: height)
    }

    /// Initializes a new instance of the `Viewport` struct.
    /// - Parameters:
    ///   - x: The x.
    ///   - y: The y.
    ///   - width: The width.
    ///   - height: The height.
    ///   - minDepth: The minimum depth range.
    ///   - maxDepth: The maximum depth range.
    public init(x: Float = 0, y: Float = 0, width: Float = 0, height: Float = 0, minDepth: Float = 0, maxDepth: Float = 1) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
        self.minDepth = minDepth
        self.maxDepth = maxDepth
    }

    /// Initializes a new instance of the `Viewport` struct.
    /// - Parameters:
    ///   - rectangle: The viewport rectangle.
    ///   - minDepth: The minimum depth range.
    ///   - maxDepth: The maximum depth range.
    public init(rectangle: Rectangle, minDepth: Float = 0, maxDepth: Float = 1) {
        self.x = rectangle.x
        self.y = rectangle.y
        self.width = rectangle.width
        self.height = rectangle.height
        self.minDepth = minDepth
        self.maxDepth = maxDepth
    }

    /// Determines whether the specified object is equal to this instance.
    public static func == (lhs: Viewport, rhs: Viewport) -> Bool {
        return lhs.x == rhs.x &&
            lhs.y == rhs.y &&
            lhs.width == rhs.width &&
            lhs.height == rhs.height &&
            lhs.minDepth == rhs.minDepth &&
            lhs.maxDepth == rhs.maxDepth
    }

    /// Returns a hash code for this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(minDepth)
        hasher.combine(maxDepth)
    }
}
