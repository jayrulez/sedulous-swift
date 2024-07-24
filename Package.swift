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
            name: "SedulousPlatformSDL2",
            targets: ["SedulousPlatformSDL2"]),
        .executable(
            name: "Sandbox",
            targets: ["Sandbox"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SedulousFoundation"),
        .target(
            name: "SedulousCore",
            dependencies: ["SedulousFoundation"]),
        .target(
            name: "SedulousPlatform",
            dependencies: ["SedulousFoundation", "SedulousCore"]),
        .target(
            name: "SedulousPlatformSDL2",
            dependencies: ["SedulousFoundation", "SedulousCore", "SedulousPlatform"]),
        .target(
            name: "Sedulous"),
        .executableTarget(
            name: "Sandbox",
            dependencies: ["SedulousFoundation", "SedulousCore", "SedulousPlatform", "SedulousPlatformSDL2"]),
        .testTarget(
            name: "SedulousFoundationTests",
            dependencies: ["SedulousFoundation"]
        ),
    ]
)
