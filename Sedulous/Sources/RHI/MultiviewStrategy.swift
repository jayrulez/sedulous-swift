import Foundation

/// Indicates the strategy supported to render multiple views.
public enum MultiviewStrategy: UInt8 {
    /// Multiview is not supported in this device.
    case unsupported
    /// Multiview is specified by output vertex RenderTargetIndex semantic, in combination with DrawInstancing.
    /// Currently only supported on DX11.
    case renderTargetIndex
    /// Multiview is specified using a vertex shader input ViewID. Additionally, you need to specify how many views you want to render in the Framebuffer.
    /// Supported on OpenGLES 3.0 or greater, WebGL2, Vulkan, and DX12 in SM6.1.
    case viewIndex
}
