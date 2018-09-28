import Foundation

public extension Bool {
    public init?(onOffString: String) {
        switch onOffString.uppercased() {
        case "ON": self = true
        case "OFF": self = false
        default: return nil
        }
    }
    
    public init?(oneZeroString: String) {
        switch oneZeroString {
        case "1": self = true
        case "0": self = false
        default: return nil
        }
    }

    public var isFalse: Bool {
        return !self
    }

    public var asInt: Int {
        return self ? 1 : 0
    }

    public var onOffString: String {
        return self ? "On" : "Off"
    }
    
    public var trueFalseString: String {
        return self ? "True" : "False"
    }
    
    public var oneZeroString: String {
        return "\(asInt)"
    }
}
