// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DicioLiveness",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DicioLiveness",
            targets: ["DicioLiveness"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "DicioLivenessUI",
            path: "Frameworks/DicioLivenessUI.xcframework"),
        .binaryTarget(
            name: "FaceTecSDK",
            path: "Frameworks/FaceTecSDK.xcframework"),
        .target(
            name: "DicioLiveness",
            dependencies: [
                "DicioLivenessUI",
                "FaceTecSDK"
            ]
        ),
        .testTarget(
            name: "DicioLivenessTests",
            dependencies: ["DicioLiveness"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
