import Foundation

/// Describes the characteristics of a new pipeline state object.
public struct OutputAttachmentDescription: Equatable, Hashable {
    /// The pixel format.
    public var format: PixelFormat
    
    /// Indicates if the texture with MSAA attachment needs to be resolved.
    public var resolveMSAA: Bool

    /// Initializes a new instance of the OutputAttachmentDescription struct.
    /// - Parameters:
    ///   - format: The format of the texture attachment.
    ///   - resolveMSAA: Indicates if the texture with MSAA attachment needs to be resolved.
    public init(format: PixelFormat, resolveMSAA: Bool = false) {
        self.format = format
        self.resolveMSAA = resolveMSAA
    }

    /// Determines whether the specified instance is equal to the current instance.
    /// - Parameter other: The instance to compare with the current instance.
    /// - Returns: true if the specified instance is equal to the current instance; otherwise, false.
    public func equals(_ other: OutputAttachmentDescription) -> Bool {
        return self.format == other.format && self.resolveMSAA == other.resolveMSAA
    }

    /// Returns a hash code for this instance.
    /// - Parameter hasher: The hasher to use when combining the components of this instance.
    public func hash(into hasher: inout Hasher) {
        hasher.combine(format)
        hasher.combine(resolveMSAA)
    }

    /// Determines whether the specified object is equal to the current instance.
    /// - Parameter object: The object to compare with the current instance.
    /// - Returns: true if the specified object is equal to the current instance; otherwise, false.
    public static func == (lhs: OutputAttachmentDescription, rhs: OutputAttachmentDescription) -> Bool {
        return lhs.equals(rhs)
    }
}
