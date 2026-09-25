// The Swift Programming Language
// https://docs.swift.org/swift-book
import DicioLivenessUI
import FaceTecSDK


public struct DicioLiveness {
    public static func initializeSDK() {
        print("🚀 [DicioLV] initializeSDK()")
        DicioLVConfigurator.moduleBundle = BundleHelper.resourcesBundle
        
    }
}
