import Foundation

/// Comparison options.
enum ComparisonFunction: UInt8 {
    /// Never pass the comparison.
    case never
    /// If the source data is less than the destination data, the comparison passes.
    case less
    /// If the source data is equal to the destination data, the comparison passes.
    case equal
    /// If the source data is less than or equal to the destination data, the comparison passes.
    case lessEqual
    /// If the source data is greater than the destination data, the comparison passes.
    case greater
    /// If the source data is not equal to the destination data, the comparison passes.
    case notEqual
    /// If the source data is greater than or equal to the destination data, the comparison passes.
    case greaterEqual
    /// Always pass the comparison.
    case always
}
