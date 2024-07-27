import Foundation

/// Protocol that offers the capabilities of the graphics context.
public protocol GraphicsContextCapabilities {
    /// Indicates whether this graphics context supports compute shaders.
    var isComputeShaderSupported: Bool { get }

    /// Indicates whether we need to flip projection matrix on Render Target.
    var flipProjectionRequired: Bool { get }

    /// Indicates whether this graphics context uses row major matrices by default.
    var matrixMajorness: MatrixMajorness { get }

    /// Indicates whether this graphics context supports Multi Render Target (MRT).
    var isMRTSupported: Bool { get }

    /// Indicates whether this graphics context supports Shadow Maps.
    var isShadowMapSupported: Bool { get }

    /// Gets the depth range in clip space.
    var clipDepth: ClipDepth { get }

    /// Gets the multiview strategy supported by this graphic context.
    var multiviewStrategy: MultiviewStrategy { get }

    /// Indicates whether this graphics context supports Raytracing.
    var isRaytracingSupported: Bool { get }
}
