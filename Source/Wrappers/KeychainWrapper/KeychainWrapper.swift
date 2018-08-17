import Foundation
import Security

public protocol KeychainWrapper {
    func read(stringFromService service: ConstantKey, andAccount account: ConstantKey) -> String?
    func read(dataFromService service: ConstantKey, andAccount account: ConstantKey) -> Data?
    @discardableResult
    func delete(service: ConstantKey, account: ConstantKey) -> Bool
    @discardableResult
    func save(_ data: Data, inService service: ConstantKey, andAccount account: ConstantKey) -> Bool
    @discardableResult
    func save(_ string: String, inService service: ConstantKey, andAccount account: ConstantKey) -> Bool
    @discardableResult
    func clear() -> Bool
}

public class DefaultKeychainWrapper: KeychainWrapper {
    public init() {
        
    }
    
    public func read(stringFromService service: ConstantKey, andAccount account: ConstantKey) -> String? {
        return KeychainQuery(service: service.rawValue, account: account.rawValue).load?.stringUTF8
    }
    
    public func read(dataFromService service: ConstantKey, andAccount account: ConstantKey) -> Data? {
        return KeychainQuery(service: service.rawValue, account: account.rawValue).load
    }
    
    @discardableResult
    public func delete(service: ConstantKey, account: ConstantKey) -> Bool {
        let query = KeychainQuery { builder in
            builder.account = account.rawValue
            builder.service = service.rawValue
        }
        
        return query.delete
    }
    
    @discardableResult
    public func save(_ data: Data, inService service: ConstantKey, andAccount account: ConstantKey) -> Bool {
        let query = KeychainQuery { builder in
            builder.account = account.rawValue
            builder.service = service.rawValue
            builder.data = data
        }
        
        return query.save
    }
    
    @discardableResult
    public func save(_ string: String, inService service: ConstantKey, andAccount account: ConstantKey) -> Bool {
        let query = KeychainQuery { builder in
            builder.account = account.rawValue
            builder.service = service.rawValue
            builder.data = string.dataUTF8
        }
        
        return query.save
    }
    
    @discardableResult
    public func clear() -> Bool {
        return KeychainQuery.clear
    }
}
