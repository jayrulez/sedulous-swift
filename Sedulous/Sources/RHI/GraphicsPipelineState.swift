import Foundation

/// Protocol representing the GPU graphics pipeline.
protocol GraphicsPipelineState: PipelineState {
    /// The graphics pipeline state description.
    var description: GraphicsPipelineDescription { get }

    /// Indicates if the current viewport is invalidated.
    var invalidatedViewport: Bool { get set }

    /// A string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }

    /// Initializes a new instance of the `GraphicsPipelineState` class.
    /// - Parameter description: The pipeline state description.
    init(description: GraphicsPipelineDescription)
}