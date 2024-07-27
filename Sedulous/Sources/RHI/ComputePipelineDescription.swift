import Foundation

/// Contains properties that describe the characteristics of a new pipeline state object.
public struct ComputePipelineDescription: Hashable, Equatable {
    /// Describes the resources layout input.
    public var resourceLayouts: [ResourceLayout]

    /// Gets or sets the compute shader program.
    public var shaderDescription: ComputeShaderStateDescription

    /// The X dimension of the thread group size.
    public var threadGroupSizeX: UInt

    /// The Y dimension of the thread group size.
    public var threadGroupSizeY: UInt

    /// The Z dimension of the thread group size.
    public var threadGroupSizeZ: UInt

    /// Initializes a new instance of the ComputePipelineDescription struct.
    /// - Parameters:
    ///   - resourceLayouts: The resources layout description.
    ///   - shaderDescription: The compute shader.
    ///   - threadGroupSizeX: The X dimension of the thread group size. Default is 1.
    ///   - threadGroupSizeY: The Y dimension of the thread group size. Default is 1.
    ///   - threadGroupSizeZ: The Z dimension of the thread group size. Default is 1.
    public init(resourceLayouts: [ResourceLayout], shaderDescription: ComputeShaderStateDescription, threadGroupSizeX: UInt = 1, threadGroupSizeY: UInt = 1, threadGroupSizeZ: UInt = 1) {
        self.resourceLayouts = resourceLayouts
        self.shaderDescription = shaderDescription
        self.threadGroupSizeX = threadGroupSizeX
        self.threadGroupSizeY = threadGroupSizeY
        self.threadGroupSizeZ = threadGroupSizeZ
    }

    /// Returns a hash value for this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(shaderDescription)
        hasher.combine(resourceLayouts.map { ObjectIdentifier($0) })
        hasher.combine(threadGroupSizeX)
        hasher.combine(threadGroupSizeY)
        hasher.combine(threadGroupSizeZ)
    }

    /// Determines whether the specified object is equal to this instance.
    public static func ==(lhs: ComputePipelineDescription, rhs: ComputePipelineDescription) -> Bool {
        return lhs.shaderDescription == rhs.shaderDescription &&
               lhs.resourceLayouts.map { ObjectIdentifier($0) } == rhs.resourceLayouts.map { ObjectIdentifier($0) } &&
               lhs.threadGroupSizeX == rhs.threadGroupSizeX &&
               lhs.threadGroupSizeY == rhs.threadGroupSizeY &&
               lhs.threadGroupSizeZ == rhs.threadGroupSizeZ
    }
}
