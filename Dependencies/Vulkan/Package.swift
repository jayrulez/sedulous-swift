// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let cSettings: [CSetting] = [
    //.headerSearchPath("include"),
    //.define("__WIN32__", .when(platforms: [.windows])),
    .define("VK_USE_PLATFORM_WIN32_KHR",   .when(platforms:[.windows])),
    .define("VK_USE_PLATFORM_ANDROID_KHR", .when(platforms:[.android])),
    .define("VK_USE_PLATFORM_WAYLAND_KHR", .when(platforms:[.linux])),
    .unsafeFlags(
        [
            "-ISources/CVulkan/include",
            "-I../Dependencies/Vulkan/Sources/CVulkan/include",
        ]
    )
];

let package = Package(
    name: "Vulkan",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Vulkan",
            targets: ["Vulkan"]),
        .library(
            name: "CVulkan",
            targets: ["CVulkan"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Vulkan",
            dependencies: ["CVulkan"],
            cSettings: cSettings
        ),
        .target(
            name: "CVulkan",
            publicHeadersPath: ".",
            cSettings: cSettings
        )
    ],
    cLanguageStandard: .c11
)
