import Foundation;

open class System
{
    public private(set) var name: String;
    
    public private(set) var context: Context?;

    public init(_ name: String)
    {
        self.name = name;
    }

    package func initialize(_ context: Context) -> Bool
    {
        onInitialize(context);

        self.context = context;

        return true;
    }

    package func shutdown()
    {
        onShutdown();
        context = nil;
    }

    open func onInitialize(_ context: Context) { }

    open func onShutdown() { }
}