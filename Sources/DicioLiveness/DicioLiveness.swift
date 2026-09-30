// The Swift Programming Language
// https://docs.swift.org/swift-book
import FaceTecSDK
import DicioLivenessUI
#if DEBUG





public struct DicioLiveness {
    
    public static func initializeSDK() {
        print("🚀 [DicioLV] initializeSDK()")
        print("Ejecutando en modo Desarrollo (Debug)")
        DicioLVConfigurator.moduleBundle = BundleHelper.resourcesBundle
        
    }
}

#else




public struct DicioLiveness {
    public static func initializeSDK() {
        print("Ejecutando en modo Producción (Release)")
        print("🚀 [DicioLV] initializeSDK()")
        DicioLVConfigurator.moduleBundle = BundleHelper.resourcesBundle
        
    }
}

#endif




