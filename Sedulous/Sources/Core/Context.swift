import Foundation
import SedulousFoundation;

public typealias ContextInitializingCallback = (_ initializer: ContextInitializer) -> Void;
public typealias ContextInitializedCallback = (_ context: Context) -> Void;
public typealias ContextShuttingDownCallback = (_ context: Context) -> Void;

public enum ContextUpdateStage : CaseIterable
{
    case preUpdate
    case postUpdate
    case variableUpdate
    case fixedUpdate
}

public struct ContextUpdateInfo
{
    public var context: Context;
    public var time: Time;
}

public typealias ContextUpdateFunction = (_ info : ContextUpdateInfo) -> Void

public struct ContextUpdateClosure
{
    private var closure: ContextUpdateFunction;

    public init(_ closure: @escaping ContextUpdateFunction)
    {
        self.closure = closure;
    }
}

public struct ContextUpdateFunctionInfo
{
    public var priority : Int;
    public var stage : ContextUpdateStage;
    public var function : ContextUpdateFunction;

    public init(function: @escaping ContextUpdateFunction, priority: Int = 0, stage: ContextUpdateStage = .variableUpdate)
    {
        self.priority = priority;
        self.stage = stage;
        self.function = function;
    }
}

public class Context
{
    fileprivate struct RegisteredUpdateFunctionInfo
	{
		public var priority: Int;
		public var function: ContextUpdateFunction;
	}

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

    private var updateFunctions: Dictionary<ContextUpdateStage, Array<RegisteredUpdateFunctionInfo>> = .init();
	private var updateFunctionsToRegister: Array<ContextUpdateFunctionInfo> = .init();
	private var updateFunctionsToUnregister: Array<ContextUpdateFunctionInfo> = .init();

    private var systems: [System] = .init();

    package init(_ host: ContextHost)
    {
        self.host = host;

        for stage: ContextUpdateStage in ContextUpdateStage.allCases
        {
            updateFunctions[stage] = .init();
        }
    }
}

package extension Context
{
    func initialize(_ initializer: ContextInitializer)
    {
        var initializedSystems: [System] = .init();

        for system in initializer.systems {
            if system.initialize(self) {
                initializedSystems.append(system);
            }else{
                break;
            }
        }

        if initializedSystems.count != initializer.systems.count {
            for system in initializedSystems.reversed() {
                system.shutdown();
            }
            return;
        }

        systems.append(contentsOf: initializedSystems);
    }

    func shutdown()
    {
        for system in systems.reversed() {
            system.shutdown();
        }
    }
} 

extension Context
{
    package func update(_ time: Time)
    {
        func sortUpdateFunctions()
        {
            for stage: ContextUpdateStage in ContextUpdateStage.allCases
            {
                updateFunctions[stage]!.sort { lhs, rhs in
                    return lhs.priority > rhs.priority
                }
            }
        }

        func runUpdateFunctions(_ phase: ContextUpdateStage , _ info: ContextUpdateInfo)
        {
            for updateFunctionInfo: RegisteredUpdateFunctionInfo in updateFunctions[phase]!
            {
                updateFunctionInfo.function(info);
            }
        }

        func processUpdateFunctionsToRegister()
        {
            if updateFunctionsToRegister.count == 0 { return; }

			for info: ContextUpdateFunctionInfo in updateFunctionsToRegister
			{
                // guard updateFunctions[info.stage] != nil else {
                //     fatalError("Registry for \(info.stage) wasn't initialized.");
                // }
				updateFunctions[info.stage]!.append(.init(priority: info.priority, function: info.function));
			}
			updateFunctionsToRegister.removeAll();
			sortUpdateFunctions();
        }

        func processUpdateFunctionsToUnregister()
        {
            if updateFunctionsToUnregister.count == 0 {
				return;
            }

            func getAddress(of closure: @escaping ContextUpdateFunction) -> UnsafePointer<ContextUpdateFunction> {
                return withUnsafePointer(to: closure) { pointer in
                    return pointer;
                }
            }

			for info: ContextUpdateFunctionInfo in updateFunctionsToUnregister
			{
				if let index: Array<RegisteredUpdateFunctionInfo>.Index = updateFunctions[info.stage]!.firstIndex(where: { registered in
                    return getAddress(of: registered.function) == getAddress(of: info.function);
                }) {
					updateFunctions[info.stage]!.remove(at: index);
				}
			}
			updateFunctionsToUnregister.removeAll();
			sortUpdateFunctions();
        }
        do {
			processUpdateFunctionsToRegister();
			processUpdateFunctionsToUnregister();
		}

        if inactiveSleepTime.totalSeconds > 0 && host.suspended  {
            Thread.sleep(forTimeInterval: TimeInterval(inactiveSleepTime.totalSeconds));
        }

        accumulatedElapsedTime += time.elapsedTime.ticks;
        if accumulatedElapsedTime > Self.maxElapsedTime.ticks {
            accumulatedElapsedTime = Self.maxElapsedTime.ticks;
        }

        // Pre-Update
        do {
            runUpdateFunctions(.preUpdate, .init(
					context: self,
					time: preUpdateTimeTracker.increment(time.elapsedTime)
            ));
        }

        // Fixed Update
        do {
            let fixedTicksToRun: Int64 = accumulatedElapsedTime / targetElapsedTime.ticks;

            if fixedTicksToRun > 0 {
                let fixedUpdateTimeDelta: TimeSpan = targetElapsedTime;
                accumulatedElapsedTime -= fixedTicksToRun * targetElapsedTime.ticks;

                for _ in 0..<fixedTicksToRun {
                    runUpdateFunctions(.fixedUpdate, .init(
                        context: self,
                        time: fixedUpdateTimeTracker.increment(fixedUpdateTimeDelta)
                    ));
                }
            }
        }


        // Variable Update
        do {
            runUpdateFunctions(.variableUpdate, .init(
					context: self,
					time: variableUpdateTimeTracker.increment(time.elapsedTime)
            ));
        }

        // Post Update
        do {
            runUpdateFunctions(.postUpdate, .init(
                context: self,
				time: postUpdateTimeTracker.increment(time.elapsedTime)
            ));
        }
    }

    public func registerUpdateFunction(_ info: ContextUpdateFunctionInfo) {
        updateFunctionsToRegister.append(info);
    }

    public func registerUpdateFunctions(_ infos: Array<ContextUpdateFunctionInfo>) {
        for info: ContextUpdateFunctionInfo in infos
		{
			updateFunctionsToRegister.append(info);
		}
    }

    public func unregisterUpdateFunction(_ info: ContextUpdateFunctionInfo) {
        updateFunctionsToUnregister.append(info);
    }

    public func unregisterUpdateFunctions(_ infos: Array<ContextUpdateFunctionInfo>) {
        for info: ContextUpdateFunctionInfo in infos
		{
			updateFunctionsToUnregister.append(info);
		}
    }
} 

public extension Context {
    func getSystem<T>() -> T? where T : System {
        for system: System in systems {
            if let tSystem = system as? T {
                return tSystem;
            }
        }
        return nil;
    }

    func tryGetSystem<T>(_ outSystem: inout T) -> Bool where T : System {
        for system: System in systems {
            if let tSystem = system as? T {
                outSystem = tSystem;
                return true;
            }
        }
        return false;
    }
}