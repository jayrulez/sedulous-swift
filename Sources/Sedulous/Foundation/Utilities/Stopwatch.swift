import Foundation

public class Stopwatch {
    private var startTime: Date?
    private var accumulatedTicks: Int64

    public var isRunning: Bool {
        return startTime != nil
    }

    public var elapsed: TimeSpan {
        let currentTicks: Int64
        if let start = startTime {
            let interval = Date().timeIntervalSince(start)
            currentTicks = accumulatedTicks + Int64(interval * Double(TimeSpan.ticksPerSecond))
        } else {
            currentTicks = accumulatedTicks
        }
        return try! TimeSpan(ticks: currentTicks)
    }

    public init() {
        self.accumulatedTicks = 0
    }

    public func start() {
        guard startTime == nil else { return }
        startTime = Date()
    }

    public func stop() {
        guard let start = startTime else { return }
        let interval = Date().timeIntervalSince(start)
        accumulatedTicks += Int64(interval * Double(TimeSpan.ticksPerSecond))
        startTime = nil
    }

    public func reset() {
        startTime = nil
        accumulatedTicks = 0
    }

    public func restart() {
        stop()
        reset()
        start()
    }
}