import Foundation

public protocol UniqueValueProtocol {
    associatedtype Value
    
    var id: Int { get }
    var value: Value { get }
}

public struct UniqueValue<Value>: UniqueValueProtocol, Equatable {
    public let id: Int
    public let value: Value
    
    public init(id: Int, value: Value) {
        self.id = id
        self.value = value
    }
    
    public static func == (lhs: UniqueValue<Value>, rhs: UniqueValue<Value>) -> Bool {
        return lhs.id == rhs.id
    }
}

public extension Array where Element: UniqueValueProtocol {
    public func find(byId id: Int) -> Element? {
        if let element = filter({ $0.id == id }).first {
            return element
        }
        return nil
    }
}
