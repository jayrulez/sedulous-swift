import SedulousCore
import SedulousPlatform
import SDL2
import CSDL2

public class SDL2Platform : ContextHost, Platform
{
    private var window: SDL2Window?;

    public private(set) var isRunning: Bool = false;

    public private(set) var context: Context!;

    public init()
    {
        self.context = Context.init(self);

        guard SDL2Native.SDL_Init(.everything) == 0 else {
            fatalError("Failed to initialize SDL2.");
        }
    }

    deinit
    {
        SDL2Native.SDL_Quit();
    }

    public func exit()
    {
        isRunning = false;
    }
}

package extension SDL2Platform
{
    func startMainLoop(_ onInitializing: ContextInitializingCallback? = nil, _ onInitialized: ContextInitializedCallback? = nil)
    {
        let initializer: ContextInitializer = .init();

        onInitializing?(initializer);

        context?.initialize(initializer);

        onInitialized?(context);

        isRunning = true;

        window = .init("Sandbox", 1280, 720);
    }

    func stopMainLoop(_ onShuttingDown: ContextShuttingDownCallback? = nil)
    {
        onShuttingDown?(context);
        context.shutdown();

        window = nil;

        isRunning = false;
    }

    func runOneFrame()
    {
        var event : SDL_Event = .init();
        while(SDL2Native.SDL_PollEvent(&event) != 0)
        {
            if event.type == SDL_QUIT.rawValue {
                self.exit();
            }
        }

        context.update();
    }
}