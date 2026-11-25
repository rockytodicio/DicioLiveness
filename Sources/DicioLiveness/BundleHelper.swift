//
//  BundleHelper.swift
//  DicioLiveness
//
//  Created by Rodrigo Sánchez on 25/09/26.
//

import Foundation

public struct BundleHelper {
    public static var resourcesBundle: Bundle {
        // 1. En SPM, Bundle.module apunta directamente a DicioLiveness_DicioLiveness.bundle sin posibilidad de equivocarse:
        #if SWIFT_PACKAGE
        return Bundle.module
        #endif

        // 2. Búsqueda de respaldo (SIN "Assets.car" para nunca confundirse con el Assets.car de la App Host):
        let targetFiles = [
            "FaceTec.strings",
            "acercate.mp3",
            "iniciando.mp3",
            "intenta_de_nuevo.mp3",
            "muchas_gracias.mp3",
            "retira_lentes_gorra_cubrebocas.mp3",
            "tomate_una_foto.mp3",
            "un_momento_porfavor.mp3",
            "FaceTecContainerViewController.nib"
        ]
        let allBundles = Bundle.allFrameworks + Bundle.allBundles
        let fm = FileManager.default

        for bundle in allBundles {
            guard let bundlePath = bundle.resourcePath else { continue }
            do {
                let contents = try fm.contentsOfDirectory(atPath: bundlePath)
                let subBundles = contents.filter { $0.hasSuffix(".bundle") }
                for sub in subBundles {
                    let subPath = bundlePath + "/" + sub
                    let subContents = try fm.contentsOfDirectory(atPath: subPath)
                    if subContents.contains(where: { targetFiles.contains($0) }) {
                        return Bundle(path: subPath) ?? bundle
                    }
                }
                if contents.contains(where: { targetFiles.contains($0) }) {
                    return bundle
                }
            } catch {
                continue
            }
        }
        return Bundle.main
    }
}
