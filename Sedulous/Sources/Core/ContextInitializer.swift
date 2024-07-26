public class ContextInitializer
{
    internal var systems: [System] = .init();

    package init() { }

    @discardableResult
    public func addSystem(_ system: System) -> Self
    {
        if !systems.contains(where: { element in  return element === system }) {
            systems.append(system);
        }
        return self;
    }
}