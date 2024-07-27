import Foundation

/// Contains properties that describe the characteristics of a new pipeline state object.
public struct OutputDescription: Equatable, Hashable {
    /// A description of the depth attachment, or null if none exists.
    public let depthAttachment: OutputAttachmentDescription?
    
    /// An array of attachment descriptions, one for each color attachment.
    public let colorAttachments: [OutputAttachmentDescription]
    
    /// Gets the number of view counts.
    public let arraySliceCount: UInt
    
    /// The number of samples in each target attachment.
    public let sampleCount: TextureSampleCount
    
    /// Precomputed outputDescription hash. Used to speed up the comparison between output descriptions.
    public let cachedHashCode: Int
    
    /// Initializes a new instance of the `OutputDescription` struct.
    /// - Parameters:
    ///   - depth: A description of the depth attachment.
    ///   - colors: An array of descriptions of each color attachment.
    ///   - sampleCount: The number of samples in each target attachment.
    ///   - arraySliceCount: The number of views rendered.
    public init(depth: OutputAttachmentDescription?, colors: [OutputAttachmentDescription], sampleCount: TextureSampleCount, arraySliceCount: UInt) {
        self.depthAttachment = depth
        self.colorAttachments = colors
        self.sampleCount = sampleCount
        self.arraySliceCount = arraySliceCount
        
        var hashCode = depth?.hashValue ?? 0
        for colorAttachment in colors {
            hashCode = (hashCode * 397) ^ colorAttachment.hashValue
        }
        hashCode = (hashCode * 397) ^ sampleCount.hashValue
        self.cachedHashCode = (hashCode * 397) ^ arraySliceCount.hashValue
    }
    
    /// Create a new instance of `OutputDescription` from a `FrameBuffer`.
    /// - Parameter frameBuffer: The framebuffer to extract the attachment description.
    /// - Returns: A new instance of OutputDescription.
    public static func createFromFrameBuffer(frameBuffer: FrameBuffer) -> OutputDescription {
        var sampleCount: TextureSampleCount = .none
        var depthAttachment: OutputAttachmentDescription? = nil
        var arraySliceCount: UInt = 1
        
        if let depthStencilTarget = frameBuffer.depthStencilTarget {
            let depthDescription = depthStencilTarget.attachmentTexture.description
            depthAttachment = OutputAttachmentDescription(format: depthDescription.format, resolveMSAA: depthStencilTarget.resolvedTexture != nil)
            sampleCount = depthDescription.sampleCount
        }
        
        var colorAttachments: [OutputAttachmentDescription] = []
        if let colorTargets = frameBuffer.colorTargets {
            for colorTarget in colorTargets {
                let colorDescription = colorTarget.attachmentTexture.description
                let colorAttachment = OutputAttachmentDescription(format: colorDescription.format, resolveMSAA: colorTarget.resolvedTexture != nil)
                colorAttachments.append(colorAttachment)
                sampleCount = colorDescription.sampleCount
                arraySliceCount = colorTarget.sliceCount
            }
        }
        
        return OutputDescription(depth: depthAttachment, colors: colorAttachments, sampleCount: sampleCount, arraySliceCount: arraySliceCount)
    }
    
    public static func ==(lhs: OutputDescription, rhs: OutputDescription) -> Bool {
        return lhs.cachedHashCode == rhs.cachedHashCode
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cachedHashCode)
    }
    
    private func arrayEqualsEquatable<T: Equatable>(_ left: [T]?, _ right: [T]?) -> Bool {
        if left == nil || right == nil {
            return left == right
        }
        if left!.count != right!.count {
            return false
        }
        for (index, element) in left!.enumerated() {
            if element != right![index] {
                return false
            }
        }
        return true
    }
}
