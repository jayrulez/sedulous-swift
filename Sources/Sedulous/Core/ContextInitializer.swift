public class ContextInitializer
{
    internal var systems: [any System] = .init();

    package init()
    {

    }

    deinit
    {

    }

    public func addSystem(_ system: any System) -> Self
    {
        //if !systems.contains(system) {
        //    systems.append(system);
        //}
        return self;
    }
}