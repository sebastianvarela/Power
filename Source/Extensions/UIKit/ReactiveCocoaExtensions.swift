import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public extension UISlider {
    public var valueChangedSignal: Signal<Float, NoError> {
        return self
            .reactive
            .values
            .observe(on: UIScheduler())
    }
    
    @discardableResult
    public func onValueChangedAction(_ action: @escaping (Float) -> Void) -> Disposable? {
        return valueChangedSignal.observeValues(action)
    }
}

public extension UIButton {
    public var touchSignal: Signal<Void, NoError> {
        return reactive
            .controlEvents(.touchUpInside)
            .observe(on: UIScheduler())
            .mapToVoid()
    }
    
    @discardableResult
    public func onTouchAction(_ action: @escaping (()) -> Void) -> Disposable? {
        return touchSignal.observeValues(action)
    }
}

public extension UITextField {
    public var emptyValueSignal: Signal<Bool, NoError> {
        return reactive
            .continuousTextValues
            .observe(on: UIScheduler())
            .skipNil()
            .map { $0.trimed.isEmpty }
    }
}
