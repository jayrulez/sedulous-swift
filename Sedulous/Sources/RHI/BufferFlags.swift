import Foundation

/// Identifies how to bind a buffer.
public struct BufferFlags: OptionSet, Hashable, Sendable {
    public let rawValue: Int

    /// No option.
    public static let none: BufferFlags = []
    /// Bind a buffer as a vertex buffer to the input-assembler stage.
    public static let vertexBuffer = BufferFlags(rawValue: 1 << 0)
    /// Bind a buffer as an index buffer to the input-assembler stage.
    public static let indexBuffer = BufferFlags(rawValue: 1 << 1)
    /// Bind a buffer as a constant buffer to a shader stage. This flag may NOT be combined with any other bind flag.
    public static let constantBuffer = BufferFlags(rawValue: 1 << 2)
    /// Bind a buffer or texture to a shader stage.
    public static let shaderResource = BufferFlags(rawValue: 1 << 3)
    /// Bind a buffer to be used in a raytracing stage.
    public static let accelerationStructure = BufferFlags(rawValue: 1 << 4)
    /// Bind a texture as a render target for the output-merger stage.
    public static let renderTarget = BufferFlags(rawValue: 1 << 5)
    /// Bind an unordered access resource.
    public static let unorderedAccess = BufferFlags(rawValue: 1 << 6)
    /// Enables a resource as a structured buffer.
    public static let bufferStructured = BufferFlags(rawValue: 1 << 7)
    /// Indirect Buffer.
    public static let indirectBuffer = BufferFlags(rawValue: 1 << 8)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
