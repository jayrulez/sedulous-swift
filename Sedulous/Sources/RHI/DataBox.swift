import Foundation

/// Provides access to data organized in 3D.
public struct DataBox {
    /// Pointer to the data.
    public var dataPointer: UnsafeMutableRawPointer?
    
    /// Gets the number of bytes per row.
    public var rowPitch: UInt
    
    /// Gets the number of bytes per slice (for a 3D texture, a slice is a 2D image).
    public var slicePitch: UInt
    
    /// Gets a value indicating whether this instance is empty.
    public var isEmpty: Bool {
        return dataPointer == nil && rowPitch == 0 && slicePitch == 0
    }
    
    /// Initializes a new instance of the DataBox struct from an UnsafeMutableRawPointer.
    /// - Parameters:
    ///   - dataPointer: The data pointer.
    ///   - rowPitch: The row pitch.
    ///   - slicePitch: The slice pitch.
    public init(dataPointer: UnsafeMutableRawPointer?, rowPitch: UInt = 0, slicePitch: UInt = 0) {
        self.dataPointer = dataPointer
        self.rowPitch = rowPitch
        self.slicePitch = slicePitch
    }
    
    /// Initializes a new instance of the DataBox struct from a byte array.
    /// - Parameters:
    ///   - data: The data as byte array.
    ///   - rowPitch: The row pitch.
    ///   - slicePitch: The slice pitch.
    public init(data: [UInt8], rowPitch: UInt = 0, slicePitch: UInt = 0) {
        self.rowPitch = rowPitch
        self.slicePitch = slicePitch
        self.dataPointer = data.withUnsafeBytes { bytes in
            UnsafeMutableRawPointer(mutating: bytes.baseAddress)
        }
    }
    
    /// Dispose databox.
    public mutating func dispose() {
        dataPointer = nil
    }
}
