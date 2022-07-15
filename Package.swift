// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lorem",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Lorem",
            targets: ["Lorem"]
        ),
    ],
    targets: [
        .target(
            name: "Lorem",
            resources: [
                .process("Resources/symbols-1.txt"),
                .process("Resources/symbols-2.txt"),
                .process("Resources/symbols-3.txt"),
                .process("Resources/symbols-4.txt"),
            ]
        ),
    ]
)
