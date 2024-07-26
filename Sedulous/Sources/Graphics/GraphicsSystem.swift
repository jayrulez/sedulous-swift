import SedulousCore
import SedulousRHI

public class GraphicsSystem : System
{
    private var info: ContextUpdateFunctionInfo?;
    private var device: GraphicsDevice? = nil;

    public init(_ device: GraphicsDevice)
    {
        self.device = device;
        super.init("Graphics");
    }

    deinit {
        self.device = nil;
    }

    public override func onInitialize(_ context: Context) {
        info = .init(function: onUpdate);
        context.registerUpdateFunction(info!);
    }

    public override func onShutdown() {
        if let info {
            context?.unregisterUpdateFunction(info);
            self.info = nil;
        }
    }

    private func onUpdate(_ info : ContextUpdateInfo) -> Void {
        //print("\(self.name) Update \(info.time.elapsedTime.totalSeconds)");
    }
}