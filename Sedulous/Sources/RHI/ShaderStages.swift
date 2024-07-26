import Foundation

/// Specifies the usage of a resource in shaders.
public struct ShaderStages: OptionSet, Hashable, Sendable {
    public let rawValue: Int16

    /// No stages.
    static let undefined = ShaderStages([])
    /// The vertex shader stage.
    static let vertex = ShaderStages(rawValue: 1)
    /// The hull shader stage.
    static let hull = ShaderStages(rawValue: 2)
    /// The domain shader stage.
    static let domain = ShaderStages(rawValue: 4)
    /// The geometry shader stage.
    static let geometry = ShaderStages(rawValue: 8)
    /// The pixel shader stage.
    static let pixel = ShaderStages(rawValue: 0x10)
    /// The compute shader stage.
    static let compute = ShaderStages(rawValue: 0x20)
    /// The Raytracing raygeneration shader stage.
    static let rayGeneration = ShaderStages(rawValue: 0x40)
    /// The Raytracing miss shader stage.
    static let miss = ShaderStages(rawValue: 0x80)
    /// The Raytracing closestHit shader stage.
    static let closestHit = ShaderStages(rawValue: 0x100)
    /// The Raytracing anyHit shader stage.
    static let anyHit = ShaderStages(rawValue: 0x200)
    /// The Raytracing intersection shader stage.
    static let intersection = ShaderStages(rawValue: 0x400)

    public init(rawValue: Int16) {
        self.rawValue = rawValue
    }
}
