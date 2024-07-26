import Foundation

public final class TimeTracker
{
    public internal(set) var time: Time = .init();

    public init() {}

    public func reset() -> Time
    {
        self.time.elapsedTime = .zero;
        self.time.totalTime = .zero;

        return self.time;
    }

    public func increment(_ ts: TimeSpan) -> Time
    {
        self.time.elapsedTime = ts;
        self.time.totalTime = self.time.totalTime + ts;

        return self.time;
    }
}