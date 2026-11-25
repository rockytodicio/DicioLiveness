// The Swift Programming Language
// https://docs.swift.org/swift-book
import FaceTecSDK
import DicioLivenessUI

public struct DicioLiveness {
        public static func initializeSDK() {
            print("🚀 [DicioLV] initializeSDK()")
            let bundle = BundleHelper.resourcesBundle
            DicioLVConfigurator.moduleBundle = bundle
            FaceTec.sdk.setLanguage("es")
            FaceTec.sdk.configureLocalization(withTable: "FaceTec", bundle: bundle)
            if let stringsPath = bundle.path(forResource: "FaceTec", ofType: "strings"),
               let stringsDict = NSDictionary(contentsOfFile: stringsPath) as? [String: String] {
                FaceTec.sdk.setDynamicStrings(stringsDict)
            }
        }
}






