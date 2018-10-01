import Foundation

public extension Bool {
    public init?(onOffString: String) {
        switch onOffString.uppercased() {
        case "ON": self = true
        case "OFF": self = false
        default: return nil
        }
    }
    
    public init?(yesNoString: String) {
        switch yesNoString.uppercased() {
        case "YES": self = true
        case "NO": self = false
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
    
    public init?(enabledDisabledString: String) {
        switch enabledDisabledString.uppercased() {
        case "ENABLED": self = true
        case "DISABLED": self = false
        default: return nil
        }
    }
    
    public init?(enableDisableString: String) {
        switch enableDisableString.uppercased() {
        case "ENABLE": self = true
        case "DISABLE": self = false
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
    
    public var yesNoString: String {
        return self ? "Yes" : "No"
    }
    
    public var trueFalseString: String {
        return self ? "True" : "False"
    }
    
    public var enabledDisabledString: String {
        return self ? "Enabled" : "Disabled"
    }
    
    public var enableDisableString: String {
        return self ? "Enable" : "Disable"
    }
    
    public var oneZeroString: String {
        return "\(asInt)"
    }
}
