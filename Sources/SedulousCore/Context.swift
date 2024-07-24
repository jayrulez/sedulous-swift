public typealias ContextInitializingCallback = (_ initializer: ContextInitializer) -> Void;
public typealias ContextInitializedCallback = (_ context: Context) -> Void;
public typealias ContextShuttingDownCallback = (_ context: Context) -> Void;

public class Context
{
    public private(set) var host: ContextHost;

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
    func update()
    {

    }
} 