import Foundation

/// Specifies `FrameBuffer` clearing modes.
struct ClearFlags: OptionSet, Hashable {
    let rawValue: Int

    /// Do not clear.
    static let none: ClearFlags = []
    /// Clear color target.
    static let target = ClearFlags(rawValue: 1 << 0)
    /// Clear depth target.
    static let depth = ClearFlags(rawValue: 1 << 1)
    /// Clear the stencil target.
    static let stencil = ClearFlags(rawValue: 1 << 2)
    /// Clear color, depth and stencil target.
    static let all: ClearFlags = [.target, .depth, .stencil]
}
