import SedulousSDL2Platform
import SedulousCore
import SedulousVulkanRHI
import SedulousGraphics
import SedulousPlatform

let device: VulkanGraphicsDevice = .init();
let graphicsSystem: GraphicsSystem = .init(device);

let platform : SDL2Platform = .init(primaryWindowConfig: .init(title: "RHI", width: 1280, height: 720));
platform.run(
    onInitializing: { initializer in
        initializer.addSystem(graphicsSystem);
    }
);