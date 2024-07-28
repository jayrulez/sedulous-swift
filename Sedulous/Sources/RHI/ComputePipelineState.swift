import Foundation

/// Protocol representing the GPU graphics pipeline.
public protocol ComputePipelineState: PipelineState {
    /// The compute pipeline state description.
    var description: ComputePipelineDescription { get }

    /// A string identifying this instance. Can be used in graphics debuggers tools.
    var name: String { get set }

    /// Initializes a new instance of the `ComputePipelineState` class.
    /// - Parameter description: The pipeline state description.
    init(description: ComputePipelineDescription)
}