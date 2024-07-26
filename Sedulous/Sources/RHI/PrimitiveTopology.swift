import Foundation

/// How the pipeline interprets vertex data that is bound to the input-assembler stage.
/// These primitive topology values determine how the vertex data is rendered on screen.
enum PrimitiveTopology: UInt8 {
    /// The IA stage has not been initialized with a primitive topology.
    case undefined = 0
    /// Interpret the vertex data as a list of points.
    case pointList = 1
    /// Interpret the vertex data as a list of lines.
    case lineList = 2
    /// Interpret the vertex data as a line strip.
    case lineStrip = 3
    /// Interpret the vertex data as a list of triangles.
    case triangleList = 4
    /// Interpret the vertex data as a triangle strip.
    case triangleStrip = 5
    /// Interpret the vertex data as a list of lines with adjacency data.
    case lineListWithAdjacency = 10
    /// Interpret the vertex data as a line strip with adjacency data.
    case lineStripWithAdjacency = 11
    /// Interpret the vertex data as a list of triangles with adjacency data.
    case triangleListWithAdjacency = 12
    /// Interpret the vertex data as a triangle strip with adjacency data.
    case triangleStripWithAdjacency = 13
    /// Interpret the vertex data as a patch list.
    case patchList = 33
}

/// Helper methods for primitive topology.
extension PrimitiveTopology {
    /// Convert index count to primitive count.
    /// - Parameter elementCount: The index count.
    /// - Returns: The primitive count.
    func toPrimitiveCount(elementCount: Int) -> Int {
        switch self {
        case .lineList:
            return elementCount / 2
        case .lineListWithAdjacency:
            return elementCount / 4
        case .lineStrip:
            return elementCount - 1
        case .lineStripWithAdjacency:
            return elementCount - 3
        case .triangleList:
            return elementCount / 3
        case .triangleListWithAdjacency:
            return elementCount / 6
        case .triangleStrip:
            return elementCount - 2
        case .triangleStripWithAdjacency:
            return (elementCount - 1) / 2
        default:
            fatalError("Primitive topology \(self) not supported.")
        }
    }

    /// Convert primitive count to index count.
    /// - Parameter primitiveCount: The primitive count.
    /// - Returns: The index count.
    func toIndexCount(primitiveCount: Int) -> Int {
        switch self {
        case .lineList:
            return primitiveCount * 2
        case .lineListWithAdjacency:
            return primitiveCount * 4
        case .lineStrip:
            return primitiveCount + 1
        case .lineStripWithAdjacency:
            return primitiveCount + 3
        case .triangleList:
            return primitiveCount * 3
        case .triangleListWithAdjacency:
            return primitiveCount * 6
        case .triangleStrip:
            return primitiveCount + 2
        case .triangleStripWithAdjacency:
            return primitiveCount * 2 + 1
        default:
            fatalError("Primitive topology \(self) not supported.")
        }
    }

    /// Interpret the vertex data as a patch list.
    /// - Parameters:
    ///   - points: Number of control points. Valid range 1 - 32.
    /// - Returns: The resulting primitive topology.
    func controlPoints(points: Int) -> PrimitiveTopology {
        guard self == .patchList else {
            fatalError("Control points method applies only to PrimitiveTopology.patchList")
        }
        guard points >= 1 && points <= 32 else {
            fatalError("Control points value must be between 1 and 32")
        }
        return PrimitiveTopology(rawValue: UInt8(33 + points - 1))!
    }
}
