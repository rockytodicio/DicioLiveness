// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if DEBUG
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
            name: "DicioLivenessUI",
            path: "Frameworks/Dev/DicioLivenessUI.xcframework"
        ),
        
        // 2. Dependencia de FaceTec pre-compilada
        .binaryTarget(
            name: "FaceTecSDK",
            path: "Frameworks/Dev/FaceTecSDKForDevelopment.xcframework"
        ),
        
        // 3. Target envoltorio que junta tu SDK, FaceTec y los Recursos
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
