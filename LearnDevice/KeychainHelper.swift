//
//  KeychainHelper.swift
//  LearnDevice
//
//  Created by Fulgencio Comendeiro, Eduardo on 15/10/25.
//

import Foundation
/*
 El framework Security es parte de la Security Services API del Sistema Operartivo
 Funcionalidades de seguridad de bajo nivel:
 - Acceso a Keychain
 - Certificados digitales, claves públicas y privadas
 - Cifrado y descifrado de datos
 - Firmas digitales y validación de certificados
 */
import Security

struct KeychainHelper {
    
    static func save(key: String, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        // Borrar cualquier valor previo
        let queryDelete: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(queryDelete as CFDictionary)
        
        // Guardar el nuevo valor
        let queryAdd: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(queryAdd as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

