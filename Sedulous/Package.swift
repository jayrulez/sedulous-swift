// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let cSettings: [CSetting] = [
    .define("VK_USE_PLATFORM_WIN32_KHR",   .when(platforms:[.windows])),
    .define("VK_USE_PLATFORM_ANDROID_KHR", .when(platforms:[.android])),
    .define("VK_USE_PLATFORM_WAYLAND_KHR", .when(platforms:[.linux])),
    .unsafeFlags(
        [
            "-I../Dependencies/Vulkan/Sources/CVulkan/include"
        ]
    )
];

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
        .library(
            name: "SedulousRHI",
            targets: ["SedulousRHI"]),
        .library(
            name: "SedulousVulkanRHI",
            targets: ["SedulousVulkanRHI"]),
        .library(
            name: "SedulousGraphics",
            targets: ["SedulousGraphics"]),
        .plugin(name: "CopyFilesPlugin", targets: ["CopyFilesPlugin"])
    ],
    dependencies: [
        .package(name: "SDL2", path: "../Dependencies/SDL2"),
        .package(name: "Vulkan", path: "../Dependencies/Vulkan"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SedulousFoundation",
            path: "Sources/Foundation"),
        .target(
            name: "SedulousCore",
            dependencies: ["SedulousFoundation"],
            path: "Sources/Core"),
        .target(
            name: "SedulousPlatform",
            dependencies: ["SedulousFoundation", "SedulousCore"],
            path: "Sources/Platform"),
        .target(
            name: "SedulousSDL2Platform",
            dependencies: [
                "SedulousFoundation", 
                "SedulousCore", 
                "SedulousPlatform", 
                .product(name: "SDL2", package: "SDL2")
            ],
            path: "Sources/SDL2Platform"),
        .target(
            name: "SedulousRHI",
            dependencies: ["SedulousCore", "SedulousPlatform"],
            path: "Sources/RHI",
            cSettings: cSettings
        ),
        .target(
            name: "SedulousVulkanRHI",
            dependencies: [
                "SedulousCore", 
                "SedulousPlatform", 
                "SedulousRHI",
                .product(name: "CVulkan", package: "Vulkan"),
                .product(name: "Vulkan", package: "Vulkan")
            ],
            path: "Sources/VulkanRHI",
            cSettings: cSettings,
            linkerSettings: [
                .linkedLibrary("../Dependencies/Vulkan/Libs/win32-x64/vulkan-1", .when(platforms: [.windows])),
            ]
        ),
        .target(
            name: "SedulousGraphics",
            dependencies: ["SedulousCore", "SedulousPlatform", "SedulousRHI"],
            path: "Sources/Graphics",
            cSettings: cSettings
        ),
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
