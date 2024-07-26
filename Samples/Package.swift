// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Samples",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .executable(
            name: "Sandbox",
            targets: ["Sandbox"]),
        .executable(
            name: "RHI",
            targets: ["RHI"]),
    ],
    dependencies: [
        .package(name: "Sedulous", path: "../Sedulous")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "Sandbox",
            dependencies: [
                .product(name: "SedulousFoundation", package: "Sedulous"), 
                .product(name: "SedulousCore", package: "Sedulous"), 
                .product(name: "SedulousPlatform", package: "Sedulous"), 
                .product(name: "SedulousSDL2Platform", package: "Sedulous"),
                ],
            path: "Sources/Sandbox",
            resources: [
            ]
		),
        .executableTarget(
            name: "RHI",
            dependencies: [
                .product(name: "SedulousFoundation", package: "Sedulous"), 
                .product(name: "SedulousCore", package: "Sedulous"), 
                .product(name: "SedulousPlatform", package: "Sedulous"), 
                .product(name: "SedulousSDL2Platform", package: "Sedulous"), 
                .product(name: "SedulousRHI", package: "Sedulous"), 
                .product(name: "SedulousVulkanRHI", package: "Sedulous"), 
                .product(name: "SedulousGraphics", package: "Sedulous")
                ],
            path: "Sources/RHI",
            resources: [
            ]
		),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx20
)
