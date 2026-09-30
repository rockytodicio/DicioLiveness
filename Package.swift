// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
/*
 var pathFTEnv = ""
 var pathLVEnv = ""

 #if DEBUG
 pathFTEnv = "Frameworks/FaceTecSDKForDevelopment.xcframework"
 pathLVEnv = "Frameworks/DicioLivenessUI.xcframework"

 #else
 //RELEASE
 pathFTEnv = "Frameworks/FaceTecSDK.xcframework"
 pathLVEnv = "Frameworks/DicioLivenessUIProd.xcframework"
 #endif
 */


let package = Package(
    name: "DicioLiveness",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "DicioLiveness",
            targets: ["DicioLiveness"]
        ),
    ],
    dependencies: [

    ],
    targets: [

        .binaryTarget(
            name: "DicioLivenessUI",
            path: "Frameworks/DicioLivenessUIProd.xcframework"
        ),
        

        .binaryTarget(
            name: "FaceTecSDK",
            path: "Frameworks/FaceTecSDK.xcframework"
        ),
        

        .target(
            name: "DicioLiveness",
            dependencies: [
                "DicioLivenessUI",
                "FaceTecSDK"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "DicioLivenessTests",
            dependencies: ["DicioLiveness"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)

