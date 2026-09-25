//
//  BundleHelper.swift
//  DicioLiveness
//
//  Created by Rodrigo Sánchez on 25/09/26.
//

import Foundation

public struct BundleHelper {
    public static var resourcesBundle: Bundle {
        print("🕵️‍♂️ [DicioLV] 1. Iniciando auditoría profunda de recursos en disco...")
        

        let targetFiles = ["acercate.mp3", "iniciando.mp3", "intenta_de_nuevo.mp3", "muchas_gracias.mp3", "retira_lentes_gorra_cubrebocas.mp3", "tomate_una_foto.mp3", "un_momento_porfavor.mp3", "Assets.car", "FaceTecContainerViewController.xib"]
        let allBundles = Bundle.allBundles + Bundle.allFrameworks
        let fm = FileManager.default
        
        for bundle in allBundles {
            guard let bundlePath = bundle.resourcePath else { continue }
            
            do {
                let contents = try fm.contentsOfDirectory(atPath: bundlePath)
                

                if let match = contents.first(where: { targetFiles.contains($0) }) {
                    print("✅ [DicioLV] 2. ¡ÉXITO! Archivo '\(match)' encontrado en raíz: \(bundle.bundlePath)")
                    return bundle
                }
                

                let subBundles = contents.filter { $0.hasSuffix(".bundle") }
                for sub in subBundles {
                    let subPath = bundlePath + "/" + sub
                    let subContents = try fm.contentsOfDirectory(atPath: subPath)
                    
                    if let subMatch = subContents.first(where: { targetFiles.contains($0) }) {
                        print("✅ [DicioLV] 2. Archivo '\(subMatch)' encontrado en sub-bundle: \(subPath)")
                        return Bundle(path: subPath) ?? bundle
                    }
                }
            } catch {
                continue
            }
        }
        
        print("🚨 [DicioLV] FATAL: SPM NO incluyó los archivos físicos en el Build de HostSPM.")
        return Bundle.main
    }
}
