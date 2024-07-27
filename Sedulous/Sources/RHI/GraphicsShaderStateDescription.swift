import Foundation

/// This struct contains all the shader stages.
public struct GraphicsShaderStateDescription: Equatable, Hashable {
    /// ConstantBuffers bindings.
    /// Used in OpenGL 410 or minor and OpenGLES 300 or minor.
    public var constantBuffersBindings: [(name: String, slot: UInt)]

    /// Textures bindings.
    /// Used in OpenGL 410 or minor and OpenGLES 300 or minor.
    public var texturesBindings: [(name: String, slot: UInt)]

    /// Gets or sets the vertex shader program.
    public var vertexShader: Shader?

    /// Gets or sets the hull shader program.
    public var hullShader: Shader?

    /// Gets or sets the domain shader program.
    public var domainShader: Shader?

    /// Gets or sets the geometry shader program.
    public var geometryShader: Shader?

    /// Gets or sets the pixel shader program.
    public var pixelShader: Shader?

    /// Represents a relationship between semantics and shader locations.
    public var shaderInputLayout: InputLayouts?

    /// Initializes a new instance of the `GraphicsShaderStateDescription` struct.
    /// - Parameters:
    ///   - constantBuffersBindings: The constant buffers bindings.
    ///   - texturesBindings: The textures bindings.
    ///   - vertexShader: The vertex shader.
    ///   - hullShader: The hull shader.
    ///   - domainShader: The domain shader.
    ///   - geometryShader: The geometry shader.
    ///   - pixelShader: The pixel shader.
    ///   - shaderInputLayout: The shader input layout.
    public init(
        constantBuffersBindings: [(name: String, slot: UInt)] = [],
        texturesBindings: [(name: String, slot: UInt)] = [],
        vertexShader: Shader? = nil,
        hullShader: Shader? = nil,
        domainShader: Shader? = nil,
        geometryShader: Shader? = nil,
        pixelShader: Shader? = nil,
        shaderInputLayout: InputLayouts? = nil
    ) {
        self.constantBuffersBindings = constantBuffersBindings
        self.texturesBindings = texturesBindings
        self.vertexShader = vertexShader
        self.hullShader = hullShader
        self.domainShader = domainShader
        self.geometryShader = geometryShader
        self.pixelShader = pixelShader
        self.shaderInputLayout = shaderInputLayout
    }

    /// Equatable conformance.
    public static func == (lhs: GraphicsShaderStateDescription, rhs: GraphicsShaderStateDescription) -> Bool {
        return lhs.vertexShader === rhs.vertexShader &&
            lhs.hullShader === rhs.hullShader &&
            lhs.domainShader === rhs.domainShader &&
            lhs.geometryShader === rhs.geometryShader &&
            lhs.pixelShader === rhs.pixelShader
    }

    /// Hashable conformance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(vertexShader.map(ObjectIdentifier.init)?.hashValue ?? 0)
        hasher.combine(hullShader.map(ObjectIdentifier.init)?.hashValue ?? 0)
        hasher.combine(domainShader.map(ObjectIdentifier.init)?.hashValue ?? 0)
        hasher.combine(geometryShader.map(ObjectIdentifier.init)?.hashValue ?? 0)
        hasher.combine(pixelShader.map(ObjectIdentifier.init)?.hashValue ?? 0)
    }
}
