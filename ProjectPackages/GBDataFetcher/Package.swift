// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GBDataFetcher",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "GBDataFetcher",
            targets: ["GBDataFetcher"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GBDataFetcher",
            dependencies: []),
        .testTarget(
            name: "GBDataFetcherTests",
            dependencies: ["GBDataFetcher"],
            resources: [.process("Resources",
                                 localization: nil)]),
    ]
)
