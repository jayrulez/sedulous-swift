import Foundation

/// SwapChain instance.
public protocol SwapChain {
    /// The device context reference.
    var graphicsContext: GraphicsContext { get set }

    /// Gets or sets the SwapChain description.
    var swapChainDescription: SwapChainDescription { get set }

    /// Gets or sets the swapchain Framebuffer.
    var frameBuffer: FrameBuffer { get set }

    /// Gets or sets a value indicating whether vertical synchronization is enabled or not.
    var verticalSync: Bool { get set }

    /// Gets or sets a string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }

    /// The swapchain surface info has changed.
    /// - Parameter surfaceInfo: The surface info.
    func refreshSurfaceInfo(_ surfaceInfo: SurfaceInfo)

    /// Resize SwapChain.
    /// - Parameters:
    ///   - width: New width.
    ///   - height: New height.
    func resizeSwapChain(width: UInt, height: UInt)

    /// Gets the current Framebuffer Texture.
    /// - Returns: Framebuffer texture.
    func getCurrentFramebufferTexture() -> any Texture

    /// This method is invoked when the frame is start.
    func initFrame()

    /// Presents a rendered image to the user.
    func present()
}

public extension SwapChain {
    func initFrame() {
        // Default implementation, can be overridden.
    }
}
