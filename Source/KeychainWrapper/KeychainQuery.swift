import Foundation

internal class KeychainQuery {
    private static let account = kSecAttrAccount as String
    private static let service = kSecAttrService as String
    private static let label = kSecAttrLabel as String
    private static let data = kSecValueData as String
    private var payload = [String: Any]()
    
    private init() {
        payload[kSecClass as String] = kSecClassGenericPassword as String
    }
    
    internal typealias BuilderClosure = (KeychainQuery) -> Void
    convenience internal init(buildClosure: BuilderClosure) {
        self.init()
        buildClosure(self)
    }
    
    convenience internal init(service: String, account: String) {
        self.init()
        payload[kSecReturnData as String] = true
        payload[kSecMatchLimit as String] = kSecMatchLimitOne as String
        payload[kSecAttrAccount as String] = account
        payload[kSecAttrService as String] = service
    }
    
    // MARK: - Query properties
    
    internal var account: String? {
        get { return payload[KeychainQuery.account] as? String }
        set { payload[KeychainQuery.account] = newValue }
    }
    
    internal var service: String? {
        get { return payload[KeychainQuery.service] as? String }
        set { payload[KeychainQuery.service] = newValue }
    }
    
    internal var label: String? {
        get { return payload[KeychainQuery.label] as? String }
        set { payload[KeychainQuery.label] = newValue }
    }
    
    internal var data: Data? {
        get { return payload[KeychainQuery.data] as? Data }
        set { payload[KeychainQuery.data] = newValue }
    }
    
    internal subscript(key: String) -> Any? {
        get { return payload[key] }
        set { payload[key] = newValue }
    }
    
    // MARK: - Keychain Query methods
    internal var save: Bool {
        _ = self.delete
        let status = SecItemAdd(self.dictionary, nil)
        if #available(iOS 11.3, *), status != noErr, let errorDescription = SecCopyErrorMessageString(status, nil) {
            logWarning("Error on saving data on keychain: \(String(errorDescription))")
        }
        return status == noErr
    }
    
    internal var load: Data? {
        let dataTypeRef = UnsafeMutablePointer<AnyObject?>.allocate(capacity: 1)
        let status = SecItemCopyMatching(self.dictionary, dataTypeRef)
        if #available(iOS 11.3, *), status != noErr, let errorDescription = SecCopyErrorMessageString(status, nil) {
            logWarning("Error on loading data on keychain: \(String(errorDescription))")
        }
        guard status == noErr, let data = dataTypeRef.pointee as? Data else {
            return nil
        }
        
        return data
    }
    
    internal var delete: Bool {
        let status = SecItemDelete(self.dictionary)
        if #available(iOS 11.3, *), status != noErr, let errorDescription = SecCopyErrorMessageString(status, nil) {
            logWarning("Error on deleting data on keychain: \(String(errorDescription))")
        }
        return status == noErr
    }
    
    internal class var clear: Bool {
        let dictionary = [kSecClass as String: kSecClassGenericPassword as Any]
        let status = SecItemDelete(dictionary as CFDictionary)
        if #available(iOS 11.3, *), status != noErr, let errorDescription = SecCopyErrorMessageString(status, nil) {
            logWarning("Error on clearing all data on keychain: \(String(errorDescription))")
        }
        return status == noErr
    }
    
    internal var dictionary: CFDictionary {
        return payload as CFDictionary
    }
}
