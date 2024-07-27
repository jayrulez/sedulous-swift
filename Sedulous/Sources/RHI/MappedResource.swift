import Foundation

/// The resource which has been mapped.
public struct MappedResource {
    /// The resource which has been mapped.
    public let resource: GraphicsResource

    /// Identifies the MapMode that was used to map the resource.
    public let mode: MapMode

    /// A pointer to the start of the mapped data region.
    public let data: UnsafeMutableRawPointer?

    /// The total size in bytes, of the mapped data region.
    public let sizeInBytes: UInt

    /// For Texture resources, this is the subresource which is mapped.
    /// For Buffer resources, this field has no meaning.
    public let subresourceIndex: UInt

    /// For Texture resources, this is the number of bytes between each row of texels.
    /// For Buffer resources, this field has no meaning.
    public let rowPitch: UInt

    /// For Texture resources, this is the number of bytes between each slice of a 3D texture.
    /// For Buffer resources, this field has no meaning.
    public let slicePitch: UInt

    /// Initializes a new instance of the MappedResource struct.
    /// - Parameters:
    ///   - resource: The resource which has been mapped.
    ///   - mode: The mapMode used to map the resource.
    ///   - data: A pointer to the start of the mapped data region.
    ///   - sizeInBytes: The total size in bytes, of the mapped data region.
    public init(resource: GraphicsResource, mode: MapMode, data: UnsafeMutableRawPointer?, sizeInBytes: UInt) {
        self.resource = resource
        self.mode = mode
        self.data = data
        self.sizeInBytes = sizeInBytes
        self.subresourceIndex = 0
        self.rowPitch = 0
        self.slicePitch = 0
    }

    /// Initializes a new instance of the MappedResource struct.
    /// - Parameters:
    ///   - resource: The resource which has been mapped.
    ///   - mode: The mapMode used to map the resource.
    ///   - data: A pointer to the start of the mapped data region.
    ///   - sizeInBytes: The total size in bytes, of the mapped data region.
    ///   - subResourceIndex: Index of the sub resource.
    ///   - rowPitch: The number of bytes per row.
    ///   - slicePitch: The number of bytes per slice.
    public init(resource: GraphicsResource, mode: MapMode, data: UnsafeMutableRawPointer?, sizeInBytes: UInt, subResourceIndex: UInt, rowPitch: UInt, slicePitch: UInt) {
        self.resource = resource
        self.mode = mode
        self.data = data
        self.sizeInBytes = sizeInBytes
        self.subresourceIndex = subResourceIndex
        self.rowPitch = rowPitch
        self.slicePitch = slicePitch
    }
}
