import SedulousSDL2Platform
import SedulousCore
import SedulousVulkanRHI
import SedulousPlatform

let device: VulkanGraphicsDevice = .init();

let onUpdate: ContextUpdateFunction = { info in
    print("Update");
}

let platform : SDL2Platform = .init(primaryWindowConfig: .init(title: "RHI", width: 1280, height: 720));

platform.run(
    onInitializing: { initializer in

    },
    onInitialized: { context in
        context.registerUpdateFunction(.init(function: onUpdate));
    },
    onShuttingDown: { context in

    }
);