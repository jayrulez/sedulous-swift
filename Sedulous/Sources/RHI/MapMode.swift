import Foundation

/// Identifies how a graphics resource will be mapped into CPU address space.
public enum MapMode: UInt8 {
    /// A read-only resource mapping. The mapped data region is not writable, and cannot be used to transfer data into the graphics resource.
    case read
    /// A write-only resource mapping. The mapped data region is writable, and will be transferred into the graphics resource
    /// when `GraphicsContext.unmapMemory(_ resource: GraphicsResource, _ subresource: UInt32)` is called.
    case write
    /// A read-write resource mapping. The mapped data region is both readable and writable.
    case readWrite
}
