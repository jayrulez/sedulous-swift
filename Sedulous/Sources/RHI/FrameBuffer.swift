import Foundation

/// Protocol representing a framebuffer.
public protocol FrameBuffer: AnyObject {
    var name: String { get set }
    var width: UInt32 { get set }
    var height: UInt32 { get set }
    var arraySize: UInt32 { get set }
    var sampleCount: TextureSampleCount { get set }
    var requireFlipProjection: Bool { get set }
    var colorTargets: [FrameBufferAttachment] { get set }
    var depthStencilTarget: FrameBufferAttachment? { get set }
    var outputDescription: OutputDescription { get set }
    var intermediateBufferAssociated: Bool { get set }
    var disposeAttachments: Bool { get set }
    var disposed: Bool { get set }

    init(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool)

    func dispose()
    func dispose(disposing: Bool)
}

public extension FrameBuffer {
    init(depthTarget: FrameBufferAttachment?, colorTargets: [FrameBufferAttachment], disposeAttachments: Bool) {
        self.init(depthTarget: depthTarget, colorTargets: colorTargets, disposeAttachments: disposeAttachments)
        self.depthStencilTarget = depthTarget
        self.colorTargets = colorTargets
        self.disposeAttachments = disposeAttachments
        if let target = colorTargets.first {
            self.width = target.attachmentTexture.description.width
            self.height = target.attachmentTexture.description.height
            self.arraySize = target.attachmentTexture.description.arraySize
            self.sampleCount = target.attachmentTexture.description.sampleCount
        } else if let depthTarget = depthTarget {
            self.width = depthTarget.attachmentTexture.description.width
            self.height = depthTarget.attachmentTexture.description.height
            self.arraySize = depthTarget.attachmentTexture.description.arraySize
            self.sampleCount = depthTarget.attachmentTexture.description.sampleCount
        }
        self.outputDescription = OutputDescription.createFromFrameBuffer(frameBuffer: self)
    }

    func dispose() {
        dispose(disposing: true)
    }

    func dispose(disposing: Bool) {
        guard !disposed else { return }

        if disposing {
            if disposeAttachments {
                for target in colorTargets {
                    //target.attachmentTexture.dispose()
                    //target.resolvedTexture?.dispose()
                }
                //depthStencilTarget?.attachmentTexture.dispose()
                //depthStencilTarget?.resolvedTexture?.dispose()
            }
        }

        disposed = true
    }
}