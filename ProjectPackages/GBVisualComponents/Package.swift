// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GBVisualComponents",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GBVisualComponents",
            targets: ["GBVisualComponents"])
    ],
    dependencies: [
        .package(name: "GBDataFetcher",
                 path: "../GBDataFetcher")
    ],
    targets: [
        .target(
            name: "GBVisualComponents",
            dependencies: []),
        .testTarget(
            name: "GBVisualComponentsTests",
            dependencies: ["GBVisualComponents"]),
    ]
)
