// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sedulous",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SedulousFoundation",
            targets: ["SedulousFoundation"]),
        .library(
            name: "SedulousCore",
            targets: ["SedulousCore"]),
        .library(
            name: "SedulousPlatform",
            targets: ["SedulousPlatform"]),
        .library(
            name: "SedulousSDL2Platform",
            targets: ["SedulousSDL2Platform"]),
        .executable(
            name: "Sandbox",
            targets: ["Sandbox"]),
        .plugin(name: "CopyFilesPlugin", targets: ["CopyFilesPlugin"])
    ],
    dependencies: [
        .package(name: "SDL2", path: "Sources/Dependencies/SDL2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SedulousFoundation",
            path: "Sources/Sedulous/Foundation"),
        .target(
            name: "SedulousCore",
            dependencies: ["SedulousFoundation"],
            path: "Sources/Sedulous/Core"),
        .target(
            name: "SedulousPlatform",
            dependencies: ["SedulousFoundation", "SedulousCore"],
            path: "Sources/Sedulous/Platform"),
        .target(
            name: "SedulousSDL2Platform",
            dependencies: [
                "SedulousFoundation", 
                "SedulousCore", 
                "SedulousPlatform", 
                .product(name: "SDL2", package: "SDL2")
            ],
            path: "Sources/Sedulous/SDL2Platform"),
        .executableTarget(
            name: "Sandbox",
            dependencies: ["SedulousFoundation", "SedulousCore", "SedulousPlatform", "SedulousSDL2Platform"],
            path: "Sources/Samples/Sandbox",
            resources: [
                .copy("../../Dependencies/SDL2/Libs")
            ],
            plugins: [
                "CopyFilesPlugin"
            ]),
        .testTarget(
            name: "SedulousFoundationTests",
            dependencies: ["SedulousFoundation"]
        ),
        .plugin(
            name: "CopyFilesPlugin", 
            capability: .command(
                intent: .custom(
                    verb: "copy-files", 
                    description: "Copy files"
                ), 
                permissions: []
            )
        )
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx20
)
