//
//  ViewController.swift
//  LearnDevice
//
//  Created by Fulgencio Comendeiro, Eduardo on 15/10/25.
//

import UIKit
import Security

class ViewController: UIViewController {
    
    private let infoLabel = UILabel()
    private let saveButton = PrimaryButton(title: "💾 Guardar nombre en Keychain", backgroundColor: .systemBlue)
    private let loadButton = PrimaryButton(title: "📂 Recuperar desde Keychain", backgroundColor: .systemGreen)
    private let keychainKey = "com.fulgencio.learndevice"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        showDeviceInfo()
    }

    private func setupUI() {
        // Label de información
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .left
        infoLabel.font = UIFont.systemFont(ofSize: 15)
        infoLabel.frame = CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: 300)
        
        view.addSubview(infoLabel)
        view.addSubview(saveButton)
        view.addSubview(loadButton)
        
        // Auto Layout
        NSLayoutConstraint.activate([
           infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
           infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           
           saveButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 40),
           saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           saveButton.heightAnchor.constraint(equalToConstant: 50),
           
           loadButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
           loadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
           loadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           loadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func showDeviceInfo() {
            let device = UIDevice.current
            device.isBatteryMonitoringEnabled = true
            
            let info = """
            📱 Nombre: \(device.name)
            💾 Modelo: \(device.model)
            🧩 Sistema: \(device.systemName) \(device.systemVersion)
            🏭 Vendor ID: \(device.identifierForVendor?.uuidString ?? "N/A")
            🔋 Nivel batería: \(Int(device.batteryLevel * 100))%
            """
            
            infoLabel.text = info
    }
    
    // MARK: - Botones
    
    @objc private func saveToKeychain() {
        let deviceName = UIDevice.current.name
        let success = KeychainHelper.save(key: keychainKey, value: deviceName)
        showAlert(title: success ? "✅ Guardado" : "⚠️ Error", message: success ? "Nombre guardado en Keychain" : "No se pudo guardar el nombre.")
    }
    
    @objc private func loadFromKeychain() {
        if let storedName = KeychainHelper.load(key: keychainKey) {
            showAlert(title: "📂 Recuperado", message: "Nombre guardado: \(storedName)")
        } else {
            showAlert(title: "❌ Sin datos", message: "No hay información guardada en el Keychain.")
        }
    }
    
    // MARK: - Helpers
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    

}

