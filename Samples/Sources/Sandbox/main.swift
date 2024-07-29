import SedulousSDL2Platform
import SedulousCore
import SedulousPlatform

class TestSystem : System {

    private var updateFunctionId: Context.RegisteredUpdateFunctionID?;

    public init()
    {
        super.init("Test");
    }

    override func onInitialize(_ context: Context) {
        updateFunctionId = context.registerUpdateFunction(.init(function: onUpdate));
    }

    override func onShutdown() {
        if let updateFunctionId {
            context?.unregisterUpdateFunction(updateFunctionId);
            self.updateFunctionId = nil;
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