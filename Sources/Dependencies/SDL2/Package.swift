// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SDL2",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SDL2",
            targets: ["SDL2"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SDL2",
            dependencies: ["CSDL2"]
        ),
        .target(
            name: "CSDL2",
            publicHeadersPath: ".",
            cSettings: [
                //.headerSearchPath("include"),
                .define("__WIN32__", .when(platforms: [.windows]))
            ]
        )
    ],
    cLanguageStandard: .c11
)
