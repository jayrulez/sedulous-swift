import Foundation

/// Specifies `FrameBuffer` clearing modes.
public struct ClearFlags: OptionSet, Hashable, Sendable {
    public let rawValue: Int

    /// Do not clear.
    public static let none: ClearFlags = []
    /// Clear color target.
    public static let target = ClearFlags(rawValue: 1 << 0)
    /// Clear depth target.
    public static let depth = ClearFlags(rawValue: 1 << 1)
    /// Clear the stencil target.
    public static let stencil = ClearFlags(rawValue: 1 << 2)
    /// Clear color, depth and stencil target.
    public static let all: ClearFlags = [.target, .depth, .stencil]

    public init(rawValue: Int)
    {
        self.rawValue = rawValue;
    }
}
