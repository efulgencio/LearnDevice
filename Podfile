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
