import Foundation

/// The stencil operations that can be performed during depth-stencil testing.
enum StencilOperation: UInt8 {
    /// Keep the existing stencil data.
    case keep = 1
    /// Set the stencil data to 0.
    case zero
    /// Set the stencil data to the reference value.
    case replace
    /// Increment the stencil value by 1, and clamp the result.
    case incrementSaturation
    /// Decrement the stencil value by 1, and clamp the result.
    case decrementSaturation
    /// Invert the stencil data.
    case invert
    /// Increment the stencil value by 1, and wrap the result if necessary.
    case increment
    /// Decrement the stencil value by 1, and wrap the result if necessary.
    case decrement
}
