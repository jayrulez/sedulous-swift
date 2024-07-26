import Foundation
import PackagePlugin

@main
struct CopyFilesPlugin : CommandPlugin, BuildToolPlugin {
    public func performCommand(context: PluginContext, arguments: [String]) throws -> Void
    {
        print("Directory: \(context.package.directoryURL)");
    }

    public func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command]
    {
        print("Directory: \(context.package.directoryURL)");
        return [];
    }
}