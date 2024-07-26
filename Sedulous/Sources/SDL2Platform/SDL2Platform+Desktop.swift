import SedulousCore

extension SDL2Platform {
    public func run(
        onInitializing: ContextInitializingCallback? = nil, 
        onInitialized: ContextInitializedCallback? = nil, 
        onShuttingDown: ContextShuttingDownCallback? = nil) 
    {
        self.startMainLoop(onInitializing, onInitialized);

        while self.isRunning {
            self.runOneFrame();
        }

        self.stopMainLoop(onShuttingDown);
    }
}