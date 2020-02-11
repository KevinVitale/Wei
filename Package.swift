// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Wei",
    platforms: [
        .macOS(.v10_10),
    ],
    products: [
        .library( name: "Wei", targets: ["Wei"]),
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.0.0")
    ],
    targets: [
        .target( name: "Wei", dependencies: ["BigInt"] ),
        .testTarget( name: "WeiTests", dependencies: ["Wei"] ),
    ]
)
