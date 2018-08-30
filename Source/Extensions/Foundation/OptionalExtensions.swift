import Foundation

public extension Optional {
    public var textualDescription: String {
        let mirror = Mirror(reflecting: self as Any)
        if let child = mirror.children.first {
            return String(describing: child.value)
        }
        return "<nil>"
    }
    
    public var isNil: Bool {
        return self == nil
    }
    
    public var isNotNil: Bool {
        return isNil.isFalse
    }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        if let value = self {
            return value.isEmpty
        }
        return true
    }
}

public extension Optional where Wrapped == Bool {
    public var isTrue: Bool {
        if let value = self {
            return value
        }
        return false
    }

    public var isFalse: Bool {
        if let value = self {
            return value.isFalse
        }
        return false
    }
}
