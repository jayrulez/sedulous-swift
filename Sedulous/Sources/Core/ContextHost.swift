public protocol ContextHost : AnyObject
{
    var suspended: Bool { get }
    func exit() -> Void;
}