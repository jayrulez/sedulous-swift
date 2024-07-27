import Foundation

/// This struct contains all the shader stages.
public struct ComputeShaderStateDescription: Equatable, Hashable {
    /// ConstantBuffers bindings.
    /// Used in OpenGL 410 or minor and OpenGLES 300 or minor.
    public var constantBuffersBindings: [(name: String, slot: UInt)]

    /// Textures bindings.
    /// Used in OpenGL 410 or minor and OpenGLES 300 or minor.
    public var texturesBindings: [(name: String, slot: UInt)]

    /// Gets or sets the compute shader program.
    public var computeShader: Shader?

    /// Initializes a new instance of the `ComputeShaderStateDescription` struct.
    /// - Parameters:
    ///   - constantBuffersBindings: The constant buffers bindings.
    ///   - texturesBindings: The textures bindings.
    ///   - computeShader: The compute shader.
    public init(
        constantBuffersBindings: [(name: String, slot: UInt)] = [],
        texturesBindings: [(name: String, slot: UInt)] = [],
        computeShader: Shader? = nil
    ) {
        self.constantBuffersBindings = constantBuffersBindings
        self.texturesBindings = texturesBindings
        self.computeShader = computeShader
    }

    /// Equatable conformance.
    public static func == (lhs: ComputeShaderStateDescription, rhs: ComputeShaderStateDescription) -> Bool {
        return lhs.computeShader === rhs.computeShader
    }

    /// Hashable conformance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(computeShader.map(ObjectIdentifier.init)?.hashValue ?? 0)
    }
}
