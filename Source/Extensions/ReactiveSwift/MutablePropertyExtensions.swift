import Foundation
import ReactiveSwift

public extension MutableProperty {
    func silentSwap(_ newValue: Value) {
        swap(newValue)
    }
}
