import Foundation

/// This struct represents all parameters required to create a new shader.
public struct ShaderDescription: Equatable, Hashable {
    /// Gets the name of the entry point function.
    public let entryPoint: String
    
    /// Gets the raw shader code.
    public let shaderBytes: [UInt8]
    
    /// Gets the shader stage.
    public let stage: ShaderStages
    
    /// Byte array hash code cached.
    private var shaderArrayHashCode: Int
    
    /// Initializes a new instance of the ShaderDescription struct.
    /// - Parameters:
    ///   - stage: The shader stage.
    ///   - entryPoint: The entry point function.
    ///   - shaderBytes: The shader code in bytes.
    public init(stage: ShaderStages, entryPoint: String, shaderBytes: [UInt8]) {
        self.stage = stage
        self.entryPoint = entryPoint
        self.shaderBytes = shaderBytes
        self.shaderArrayHashCode = 17
        for byte in shaderBytes {
            self.shaderArrayHashCode = (self.shaderArrayHashCode * 397) ^ Int(byte)
        }
    }
    
    /// Determines whether the specified parameter is equal to this instance.
    /// - Parameter other: Other used to compare.
    /// - Returns: `true` if the specified object is equal to this instance; otherwise, `false`.
    public func equals(_ other: ShaderDescription) -> Bool {
        return self.entryPoint == other.entryPoint &&
               self.shaderBytes == other.shaderBytes &&
               self.stage == other.stage
    }
    
    /// Determines whether the specified object is equal to this instance.
    /// - Parameter obj: The object to compare with this instance.
    /// - Returns: `true` if the specified object is equal to this instance; otherwise, `false`.
    public static func == (lhs: ShaderDescription, rhs: ShaderDescription) -> Bool {
        return lhs.equals(rhs)
    }
    
    /// Returns a hash code for this instance.
    /// - Returns: A hash code for this instance, suitable for use in hashing algorithms and data structures like a hash table.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(entryPoint)
        hasher.combine(shaderArrayHashCode)
        hasher.combine(stage)
    }
}
