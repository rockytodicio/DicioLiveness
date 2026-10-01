// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if DEBUG
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
<<<<<<< HEAD
            path: "Frameworks/DicioLivenessUIProd.xcframework"
=======
            path: "Frameworks/Dev/DicioLivenessUI.xcframework"
>>>>>>> 14cd1b75911a6f01a9d6d1f5f4fd1e04bc7254bb
        ),
        

        .binaryTarget(
            name: "FaceTecSDK",
            path: "Frameworks/Dev/FaceTecSDKForDevelopment.xcframework"
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
<<<<<<< HEAD

=======
#else
let package = Package(
    name: "DicioLiveness",
    platforms: [
        .iOS(.v16) // Ajusta si requieres una versión mínima distinta
    ],
    products: [
        .library(
            name: "DicioLiveness",
            targets: ["DicioLiveness"]
        ),
    ],
    dependencies: [
        // Nada aquí. Inyectamos FaceTecSDK localmente como binaryTarget para evitar colisiones.
    ],
    targets: [
        // 1. Tu framework SDK principal
        .binaryTarget(
            name: "DicioLivenessUI-Prod",
            path: "Frameworks/Prod/DicioLivenessUI-Prod.xcframework"
        ),
        
        // 2. Dependencia de FaceTec pre-compilada
        .binaryTarget(
            name: "FaceTecSDK",
            path: "Frameworks/Prod/FaceTecSDK.xcframework"
        ),
        
        // 3. Target envoltorio que junta tu SDK, FaceTec y los Recursos
        .target(
            name: "DicioLiveness",
            dependencies: [
                "DicioLivenessUI-Prod",
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
#endif
>>>>>>> 14cd1b75911a6f01a9d6d1f5f4fd1e04bc7254bb
