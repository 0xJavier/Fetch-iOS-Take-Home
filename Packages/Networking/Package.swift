// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "Networking", targets: ["Networking"]),
    ],
    dependencies: [
        .package(name: "Models", path: "../Models")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Models", package: "Models"),
            ],
            resources: [
                .process("fetch-valid-response.json"),
                .process("fetch-invalid-response.json"),
                .process("fetch-empty-response.json")
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),
    ]
)
