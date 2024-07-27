import Foundation

/// Structure specifying render pass begin info.
public struct RenderPassDescription {
    /// The frameBuffer containing the attachments that are used with the render pass.
    public var frameBuffer: FrameBuffer

    /// Array that contains clear values for each attachment.
    public var clearValue: ClearValue

    /// Initializes a new instance of the `RenderPassDescription` struct.
    /// - Parameters:
    ///   - frameBuffer: The frameBuffer containing the attachments that are used with the render pass.
    ///   - clearValue: That contains clear values for each attachment.
    public init(frameBuffer: FrameBuffer, clearValue: ClearValue) {
        if let colorTargets = frameBuffer.colorTargets, colorTargets.count != clearValue.colorValues.count {
            fatalError("The number of framebuffer color targets \(colorTargets.count) must be equal to the number of clear color values \(clearValue.colorValues.count)")
        }
        self.frameBuffer = frameBuffer
        self.clearValue = clearValue
    }
}