import Foundation

/// Contains properties that describe the characteristics of a new pipeline state object.
public struct GraphicsPipelineDescription: Equatable, Hashable {
    /// The render state description.
    public var renderStates: RenderStateDescription

    /// The shader state description.
    public var shaders: GraphicsShaderStateDescription

    /// Describes the input vertex buffer data.
    public var inputLayouts: InputLayouts

    /// Describes the resource layouts input array.
    public var resourceLayouts: [ResourceLayout]

    /// Define how vertices are interpreted and rendered by the pipeline.
    public var primitiveTopology: PrimitiveTopology

    /// A description of the output attachments used by the `GraphicsPipelineState`.
    public var outputs: OutputDescription

    /// Initializes a new instance of the `GraphicsPipelineDescription` struct.
    /// - Parameters:
    ///   - primitiveTopology: Define how vertices are interpreted and rendered by the pipeline.
    ///   - inputLayouts: Describes the input vertex buffer data.
    ///   - resourceLayouts: The resource layouts array.
    ///   - shaders: The shader state description.
    ///   - renderStates: The render state description.
    ///   - outputs: Description of the output attachments.
    public init(primitiveTopology: PrimitiveTopology, inputLayouts: InputLayouts, resourceLayouts: [ResourceLayout], shaders: GraphicsShaderStateDescription, renderStates: RenderStateDescription, outputs: OutputDescription) {
        self.primitiveTopology = primitiveTopology
        self.inputLayouts = inputLayouts
        self.resourceLayouts = resourceLayouts
        self.shaders = shaders
        self.renderStates = renderStates
        self.outputs = outputs
    }

    /// Equatable conformance.
    public static func == (lhs: GraphicsPipelineDescription, rhs: GraphicsPipelineDescription) -> Bool {
        func areIdentical(_ lhs: [ResourceLayout], _ rhs: [ResourceLayout]) -> Bool {
            guard lhs.count == rhs.count else {
                return false
            }
            for (lhsElement, rhsElement) in zip(lhs, rhs) {
                if lhsElement !== rhsElement {
                    return false
                }
            }
            return true
        }

        return lhs.primitiveTopology == rhs.primitiveTopology &&
               lhs.inputLayouts == rhs.inputLayouts &&
               areIdentical(lhs.resourceLayouts, rhs.resourceLayouts) &&
               lhs.shaders == rhs.shaders &&
               lhs.renderStates == rhs.renderStates &&
               lhs.outputs == rhs.outputs
    }

    /// Hashable conformance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(primitiveTopology)
        hasher.combine(inputLayouts)
        //hasher.combine(resourceLayouts)
        resourceLayouts.forEach { hasher.combine(ObjectIdentifier($0).hashValue) }
        hasher.combine(shaders)
        hasher.combine(renderStates)
        hasher.combine(outputs)
    }
}
