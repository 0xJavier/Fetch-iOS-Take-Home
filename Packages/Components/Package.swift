// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Components",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "Components", targets: ["Components"]),
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Networking", path: "../Networking")
    ],
    targets: [
        .target(
            name: "Components",
            dependencies: [
                .product(name: "Models", package: "Models"),
                .product(name: "Networking", package: "Networking")
            ]
        ),
        .testTarget(
            name: "ComponentsTests",
            dependencies: ["Components"]
        ),
    ]
)
