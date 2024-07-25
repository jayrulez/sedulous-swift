import Foundation

public struct TimeSpan: Comparable, Equatable, Sendable {
    public static let ticksPerSecond: Int64 = 10_000_000
    public static let ticksPerMillisecond: Int64 = 10_000
    public static let ticksPerMicrosecond: Int64 = 10
    public static let ticksPerNanosecond: Int64 = 1 / 100
    public static let ticksPerMinute = ticksPerSecond * 60
    public static let ticksPerHour = ticksPerMinute * 60
    public static let ticksPerDay = ticksPerHour * 24
    
    public static let minTicks: Int64 = Int64.min
    public static let maxTicks: Int64 = Int64.max
    
    public static let zero = try! TimeSpan(ticks: 0)

    public var ticks: Int64

    public var days: Int {
        return Int(ticks / TimeSpan.ticksPerDay)
    }

    public var hours: Int {
        return Int((abs(ticks) % TimeSpan.ticksPerDay) / TimeSpan.ticksPerHour)
    }

    public var minutes: Int {
        return Int((abs(ticks) % TimeSpan.ticksPerHour) / TimeSpan.ticksPerMinute)
    }

    public var seconds: Int {
        return Int((abs(ticks) % TimeSpan.ticksPerMinute) / TimeSpan.ticksPerSecond)
    }

    public var milliseconds: Int {
        return Int((abs(ticks) % TimeSpan.ticksPerSecond) / TimeSpan.ticksPerMillisecond)
    }

    public var microseconds: Int {
        return Int((abs(ticks) % TimeSpan.ticksPerMillisecond) / TimeSpan.ticksPerMicrosecond)
    }

    public var nanoseconds: Int {
        return Int((abs(ticks) % TimeSpan.ticksPerMicrosecond) / TimeSpan.ticksPerNanosecond)
    }

    public var totalDays: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerDay)
    }

    public var totalHours: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerHour)
    }

    public var totalMinutes: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerMinute)
    }

    public var totalSeconds: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerSecond)
    }

    public var totalMilliseconds: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerMillisecond)
    }

    public var totalMicroseconds: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerMicrosecond)
    }

    public var totalNanoseconds: Double {
        return Double(ticks) / Double(TimeSpan.ticksPerNanosecond)
    }

    public init(days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0, milliseconds: Int = 0, microseconds: Int = 0, nanoseconds: Int = 0) throws {
        let ticks = Int64(days) * TimeSpan.ticksPerDay +
                    Int64(hours) * TimeSpan.ticksPerHour +
                    Int64(minutes) * TimeSpan.ticksPerMinute +
                    Int64(seconds) * TimeSpan.ticksPerSecond +
                    Int64(milliseconds) * TimeSpan.ticksPerMillisecond +
                    Int64(microseconds) * TimeSpan.ticksPerMicrosecond +
                    Int64(nanoseconds) * TimeSpan.ticksPerNanosecond
        if ticks < TimeSpan.minTicks || ticks > TimeSpan.maxTicks {
            throw TimeSpanError.outOfRange("Ticks value out of range")
        }
        self.ticks = ticks
    }

    public init(ticks: Int64) throws {
        if ticks < TimeSpan.minTicks || ticks > TimeSpan.maxTicks {
            throw TimeSpanError.outOfRange("Ticks value out of range")
        }
        self.ticks = ticks
    }

    public func toSeconds() -> Int64 {
        return ticks / TimeSpan.ticksPerSecond
    }

    public static func +(lhs: TimeSpan, rhs: TimeSpan) -> TimeSpan {
        return try! TimeSpan(ticks: lhs.ticks + rhs.ticks)
    }

    public static func -(lhs: TimeSpan, rhs: TimeSpan) -> TimeSpan {
        return try! TimeSpan(ticks: lhs.ticks - rhs.ticks)
    }

    public func description() -> String {
        let sign = ticks < 0 ? "-" : ""
        return String(format: "\(sign)%d:%02d:%02d:%02d.%03d%03d%03d", abs(days), hours, minutes, seconds, milliseconds, microseconds, nanoseconds)
    }

    // Equatable
    public static func ==(lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs.ticks == rhs.ticks
    }

    public static func !=(lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs.ticks != rhs.ticks
    }

    // Comparable
    public static func <(lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs.ticks < rhs.ticks
    }

    public static func <=(lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs.ticks <= rhs.ticks
    }

    public static func >(lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs.ticks > rhs.ticks
    }

    public static func >=(lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs.ticks >= rhs.ticks
    }
}

public extension TimeSpan {
    static func fromDays(_ days: Int) throws -> TimeSpan {
        return try TimeSpan(days: days)
    }

    static func fromHours(_ hours: Int) throws -> TimeSpan {
        return try TimeSpan(hours: hours)
    }

    static func fromMinutes(_ minutes: Int) throws -> TimeSpan {
        return try TimeSpan(minutes: minutes)
    }

    static func fromSeconds(_ seconds: Int) throws -> TimeSpan {
        return try TimeSpan(seconds: seconds)
    }

    static func fromMilliseconds(_ milliseconds: Int) throws -> TimeSpan {
        return try TimeSpan(milliseconds: milliseconds)
    }

    static func fromMicroseconds(_ microseconds: Int) throws -> TimeSpan {
        return try TimeSpan(microseconds: microseconds)
    }

    static func fromNanoseconds(_ nanoseconds: Int) throws -> TimeSpan {
        return try TimeSpan(nanoseconds: nanoseconds)
    }
    
    static func fromTimeInterval(_ timeInterval: TimeInterval) throws -> TimeSpan {
        let ticks = Int64(timeInterval * Double(TimeSpan.ticksPerSecond))
        if ticks < TimeSpan.minTicks || ticks > TimeSpan.maxTicks {
            throw TimeSpanError.outOfRange("Ticks value out of range")
        }
        return try TimeSpan(ticks: ticks)
    }
}