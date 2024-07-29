import SedulousCore
import SedulousRHI

public class GraphicsSystem : System
{
    private var updateFunctionId: Context.RegisteredUpdateFunctionID?;
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
        updateFunctionId = context.registerUpdateFunction(.init(function: onUpdate));
    }

    public override func onShutdown() {
        if let updateFunctionId {
            context?.unregisterUpdateFunction(updateFunctionId);
            self.updateFunctionId = nil;
        }
    }

    private func onUpdate(_ info : ContextUpdateInfo) -> Void {
        //print("\(self.name) Update \(info.time.elapsedTime.totalSeconds)");
    }
}