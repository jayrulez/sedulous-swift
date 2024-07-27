import Foundation

/// Contains properties that describe a framebuffer texture attachment description.
public struct FrameBufferAttachment: Equatable, Hashable {
    /// The number of slices to attach.
    public var sliceCount: UInt32
    
    /// The selected MipLevel.
    public var mipSlice: UInt32
    
    /// The attachment texture. This is the texture used by the framebuffer as attachment.
    /// If this texture has MSAA enabled, you could set the ResolvedTexture field with a non MSAA texture. After the EndRenderPass, this texture will be resolved into this.
    public var attachmentTexture: any Texture
    
    /// The selected array slice.
    public var attachedFirstSlice: UInt32
    
    /// The resolved texture. If the source texture has MSAA enabled, in the EndRenderPass this texture is resolved into this texture.
    public var resolvedTexture: (any Texture)?
    
    /// The selected array slice.
    public var resolvedFirstSlice: UInt32
    
    /// Gets the texture used as a shader resource.
    public var texture: any Texture {
        return resolvedTexture ?? attachmentTexture
    }
    
    /// Gets the selected array slice of the texture used as a shader resource.
    public var firstSlice: UInt32 {
        return resolvedTexture == nil ? attachedFirstSlice : resolvedFirstSlice
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - arrayIndex: The array index to compute the specific slide inside the texture.
    ///   - faceIndex: The face index to compute the specific slide inside the texture.
    ///   - sliceCount: The slice count.
    ///   - mipLevel: The selected mipLevel.
    public init(attachedTexture: any Texture, arrayIndex: UInt32, faceIndex: UInt32, sliceCount: UInt32, mipLevel: UInt32) {
        self.init(attachedTexture: attachedTexture, attachedFirstSlice: arrayIndex * attachedTexture.description.faces + faceIndex, resolvedTexture: nil, resolvedFirstSlice: 0, sliceCount: sliceCount, mipLevel: mipLevel)
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - firstSlice: The first slice.
    ///   - sliceCount: The slice count.
    ///   - mipLevel: The selected mipLevel.
    public init(attachedTexture: any Texture, firstSlice: UInt32, sliceCount: UInt32, mipLevel: UInt32 = 0) {
        self.init(attachedTexture: attachedTexture, attachedFirstSlice: firstSlice, resolvedTexture: nil, resolvedFirstSlice: 0, sliceCount: sliceCount, mipLevel: mipLevel)
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - resolvedTexture: The resolved texture.
    public init(attachedTexture: any Texture, resolvedTexture: any Texture) {
        self.init(attachedTexture: attachedTexture, attachedFirstSlice: 0, resolvedTexture: resolvedTexture, resolvedFirstSlice: 0, sliceCount: 1, mipLevel: 0)
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - attachedFirstSlice: The first slice.
    ///   - resolvedTexture: The resolved texture.
    ///   - resolvedFirstSlice: The first slice on the resolved texture.
    ///   - sliceCount: The slice count on the resolved texture.
    ///   - mipLevel: The selected mipLevel on the resolved texture.
    public init(attachedTexture: any Texture, attachedFirstSlice: UInt32, resolvedTexture: (any Texture)?, resolvedFirstSlice: UInt32, sliceCount: UInt32, mipLevel: UInt32) {
        if let resolvedTexture = resolvedTexture {
            guard resolvedTexture.description.sampleCount == .none else {
                fatalError("The resolved texture must have SampleCount == None")
            }
            guard attachedTexture.description.sampleCount != .none else {
                fatalError("Framebuffer attachment texture must have SampleCount != None if there is a resolvedTexture")
            }
        }
        self.attachmentTexture = attachedTexture
        self.attachedFirstSlice = attachedFirstSlice
        self.resolvedTexture = resolvedTexture
        self.resolvedFirstSlice = resolvedFirstSlice
        self.sliceCount = sliceCount
        self.mipSlice = mipLevel
    }
    
    public static func ==(lhs: FrameBufferAttachment, rhs: FrameBufferAttachment) -> Bool {
        return 
            lhs.attachmentTexture === rhs.attachmentTexture &&
            lhs.attachedFirstSlice == rhs.attachedFirstSlice &&
            lhs.sliceCount == rhs.sliceCount &&
            lhs.mipSlice == rhs.mipSlice &&
            lhs.resolvedTexture === rhs.resolvedTexture &&
            lhs.resolvedFirstSlice == rhs.resolvedFirstSlice
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(attachmentTexture).hashValue)
        hasher.combine(attachedFirstSlice)
        hasher.combine(sliceCount)
        hasher.combine(mipSlice)
        if let resolvedTexture = resolvedTexture {
            hasher.combine(ObjectIdentifier(resolvedTexture).hashValue)
            hasher.combine(resolvedFirstSlice)
        }
    }
}
