public protocol ContextHost
{
    var suspended: Bool { get }
    func exit() -> Void;
}