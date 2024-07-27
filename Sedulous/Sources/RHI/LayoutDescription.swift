import Foundation

/// A generic description of vertex inputs to the device's input assembler stage.
/// This object describes the inputs from a single vertex buffer.
/// Shaders may use inputs from multiple vertex buffers.
public class LayoutDescription: Equatable, Hashable {
    
    /// The collection of individual vertex elements comprising a single vertex.
    public var elements: [ElementDescription]
    
    /// The frequency with which the vertex function fetches attributes data.
    public var stepFunction: VertexStepFunction
    
    /// A value controlling how often data for instances is advanced for this layout. For per-vertex elements, this value should be 0.
    public var stepRate: Int
    
    /// The total size of an individual vertex in bytes.
    public var stride: UInt
    
    /// Initializes a new instance of the `LayoutDescription` class.
    /// - Parameters:
    ///   - stepFunction: The frequency with which the vertex function fetches attributes data.
    ///   - stepRate: The number of instances to draw using the same per-instance data before advancing in the buffer by one element.
    public init(stepFunction: VertexStepFunction = .perVertexData, stepRate: UInt = 0) {
        self.stepFunction = stepFunction
        self.stepRate = Int(stepRate)
        self.stride = 0
        self.elements = []
    }
    
    /// Adds a new `ElementDescription` to layout.
    /// - Parameter element: The element description.
    /// - Returns: The current instance.
    @discardableResult
    public func add(element: ElementDescription) -> LayoutDescription {
        var newElement = element
        if newElement.offset == -1 {
            newElement.offset = Int(stride)
        }
        elements.append(newElement)
        stride += LayoutDescription.getFormatSizeInBytes(format: newElement.format)
        return self
    }
    
    /// Get the size in bytes of a specific vertex element format.
    /// - Parameter format: The vertex element format.
    /// - Returns: The size in bytes.
    public static func getFormatSizeInBytes(format: ElementFormat) -> UInt {
        switch format {
        case .uByte, .byte, .uByteNormalized, .byteNormalized:
            return 1
        case .uByte2, .byte2, .uByte2Normalized, .byte2Normalized, .uShort, .short, .uShortNormalized, .shortNormalized:
            return 2
        case .uByte4, .byte4, .uByte4Normalized, .byte4Normalized, .uShort2, .short2, .uShort2Normalized, .short2Normalized, .half2, .float, .uInt, .int:
            return 4
        case .uShort4, .short4, .uShort4Normalized, .short4Normalized, .half4, .float2:
            return 8
        case .float3:
            return 12
        case .float4:
            return 16
        default:
            fatalError("Unsupported ElementFormat.")
        }
    }
    
    // Equatable
    public static func == (lhs: LayoutDescription, rhs: LayoutDescription) -> Bool {
        return lhs.elements == rhs.elements &&
               lhs.stepFunction == rhs.stepFunction &&
               lhs.stepRate == rhs.stepRate &&
               lhs.stride == rhs.stride
    }
    
    // Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(elements)
        hasher.combine(stepFunction)
        hasher.combine(stepRate)
        hasher.combine(stride)
    }
}
