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

Limpiar el proyecto y reconstruye

rm -rf ~/Library/Developer/Xcode/DerivedData

y luego

Product → Clean Build Folder (⇧⌘K)

Si usas CocoaPods o frameworks antiguos

pod deintegrate
pod install

revisa el podfile

platform :ios, '13.0'

Cuando tengo dos XCode en el mac
XCode_26
XCode_16

Primero activarlo en el terminal:

sudo xcode-select -s /Applications/Xcode_16.app

Comprobar la ruta activa del Developer Directory
xcode-select -p

Comprobar la versión del compilador
clang --version

Resultado del Terminal

eofc@ESPC028208 ~ % xcode-select -p
/Applications/Xcode_16.app/Contents/Developer
eofc@ESPC028208 ~ % clang --version
Apple clang version 17.0.0 (clang-1700.0.13.5)
Target: arm64-apple-darwin24.6.0
Thread model: posix
InstalledDir: /Applications/Xcode_16.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
eofc@ESPC028208 ~ % 


Sigo teniendo problemas con "libarclite"

Verifica el deployment target del proyecto y de los Pods

Ejecuta
grep -r "IPHONEOS_DEPLOYMENT_TARGET" .

Si ves algo como:
Pods/SomeLibrary/... iOS 9.0
esa librería está causando el error.

He ejutado y muestra

./Pods/Pods.xcodeproj/project.pbxproj:				IPHONEOS_DEPLOYMENT_TARGET = 8.0;

Ahí está el error

Solución definitiva
1️⃣ Abre tu Podfile y añade al principio:
platform :ios, '13.0'
(puedes poner 14.0 o 15.0 si quieres, pero 13.0 es el mínimo compatible con Xcode 16)





