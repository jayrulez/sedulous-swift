import Foundation
import SedulousFoundation
import SedulousCore
import SedulousPlatform
import SDL2
import CSDL2

public class SDL2Platform : ContextHost, Platform
{
    public private(set) var suspended: Bool = false;

    private var primaryWindow: SDL2Window?;

    public private(set) var isRunning: Bool = false;

    public private(set) var context: Context!;

    private let timer: Stopwatch = .init();

    private let timeTracker: TimeTracker = .init();

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
        self.isRunning = false;
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

        self.timer.start();

        // todo: set event filter

        self.isRunning = true;

        self.primaryWindow = .init("Sandbox", 1280, 720);
    }

    func stopMainLoop(_ onShuttingDown: ContextShuttingDownCallback? = nil)
    {
        timer.stop();

        // todo: unset event filter

        onShuttingDown?(context);

        context.shutdown();

        primaryWindow = nil;

        self.isRunning = false;
    }

    func runOneFrame()
    {
        // todo: reset input states

        var event : SDL_Event = .init();
        while(SDL2Native.SDL_PollEvent(&event) != 0)
        {
            let eventType: SDL_EventType = SDL_EventType(Int32(event.type));

            if eventType == SDL_QUIT {
                self.exit();
            } else if eventType == SDL_WINDOWEVENT {

                let windowEventType: SDL_WindowEventID = SDL_WindowEventID(Int32(event.window.event));
                if windowEventType == SDL_WINDOWEVENT_CLOSE && event.window.windowID == primaryWindow?.id {
                    self.exit();
                }
            } else {
                // TODO: Handle mouse + keyboard input
            }
        }

        let elapsed: TimeSpan = self.timer.elapsed;
        
        self.timer.restart();

        let updateTime: Time = timeTracker.increment(elapsed);

        //print("Elapsed: \(updateTime.elapsedTime.totalSeconds) \t Total: \(updateTime.totalTime.totalSeconds)");

        // todo: update input device states

        context.update(updateTime);
    }
}