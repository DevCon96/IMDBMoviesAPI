// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IMDBMoviesAPI",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "IMDBMoviesAPI",
            targets: ["IMDBMoviesAPI"]),
        .library(
            name: "IMDBMoviesTestHelper",
            targets: ["IMDBMoviesTestHelper"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "IMDBMoviesAPI",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "IMDBMoviesTestHelper",
            dependencies: ["IMDBMoviesAPI"]
        ),
        .testTarget(
            name: "IMDBMoviesAPITests",
            dependencies: ["IMDBMoviesAPI", "IMDBMoviesTestHelper"],
            resources: [
                .copy("Resources")
            ]
        )
    ]
)
