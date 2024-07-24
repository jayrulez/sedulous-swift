import SedulousCore
import SedulousPlatform

public class SDL2Platform : ContextHost, Platform
{
    public private(set) var isRunning: Bool = false;

    public private(set) var context: Context!;

    public init()
    {
        self.context = Context.init(self)
    }

    deinit
    {

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
    }

    func stopMainLoop(_ onShuttingDown: ContextShuttingDownCallback? = nil)
    {
        onShuttingDown?(context);
        context.shutdown();
        isRunning = false;
    }

    func runOneFrame()
    {
        context.update();
    }
}