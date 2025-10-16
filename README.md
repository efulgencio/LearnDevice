# ☕️ CocoaPods en iOS – Guía y Ejemplo Práctico

Este proyecto muestra cómo usar **CocoaPods** en una app iOS desarrollada con **UIKit**.  
CocoaPods es el gestor de dependencias más popular en el ecosistema iOS y permite añadir librerías externas a tu proyecto de forma sencilla y segura.

---

## 🧩 ¿Qué es CocoaPods?

[CocoaPods](https://cocoapods.org/) es una herramienta que automatiza la instalación y actualización de librerías de terceros en proyectos iOS y macOS.

En lugar de descargar manualmente el código fuente, solo necesitas definir tus dependencias en un archivo llamado **`Podfile`**.  
CocoaPods descargará, integrará y gestionará automáticamente esas librerías dentro de tu proyecto Xcode.

---

## ⚙️ Requisitos previos

- macOS (Sequoia o posterior)
- [Xcode](https://developer.apple.com/xcode/)
- [Homebrew](https://brew.sh/) instalado

---

## 🚀 Instalación de CocoaPods

1. **Instalar CocoaPods mediante Homebrew**

   ```bash
   brew install cocoapods

2. **He tenido problemas con librerías versión 8 en el POD**

**Limpiar el proyecto y reconstruye**

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```

y luego

```bash
Product → Clean Build Folder (⇧⌘K)
```

**Si usas CocoaPods o frameworks antiguos**

```bash
pod deintegrate
pod install
```

**Revisa el podfile**

platform :ios, '13.0'

Cuando tengo dos XCode en el mac

XCode_26
XCode_16

**Primero activarlo en el terminal:**

```bash
sudo xcode-select -s /Applications/Xcode_16.app
```

**Comprobar la ruta activa del Developer Directory**

```bash
xcode-select -p
```

**Comprobar la versión del compilador**

```bash
clang --version
```

**Resultado del Terminal**

```bash
eofc@ESPC028208 ~ % xcode-select -p
/Applications/Xcode_16.app/Contents/Developer
eofc@ESPC028208 ~ % clang --version
Apple clang version 17.0.0 (clang-1700.0.13.5)
Target: arm64-apple-darwin24.6.0
Thread model: posix
InstalledDir: /Applications/Xcode_16.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
eofc@ESPC028208 ~ %
```

**Sigo teniendo problemas con "libarclite"**

Verifica el deployment target del proyecto y de los Pods

Ejecuta

```bash
grep -r "IPHONEOS_DEPLOYMENT_TARGET" .
```


Si ves algo como:

Pods/SomeLibrary/... iOS 9.0 (Esa librería está causando el error.)

He ejutado y muestra

./Pods/Pods.xcodeproj/project.pbxproj:				IPHONEOS_DEPLOYMENT_TARGET = 8.0;

Ahí está el error


**Solución definitiva**

1️⃣ Abre tu Podfile y añade al principio:

platform :ios, '13.0'

(puedes poner 14.0 o 15.0 si quieres, pero 13.0 es el mínimo compatible con Xcode 16)


Perfecto 👌 — gracias por mostrar tu Podfile.

Ya tienes:
platform :ios, '15.0'

✅ Eso está bien (15.0 es suficientemente alto).

Pero el problema persiste porque cuando instalaste los Pods por primera vez, ese valor no existía o era más bajo,
y entonces CocoaPods dejó los valores antiguos (iOS 8.0) guardados dentro del archivo:

Pods/Pods.xcodeproj/project.pbxproj

Así que aunque ahora tu Podfile está bien, el proyecto de Pods sigue arrastrando la configuración vieja.

🔧 Solución exacta

Ejecuta en la raíz del proyecto estos comandos (copiar y pegar):

```bash
rm -rf Pods
rm Podfile.lock
pod deintegrate
pod install
```

Eso fuerza a CocoaPods a recrear el proyecto de Pods desde cero aplicando el platform :ios, '15.0' correctamente a todos los targets.


🧹 Después, limpia el build:

```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```


y en Xcode:

Product → Clean Build Folder (⇧⌘K)


Ejecuta de nuevo:

```bash
grep -r "IPHONEOS_DEPLOYMENT_TARGET" ./Pods
```


Ahora deberías ver solo valores iguales o superiores a 15.0.


Compila de nuevo

El error:

SDK does not contain 'libarclite' ...

debería desaparecer completamente.

**He aplicado la solución propuesta y sigue habiendo una librería 8.0**

🧱 2️⃣ Reinstala los Pods desde cero
Ejecuta:

```bash
pod install --repo-update
```

El flag --repo-update fuerza a CocoaPods a actualizar su lista de Pods y aplicar correctamente el platform :ios, '15.0'.

🧠 4️⃣ Verifica si aún existe “8.0”

Ejecuta:

```bash
grep -r "IPHONEOS_DEPLOYMENT_TARGET" ./Pods
```

Si ya no ves líneas con 8.0, ¡perfecto! 🎉

Pero si todavía queda alguna con 8.0, fuerza el reemplazo manual con este comando 👇


🛠 5️⃣ Reemplazo automático (seguro)

Copia y pega este comando en tu Terminal (en la raíz del proyecto):

```bash
find ./Pods -type f -name "project.pbxproj" -exec sed -i '' 's/IPHONEOS_DEPLOYMENT_TARGET = 8.0;/IPHONEOS_DEPLOYMENT_TARGET = 15.0;/g' {} +
```

Este comando:

Busca en todos los Pods/project.pbxproj

Reemplaza todas las ocurrencias de IPHONEOS_DEPLOYMENT_TARGET = 8.0;

Las cambia a IPHONEOS_DEPLOYMENT_TARGET = 15.0;

**Ahora que me compila bién el problema viene que no ejecuta, da error permisos**

IMPORTANTE
**🧩 1. Cambia tu Podfile para usar frameworks estáticos**

Edita el Podfile así:
```
platform :ios, '15.0'
```

**# Usa frameworks estáticos (evita la copia de .framework dinámicos)**

```
use_frameworks! :linkage => :static

target 'LearnDevice' do
  pod 'Toast-Swift', '~> 5.0.1'
end
```

**Guarda y luego en terminal**

```
pod deintegrate
pod install
```


⚙️ Esto hace que Toast-Swift se integre como librería estática, no como .framework dinámico.
Así no necesita copiar ni firmar nada dentro de _CodeSignature, y el sandbox deja de intervenir.


**🧹 2. Limpia todo el entorno de compilación**

Ejecuta los siguientes comandos en orden:

```
rm -rf ~/Library/Developer/Xcode/DerivedData
xcrun simctl erase all
Y luego en la carpeta del proyecto:
rm -rf Pods
rm Podfile.lock
pod install
```

**Contienido Podfile de LearnDevice**

```
# Define la plataforma mínima compatible con tu app
platform :ios, '15.0'

# Indica que usaremos frameworks, pero enlazados de forma estática
# Esto evita que Xcode intente copiar y firmar frameworks dinámicos (.framework),
# lo cual genera errores como "Sandbox: rsync deny file-write-create".
use_frameworks! :linkage => :static

# (Opcional) Usa librerías Swift modernas si CocoaPods lo permite
# use_modular_headers!

# Bloque principal del target de la app
target 'LearnDevice' do
  # Aquí defines las dependencias (pods) que usará la app

  # 📦 Toast-Swift → librería ligera para mostrar notificaciones tipo “toast”
  # Compatible con UIKit y SwiftUI
  pod 'Toast-Swift', '~> 5.0.1'

  # Puedes añadir aquí otros pods, por ejemplo:
  # pod 'Alamofire', '~> 5.9'
  # pod 'SnapKit', '~> 5.6'

  # Si tienes tests unitarios, puedes añadir un bloque adicional:
  # target 'LearnDeviceTests' do
  #   inherit! :search_paths
  #   pod 'Quick'
  #   pod 'Nimble'
  # end
end

# 🔧 Recomendado: evita advertencias innecesarias en Xcode
inhibit_all_warnings!

# 🔁 Opcional: acelera las instalaciones repetidas
# (mantiene una caché local de pods)
install! 'cocoapods', :deterministic_uuids => false
```












