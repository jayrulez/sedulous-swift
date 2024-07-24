extension SDL2Platform {
    public func run() {
        self.startMainLoop();

        while self.isRunning {
            self.runOneFrame();
        }

        self.stopMainLoop();
    }
}