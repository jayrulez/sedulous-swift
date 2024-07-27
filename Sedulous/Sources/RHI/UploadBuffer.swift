import Foundation
import Synchronization

/// Protocol representing a strategy to fast upload buffers to GPU.
public protocol UploadBuffer: AnyObject {
    /// Pointer to the begin of the buffer.
    var dataBegin: UInt64 { get set }

    /// Pointer to the current buffer position.
    var dataCurrent: UInt64 { get set }

    /// Pointer to the end of the buffer.
    var dataEnd: UInt64 { get set }

    /// Number of batched buffers.
    var count: UInt64 { get set }

    /// The buffer alignment.
    var align: UInt32 { get set }

    /// The total size in bytes of the upload buffer.
    var totalSize: UInt64 { get set }

    /// The graphics context instance.
    var context: GraphicsContext { get }

    /// The mutex for thread safety.
    var bufferLock: Mutex<Int> { get }

    /// Initializes a new instance of the `UploadBuffer` protocol.
    init(context: GraphicsContext, size: UInt64, align: UInt32)

    /// Refresh the native buffer used by the upload buffer with the new size.
    /// - Parameter size: The new size of the buffer.
    func refreshBuffer(size: UInt64)

    /// Dispose all resources of this instance.
    func dispose()
}

public extension UploadBuffer {
    /// Allocate the new data in the upload buffer.
    /// - Parameter dataSize: The new data size.
    /// - Returns: The destination address to copy.
    func allocate(dataSize: UInt64) -> UInt64 {
        bufferLock.lock();
        defer { bufferLock.unlock(); }

        if dataSize > totalSize {
            if count != 0 {
                context.syncUpcopyQueue()
            }
            dispose()
            let newSize = MathHelper.nextPowerOfTwo(dataSize)
            refreshBuffer(size: newSize)
        }
        if dataCurrent + dataSize > dataEnd {
            context.syncUpcopyQueue()
        }
        if align != 0 {
            dataCurrent = Helpers.alignUp(align: align, value: dataCurrent)
        }
        let returnValue = dataCurrent
        dataCurrent += dataSize
        count += 1
        return returnValue
    }

    /// Reset all pointers of the upload buffer.
    func clear() {
        bufferLock.lock();
        defer { bufferLock.unlock(); }
        
        dataCurrent = dataBegin
        count = 0
    }

    /// Gets the native address data offset.
    /// - Parameter address: The address of data.
    /// - Returns: The address data offset.
    func calculateOffset(address: UInt64) -> UInt64 {
        if address < dataBegin || address > dataEnd {
            context.validationLayer.notify("UploadBuffer", "out of bounds")
        }
        return address - dataBegin
    }
}

public class MathHelper {
    public static func nextPowerOfTwo(_ x: UInt64) -> UInt64 {
        return 1 << (64 - (x - 1).leadingZeroBitCount)
    }
}

public class Helpers {
    public static func alignUp(align: UInt32, value: UInt64) -> UInt64 {
        return (value + UInt64(align) - 1) & ~(UInt64(align) - 1)
    }
}
