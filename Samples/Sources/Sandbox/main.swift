import SedulousSDL2Platform
import SedulousCore
import SedulousPlatform

class TestSystem : System {

    private var info: ContextUpdateFunctionInfo?;

    public init()
    {
        super.init("Test");
    }

    override func onInitialize(_ context: Context) {
        info = .init(function: onUpdate);
        context.registerUpdateFunction(info!);
    }

    override func onShutdown() {
        if let info {
            context?.unregisterUpdateFunction(info);
            self.info = nil;
        }
    }

    private func onUpdate(_ info : ContextUpdateInfo) -> Void {
        if let system: TestSystem = info.context.getSystem() {
            system.printInfo(info);
        }
    }

    private func printInfo(_ info : ContextUpdateInfo)
    {
        print("\(self.name) Update \(info.time.elapsedTime.totalSeconds)");
    }
}

let testSystem: TestSystem = .init();

let platform : SDL2Platform = .init(primaryWindowConfig: .init(title: "Sandbox", width: 1280, height: 720));
platform.run(
    onInitializing: { initializer in 
        initializer.addSystem(testSystem);
    }
);