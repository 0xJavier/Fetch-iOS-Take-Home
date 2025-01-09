// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "HomeFeature", targets: ["HomeFeature"]),
        .library(name: "RecipeDetailFeature", targets: ["RecipeDetailFeature"]),
    ],
    dependencies: [
        .package(name: "Components", path: "../Components"),
        .package(name: "Models", path: "../Models"),
        .package(name: "Networking", path: "../Networking"),
    ],
    targets: [
        .target(
            name: "RecipeDetailFeature",
            dependencies: [
                .product(name: "Components", package: "Components"),
                .product(name: "Models", package: "Models"),
                .product(name: "Networking", package: "Networking"),
            ]
        ),
        .testTarget(
            name: "RecipeDetailFeatureTests",
            dependencies: ["RecipeDetailFeature"]
        ),
        .target(
            name: "HomeFeature",
            dependencies: [
                .product(name: "Components", package: "Components"),
                .product(name: "Models", package: "Models"),
                .product(name: "Networking", package: "Networking"),
            ]
        ),
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: ["HomeFeature"]
        )
    ]
)

