// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GBAppFlows",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GBAppFlows",
            targets: ["GBAppFlows"]),
    ],
    dependencies: [
            .package(name: "GBVisualComponents",
                     path: "../GBVisualComponents"),
            .package(name: "GBDataFetcher",
                     path: "../GBDataFetcher")
    ],
    targets: [
        .target(
            name: "GBAppFlows",
            dependencies: ["GBVisualComponents", "GBDataFetcher"]),
        .testTarget(
            name: "GBAppFlowsTests",
            dependencies: ["GBAppFlows"]),
    ]
)
