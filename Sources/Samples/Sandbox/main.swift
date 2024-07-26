import SedulousSDL2Platform
import SedulousCore
import SedulousVulkanRHI
import SedulousGraphics

// class TestSystem : System {

//     private var info: ContextUpdateFunctionInfo?;

//     public init()
//     {
//         super.init("Test");
//     }

//     override func onInitialize(_ context: Context) {
//         info = .init(function: onUpdate);
//         context.registerUpdateFunction(info!);
//     }

//     override func onShutdown() {
//         if let info {
//             context?.unregisterUpdateFunction(info);
//             self.info = nil;
//         }
//     }

//     private func onUpdate(_ info : ContextUpdateInfo) -> Void {
//         if let system: TestSystem = info.context.getSystem() {
//             system.printInfo(info);
//         }
//     }

//     private func printInfo(_ info : ContextUpdateInfo)
//     {
//         print("\(self.name) Update \(info.time.elapsedTime.totalSeconds)");
//     }
// }

// let testSystem: TestSystem = .init();

let device: VulkanGraphicsDevice = .init();
let graphicsSystem: GraphicsSystem = .init(device);

let platform : SDL2Platform = .init();
platform.run(
    onInitializing: { initializer in 
        //initializer.addSystem(testSystem);
        initializer.addSystem(graphicsSystem);
    }
);