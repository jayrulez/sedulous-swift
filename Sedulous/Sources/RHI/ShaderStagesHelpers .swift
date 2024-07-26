import Foundation

/// Helpers for ShaderStages Enum.
public struct ShaderStagesHelpers {
    
    /// Gets the shader stages as array.
    public static let shaderStagesArray: [ShaderStages] = [
        .vertex,
        .hull,
        .domain,
        .geometry,
        .pixel,
        .compute,
        .rayGeneration
    ]

    /// Gets the shader stages count.
    public static let shaderStagesCount: Int = shaderStagesArray.count

    /// Gets the rasterization stages (Vertex, Hull, Domain, Geometry, Pixel and Compute).
    public static let rasterizationShaderStagesCount: Int = shaderStagesArray.count - 1

    /// Gets the shaderStage index.
    /// - Parameter stages: The shader stage.
    /// - Returns: The stage index.
    public static func indexOf(_ stages: ShaderStages) -> Int {
        switch stages {
        case .vertex:
            return 0
        case .hull:
            return 1
        case .domain:
            return 2
        case .geometry:
            return 3
        case .pixel:
            return 4
        case .compute:
            return 5
        case .rayGeneration:
            return 6
        default:
            return -1
        }
    }
}