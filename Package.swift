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
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "IMDBMoviesAPI",
            targets: ["IMDBMoviesAPI"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "IMDBMoviesAPI",
            dependencies: [],
            resources: [
                .process("Resources/Config.json")
            ]
        ),
        .testTarget(
            name: "IMDBMoviesAPITests",
            dependencies: ["IMDBMoviesAPI"]),
    ]
)
