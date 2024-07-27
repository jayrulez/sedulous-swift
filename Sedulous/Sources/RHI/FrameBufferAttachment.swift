import Foundation

/// Contains properties that describe a framebuffer texture attachment description.
public struct FrameBufferAttachment: Equatable, Hashable {
    /// The number of slices to attach.
    public var sliceCount: UInt
    
    /// The selected MipLevel.
    public var mipSlice: UInt
    
    /// The attachment texture. This is the texture used by the framebuffer as attachment.
    /// If this texture has MSAA enabled, you could set the ResolvedTexture field with a non MSAA texture. After the EndRenderPass, this texture will be resolved into this.
    public var attachmentTexture: Texture
    
    /// The selected array slice.
    public var attachedFirstSlice: UInt
    
    /// The resolved texture. If the source texture has MSAA enabled, in the EndRenderPass this texture is resolved into this texture.
    public var resolvedTexture: Texture?
    
    /// The selected array slice.
    public var resolvedFirstSlice: UInt
    
    /// Gets the texture used as a shader resource.
    public var texture: Texture {
        return resolvedTexture ?? attachmentTexture
    }
    
    /// Gets the selected array slice of the texture used as a shader resource.
    public var firstSlice: UInt {
        return resolvedTexture == nil ? attachedFirstSlice : resolvedFirstSlice
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - arrayIndex: The array index to compute the specific slide inside the texture.
    ///   - faceIndex: The face index to compute the specific slide inside the texture.
    ///   - sliceCount: The slice count.
    ///   - mipLevel: The selected mipLevel.
    public init(attachedTexture: Texture, arrayIndex: UInt, faceIndex: UInt, sliceCount: UInt, mipLevel: UInt) {
        self.init(attachedTexture: attachedTexture, attachedFirstSlice: arrayIndex * attachedTexture.description.faces + faceIndex, resolvedTexture: nil, resolvedFirstSlice: 0, sliceCount: sliceCount, mipLevel: mipLevel)
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - firstSlice: The first slice.
    ///   - sliceCount: The slice count.
    ///   - mipLevel: The selected mipLevel.
    public init(attachedTexture: Texture, firstSlice: UInt, sliceCount: UInt, mipLevel: UInt = 0) {
        self.init(attachedTexture: attachedTexture, attachedFirstSlice: firstSlice, resolvedTexture: nil, resolvedFirstSlice: 0, sliceCount: sliceCount, mipLevel: mipLevel)
    }
    
    /// Initializes a new instance of the `FrameBufferAttachment` struct.
    /// - Parameters:
    ///   - attachedTexture: The attachment texture.
    ///   - resolvedTexture: The resolved texture.
    public init(attachedTexture: Texture, resolvedTexture: Texture) {
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
    public init(attachedTexture: Texture, attachedFirstSlice: UInt, resolvedTexture: Texture?, resolvedFirstSlice: UInt, sliceCount: UInt, mipLevel: UInt) {
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
        return lhs.attachmentTexture == rhs.attachmentTexture &&
            lhs.attachedFirstSlice == rhs.attachedFirstSlice &&
            lhs.sliceCount == rhs.sliceCount &&
            lhs.mipSlice == rhs.mipSlice &&
            lhs.resolvedTexture == rhs.resolvedTexture &&
            lhs.resolvedFirstSlice == rhs.resolvedFirstSlice
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(attachmentTexture)
        hasher.combine(attachedFirstSlice)
        hasher.combine(sliceCount)
        hasher.combine(mipSlice)
        if let resolvedTexture = resolvedTexture {
            hasher.combine(resolvedTexture)
            hasher.combine(resolvedFirstSlice)
        }
    }
}
