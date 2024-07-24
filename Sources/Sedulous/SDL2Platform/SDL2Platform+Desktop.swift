import SedulousCore

extension SDL2Platform {
    public func run(
        _ onInitializing: ContextInitializingCallback? = nil, 
        _ onInitialized: ContextInitializedCallback? = nil, 
        _ onShuttingDown: ContextShuttingDownCallback? = nil) 
    {
        self.startMainLoop(onInitializing, onInitialized);

        while self.isRunning {
            self.runOneFrame();
        }

        self.stopMainLoop(onShuttingDown);
    }
}