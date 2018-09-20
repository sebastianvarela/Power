import Foundation

public extension Bool {
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
