import Foundation
import SedulousFoundation;

public typealias ContextInitializingCallback = (_ initializer: ContextInitializer) -> Void;
public typealias ContextInitializedCallback = (_ context: Context) -> Void;
public typealias ContextShuttingDownCallback = (_ context: Context) -> Void;

public class Context
{
    public private(set) var host: ContextHost;

    private let preUpdateTimeTracker: TimeTracker = .init();
    private let postUpdateTimeTracker: TimeTracker = .init();
    private let variableUpdateTimeTracker: TimeTracker = .init();
    private let fixedUpdateTimeTracker: TimeTracker = .init();

    private var accumulatedElapsedTime: Int64 = 0;

    public static let maxElapsedTime: TimeSpan = try! .fromMilliseconds(500);
    public static let defaultTargetElapsedTime: TimeSpan = try! .init(ticks: TimeSpan.ticksPerSecond/60);
    public static let defaultInactiveSleepTime: TimeSpan = try! .fromMilliseconds(20);

    public var targetElapsedTime: TimeSpan = defaultTargetElapsedTime;
    public var inactiveSleepTime: TimeSpan = defaultInactiveSleepTime;

    package init(_ host: ContextHost)
    {
        self.host = host;
    }

    deinit
    {

    }
}

package extension Context
{
    func initialize(_ initializer: ContextInitializer)
    {

    }

    func shutdown()
    {

    }
} 

package extension Context
{
    func update(_ time: Time)
    {
        //print("Elapsed: \(time.elapsedTime.totalSeconds) \t Total: \(time.totalTime.totalSeconds)");

        if inactiveSleepTime.totalSeconds > 0 && host.suspended  {
            Thread.sleep(forTimeInterval: TimeInterval(inactiveSleepTime.totalSeconds));
        }

        accumulatedElapsedTime += time.elapsedTime.ticks;
        if accumulatedElapsedTime > Self.maxElapsedTime.ticks {
            accumulatedElapsedTime = Self.maxElapsedTime.ticks;
        }
        //print("targetElapsedTime: \(targetElapsedTime.totalSeconds)  accumulatedElapsedTime: \(accumulatedElapsedTime)");

        // Pre-Update
        do {
            let _: Time = preUpdateTimeTracker.increment(time.elapsedTime);
        }

        // Fixed Update
        do {
            let fixedTicksToRun: Int64 = accumulatedElapsedTime / targetElapsedTime.ticks;

            if fixedTicksToRun > 0 {
                let fixedUpdateTimeDelta: TimeSpan = targetElapsedTime;
                accumulatedElapsedTime -= fixedTicksToRun * targetElapsedTime.ticks;

                for i in 0..<fixedTicksToRun {
                    var time: Time = fixedUpdateTimeTracker.increment(fixedUpdateTimeDelta);
                    //print("\(i) update: \(time.elapsedTime.totalSeconds), total: \(time.totalTime.totalSeconds)");
                }
            }
        }


        // Variable Update
        do {
            let _: Time = variableUpdateTimeTracker.increment(time.elapsedTime);
        }

        // Post Update
        do {
            let _: Time = postUpdateTimeTracker.increment(time.elapsedTime);
        }
    }
} 