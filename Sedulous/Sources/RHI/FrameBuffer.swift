public class FrameBuffer {
    /// Gets or sets the collection of color targets textures associated with this `FrameBuffer`.
    public private(set) var colorTargets: [FrameBufferAttachment]?
    
    /// Gets or sets the depth targets texture associated with this `FrameBuffer`.
    public private(set) var depthStencilTarget: FrameBufferAttachment?
}