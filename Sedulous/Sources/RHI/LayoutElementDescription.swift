import Foundation

/// This struct represents a shader resource binding.
public struct LayoutElementDescription: Equatable, Hashable {
    
    /// The resource slot.
    public let slot: UInt
    
    /// The shader resource type.
    public let type: ResourceType
    
    /// The resource shader stage.
    public let stages: ShaderStages
    
    /// A value indicating whether this resource allows dynamic offset. It's used in some graphics backends to allow specifying dynamic offset.
    public let allowDynamicOffset: Bool
    
    /// If it is greater than 0, it overrides the size of this resource (in bytes). Only valid on Constant Buffers.
    public let range: UInt
    
    /// Initializes a new instance of the `LayoutElementDescription` struct.
    /// - Parameters:
    ///   - slot: The resource slot.
    ///   - type: The resource type.
    ///   - stages: The stages where this resource will be available.
    ///   - allowDynamicOffset: Allows specifying dynamic offset. Only valid on Constant Buffers.
    ///   - size: If it is greater than 0, it overrides the size of this resource (in bytes). Only valid on Constant Buffers.
    public init(slot: UInt, type: ResourceType, stages: ShaderStages, allowDynamicOffset: Bool = false, size: UInt = 0) {
        self.slot = slot
        self.type = type
        self.stages = stages
        self.allowDynamicOffset = allowDynamicOffset
        self.range = size
    }
    
    // Equatable
    public static func == (lhs: LayoutElementDescription, rhs: LayoutElementDescription) -> Bool {
        return lhs.slot == rhs.slot && lhs.type == rhs.type && lhs.stages == rhs.stages
    }
    
    // Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(slot)
        hasher.combine(type)
        hasher.combine(stages)
    }
}
