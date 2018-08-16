import Foundation

public struct ConstantKey: RawRepresentable, Equatable, Hashable {
    public let rawValue: String
    public let hashValue: Int
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
        self.hashValue = rawValue.hashValue
    }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
        self.hashValue = rawValue.hashValue
    }
}

public func + (lhs: ConstantKey, rhs: ConstantKey) -> ConstantKey {
    return ConstantKey("\(lhs.rawValue).\(rhs.rawValue)")
}
