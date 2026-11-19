
# Prueba de Vida (DicioLiveness)

El propósito de este documento es proporcionar a los desarrolladores una guía completa sobre cómo integrar e implementar el paquete **DicioLiveness** en aplicaciones iOS utilizando **Swift Package Manager (SPM)** y **SwiftUI**.
El SDK permite validar la presencia física y autenticidad del usuario en tiempo real (prueba de vida 3D), previniendo intentos de suplantación de identidad mediante fotos, videos, avatares o máscaras, de forma ágil y segura.

Al invocar el módulo de Liveness, el SDK guía al usuario paso a paso:
1. **Inicialización y Validación:** Verificación de credenciales/tokens con el backend de Dicio y aprovisionamiento seguro de la sesión biométrica.
2. **Captura Guiada e Interactiva:** Encuadre del rostro mediante un óvalo inteligente con retroalimentación visual en tiempo real y asistencia vocal.
3. **Verificación y Resultado:** Procesamiento de escaneo facial 3D cifrado y retorno del resultado estructurado (JSON, estatus de éxito y fotografía del usuario en Base64).

### Instalación mediante Swift Package Manager (SPM)
El SDK se distribuye como un paquete de Swift Package Manager, el cual administra automáticamente los binarios y dependencias requeridas (`DicioLivenessUI` y `FaceTecSDK`).

Sigue estos pasos para agregarlo a tu proyecto en Xcode:
1. Abre tu proyecto en **Xcode**.    
2. Ve al menú superior y selecciona **File** > **Add Package Dependencies...** (o selecciona tu proyecto en el navegador, ve a la pestaña **Package Dependencies** y presiona el botón **`+`**).    
3. En la barra de búsqueda superior derecha, ingresa la URL del repositorio del Package:    
    #### Repositorio SPM   
    ```
    https://bitbucket.org/juarezsdco/dicioliveness-package
    ```
4. En la sección **Dependency Rule**, selecciona **Branch** e indica la rama correspondiente según tu entorno:    
    - **`main`**: Esta rama contiene los frameworks y la configuración necesaria para que las aplicaciones integradoras (_Host Apps_) realicen su build para **despliegue a producción**.
    - **`development`**: Esta rama contiene los frameworks y la configuración necesaria para que las aplicaciones integradoras (_Host Apps_) realicen **pruebas y testing** (entornos de desarrollo / QA).
Selección de Rama (Dependency Rule)
- **Producción:** Selecciona la rama `main` para compilar y desplegar versiones finales de tu aplicación.
- **Testing / Pruebas:** Selecciona la rama `development` para realizar pruebas de integración y validaciones en desarrollo.
5. En la ventana emergente de selección de productos, marca **DicioLiveness** y asegúrate de asignarlo al target de tu aplicación anfitriona (_Host App_).
6. Presiona **Add Package** para finalizar la integración.
### Requisitos Previos y Permisos

### 1. Permiso de Cámara en Info.plist

El SDK requiere acceso a la cámara frontal del dispositivo para la detección y escaneo biométrico. Agrega la clave `NSCameraUsageDescription` en el archivo `Info.plist` de tu aplicación o en la sección **Info** del target:

#### Info.plist

```xml
<key>NSCameraUsageDescription</key><string>Se requiere acceso a la cámara para realizar la prueba de vida y validación de identidad.</string>
```

### 2. Importación del Módulo

En los archivos Swift donde vayas a utilizar la interfaz de Liveness, importa el framework:

#### Import

```swift
import SwiftUI
import DicioLivenessUI
```

### Personalización de la Apariencia (LivenessUIConfig)

La estructura `LivenessUIConfig` permite configurar la paleta de colores (en formato hexadecimal) y el logotipo institucional que se presentará en la interfaz de la prueba de vida:

#### LivenessUIConfig
```swift
let uiConfig = LivenessUIConfig(
    outerColorFondo: "#FFFFFF",             // Color de fondo exterior de la interfaz
    colorFrame: "#F5F5F5",                  // Color del marco/subvista central
    colorBorde: "#FF5733",                  // Color del borde divisor del marco
    colorOvalo: "#AABBCC",                  // Color del óvalo de encuadre facial
    colorSpinnerDual: "#0080FF",            // Color del spinner durante la detección
    colorTexto: "#000000",                  // Color del texto de instrucciones
    colorBtnYFeedbackBar: "#4D21B2",        // Color del botón de acción y barra de feedback
    colorBtnAndFeedbackBarText: "#FFFFFF",  // Color del texto del botón y barra de feedback
    colorBtnHighlight: "#2B0877",           // Color del botón en estado presionado
    colorBtnDisabled: "#EFEFEF",            // Color del botón en estado deshabilitado
    livenessLogo: "logoInstitucional"       // Nombre del recurso en Assets.xcassets
)
```

#### Detalle de Parámetros:
- **`outerColorFondo`** _(String)_: Color de fondo general de la interfaz de prueba de vida.
- **`colorFrame`** _(String)_: Color del contenedor interno donde se ubican las instrucciones y la vista previa.
- **`colorBorde`** _(String)_: Color de la línea o borde divisor del marco de captura.
- **`colorOvalo`** _(String)_: Color del contorno del óvalo guía para posicionar el rostro.
- **`colorSpinnerDual`** _(String)_: Color de la animación de carga/procesamiento durante el escaneo facial.
- **`colorTexto`** _(String)_: Color de las etiquetas de texto con instrucciones en pantalla.
- **`colorBtnYFeedbackBar`** _(String)_: Color de fondo para el botón principal de acción y la barra de estado.
- **`colorBtnAndFeedbackBarText`** _(String)_: Color de texto del botón de acción y la barra de estado.
- **`colorBtnHighlight`** _(String)_: Color del botón al ser presionado por el usuario.
- **`colorBtnDisabled`** _(String)_: Color del botón cuando se encuentra inactivo o deshabilitado.
- **`livenessLogo`** _(String)_: Nombre del archivo de imagen en el catálogo de `Assets.xcassets` de tu app para branding.

Notas de Configuración
- Todos los colores deben especificarse en formato hexadecimal válido (`#RRGGBB`).
- El recurso asignado a `livenessLogo` debe existir dentro de `Assets.xcassets` de la aplicación anfitriona.

### Invocación de la Vista de Liveness (LivenessLaunchView)
La vista principal de entrada al flujo de prueba de vida es `LivenessLaunchView`. Se inicializa con los parámetros de conexión, configuración visual, reintentos, audio y el delegado para recibir el resultado:

#### LivenessLaunchView Init
```swift
LivenessLaunchView(
    config: uiConfig,
    urlVerify: "https://api.devdicio.net:8444/v1/sec_dev_fintech_pagos_middleware",
    token: "TOKEN_BEARER_PROPORCIONADO_POR_DICIO",
    showCancelButton: false,
    maxAttempts: 3,
    soundEnable: true,
    delegate: self
)
```

### Parámetros de Inicialización:
1. **`config`** _(LivenessUIConfig)_: Objeto con la personalización visual de colores y logo.
2. **`urlVerify`** _(String)_: Endpoint del servicio Dicio encargado de la verificación de credenciales y provisión de licencias dinámicas.
3. **`token`** _(String)_: Token Bearer de autorización generado por el backend de Dicio.
4. **`showCancelButton`** _(Bool)_: Indica si se debe mostrar el botón visible para cancelar el flujo.
5. **`maxAttempts`** _(Int)_: Número máximo de intentos permitidos para la prueba de vida (ej. `3`).
6. **`soundEnable`** _(Bool)_: Habilita (`true`) o deshabilita (`false`) la guía por voz y sonidos de asistencia.
7. **`delegate`** _(CaptureFaceResultsDelegate?)_: Objeto delegado que recibe la respuesta final del escaneo.

### Implementación del Protocolo CaptureFaceResultsDelegate

Para recibir el estatus, los datos de respuesta y la imagen facial resultante, la clase o estructura correspondiente debe conformar el protocolo `CaptureFaceResultsDelegate`.

#### Protocolo CaptureFaceResultsDelegate

```swift
public protocol CaptureFaceResultsDelegate {
    func finishedLiveness(isSuccessfull: Bool, JSONResults: String, picBase64: String)
}
```

### Método del Delegado:

#### `finishedLiveness`
Se ejecuta al concluir el flujo de prueba de vida (sea aprobada, fallida o cancelada).
#### finishedLiveness
```swift
func finishedLiveness(isSuccessfull: Bool, JSONResults: String, picBase64: String) {
    // isSuccessfull: true si la prueba de vida 3D fue superada con éxito, false en caso contrario
    // JSONResults: Cadena JSON con la respuesta y metadatos de la verificación en el backend
    // picBase64: Fotografía facial (selfie de auditoría) en formato Base64
}
```

### Personalización de Textos (Opcional - FaceTec.strings)

Si requieres sobreescribir o traducir los textos por defecto de la interfaz biométrica de FaceTec, puedes agregar un archivo llamado `FaceTec.strings` en el bundle principal de tu aplicación (_Copy Bundle Resources_):

#### FaceTec.strings (Ejemplo)

```json
"FaceTec_instructions_header_ready_1" = "Prepárate para";
"FaceTec_instructions_header_ready_2" = "tu videoselfie";
"FaceTec_instructions_message_ready_1" = "Encuadra tu rostro en el óvalo";
"FaceTec_instructions_message_ready_2" = "Presiona Estoy listo y acércate";
"FaceTec_action_im_ready" = "Estoy listo";
"FaceTec_action_try_again" = "Intentar nuevamente";
"FaceTec_feedback_center_face" = "Centra tu rostro";
"FaceTec_feedback_face_not_found" = "Encuadra tu rostro";
"FaceTec_feedback_move_phone_closer" = "Acércate";
"FaceTec_feedback_move_phone_away" = "Apártate";
"FaceTec_result_facescan_upload_message" = "Subiendo\nel escaneo facial 3D\ncifrado";
"FaceTec_result_success_message" = "Listo";
```

### Ejemplo Completo de Integración en SwiftUI
A continuación se muestra una integración completa en SwiftUI basada en un contenedor presentado con `.fullScreenCover`:
#### Ejemplo de Integración SwiftUI

```swift
import SwiftUI
import DicioLivenessUI

struct HostLivenessView: View {
    @State private var showLivenessScanner = false
    @State private var statusMessage: String = "Presiona el botón para iniciar la prueba de vida"
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Validación de Identidad")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(statusMessage)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                showLivenessScanner = true
            }) {
                Text("Iniciar Prueba de Vida")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 30)
        }
        .fullScreenCover(isPresented: $showLivenessScanner) {
            let uiConfig = LivenessUIConfig(
                outerColorFondo: "#FFFFFF",
                colorFrame: "#F5F5F5",
                colorBorde: "#FF5733",
                colorOvalo: "#AABBCC",
                colorSpinnerDual: "#0080FF",
                colorTexto: "#000000",
                colorBtnYFeedbackBar: "#4D21B2",
                colorBtnAndFeedbackBarText: "#FFFFFF",
                colorBtnHighlight: "#2B0877",
                colorBtnDisabled: "#EFEFEF",
                livenessLogo: "logoInstitucional"
            )
            
            DicioLivenessContainerView(
                config: uiConfig,
                urlVerify: "https://api.devdicio.net:8444/v1/sec_dev_fintech_pagos_middleware",
                token: "TOKEN_PROPORCIONADO_POR_DICIO",
                onFinish: { isSuccess in
                    showLivenessScanner = false
                    statusMessage = isSuccess ? "✅ Prueba de vida completada con éxito" : "❌ Prueba de vida no aprobada"
                }
            )
        }
    }
}

struct DicioLivenessContainerView: View, CaptureFaceResultsDelegate {
    let config: LivenessUIConfig
    let urlVerify: String
    let token: String
    let onFinish: (Bool) -> Void
    
    // MARK: - CaptureFaceResultsDelegate
    func finishedLiveness(isSuccessfull: Bool, JSONResults: String, picBase64: String) {
        print("🧑‍🦱 [DicioLiveness] Resultado: éxito=\(isSuccessfull), longitud json=\(JSONResults.count)")
        if isSuccessfull {
            print("📸 [DicioLiveness] Foto Base64 recibida: \(picBase64.prefix(30))...")
        }
        onFinish(isSuccessfull)
    }
    
    var body: some View {
        LivenessLaunchView(
            config: config,
            urlVerify: urlVerify,
            token: token,
            showCancelButton: false,
            maxAttempts: 3,
            soundEnable: true,
            delegate: self
        )
        .ignoresSafeArea()
    }
}  }}
```

### Consideraciones Adicionales y Buenas Prácticas
- **Manejo de Red y Conectividad:** El SDK cuenta con monitoreo automático de conectividad (`NetworkMonitor`). Si se pierde la conexión durante la verificación de token o descarga de credenciales, el flujo esperará de forma reactiva y reintentará tan pronto como la red vuelva a estar disponible.
- **Gestión de Permisos de Cámara:** Si el usuario no ha otorgado permisos de cámara, el SDK los solicitará automáticamente. Si han sido denegados previamente, presentará una alerta informando la necesidad de activarlos en la configuración de iOS.
- **Presentación en SwiftUI:** Se recomienda presentar `LivenessLaunchView` en pantalla completa con `.fullScreenCover(isPresented:)` e `.ignoresSafeArea()` para garantizar una experiencia visual inmersiva y un correcto encuadre biométrico.
- **Seguridad de Tokens:** El token Bearer de verificación debe generarse dinámicamente desde el backend de tu aplicación por sesión y no almacenarse de forma estática en el código fuente de producción.
