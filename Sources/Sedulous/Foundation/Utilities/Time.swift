import Foundation

public final class Time
{
    public internal(set) var elapsedTime: TimeSpan;
    public internal(set) var totalTime: TimeSpan;

    public init()
    {
        self.elapsedTime = .zero;
        self.totalTime = .zero;
    }

    public init(elapsedTime: TimeSpan, totalTime: TimeSpan)
    {
        self.elapsedTime = elapsedTime;
        self.totalTime = totalTime;
    }
}