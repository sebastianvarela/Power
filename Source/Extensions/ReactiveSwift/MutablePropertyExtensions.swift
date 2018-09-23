import Foundation
import ReactiveSwift

public extension MutableProperty {
    func silentSwap(_ newValue: Value) {
        swap(newValue)
    }
}

public extension MutableProperty where Value: OptionalProtocol {
    public var isNil: Property<Bool> {
        return map { $0.optional == nil }
    }
    
    public var isNotNil: Property<Bool> {
        return map { $0.optional != nil }
    }
}
