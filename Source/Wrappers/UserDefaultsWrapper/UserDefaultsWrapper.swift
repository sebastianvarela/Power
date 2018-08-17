import Foundation

public protocol UserDefaultsWrapper {
    func set(value: Bool, forKey: ConstantKey, background: Bool)
    func set(value: String?, forKey: ConstantKey, background: Bool)
    func delete(key: ConstantKey, background: Bool)
    func bool(forKey: ConstantKey) -> Bool
    func string(forKey: ConstantKey) -> String?
}

public extension UserDefaultsWrapper {
    func set(value: Bool, forKey: ConstantKey) {
        set(value: value, forKey: forKey, background: false)
    }
    
    func set(value: String?, forKey: ConstantKey) {
        set(value: value, forKey: forKey, background: false)
    }
    
    func delete(key: ConstantKey) {
        delete(key: key, background: false)
    }
}

public class DefaultUserDefaultsWrapper: UserDefaultsWrapper {
    private let userDefaults = UserDefaults.standard
    private lazy var queue: DispatchQueue = {
        return DispatchQueue(label: "net.s3ba.Power.UserDefaults.Queue", qos: .background)
    }()
    
    public init() {
        
    }
    
    public func set(value: Bool, forKey key: ConstantKey, background: Bool) {
        func batch() {
            self.userDefaults.set(value, forKey: key.rawValue)
            self.userDefaults.synchronize()
        }
        if background {
            queue.sync(execute: batch)
        } else {
            batch()
        }
    }
    
    public func set(value: String?, forKey key: ConstantKey, background: Bool) {
        func batch() {
            self.userDefaults.set(value, forKey: key.rawValue)
            self.userDefaults.synchronize()
        }
        if background {
            queue.sync(execute: batch)
        } else {
            batch()
        }
    }
    
    public func delete(key: ConstantKey, background: Bool) {
        func batch() {
            self.userDefaults.set(nil, forKey: key.rawValue)
            self.userDefaults.synchronize()
        }
        if background {
            queue.sync(execute: batch)
        } else {
            batch()
        }
    }
    
    public func bool(forKey key: ConstantKey) -> Bool {
        return userDefaults.bool(forKey: key.rawValue)
    }
    
    public func string(forKey key: ConstantKey) -> String? {
        return userDefaults.string(forKey: key.rawValue)
    }
}
