import ReactiveSwift
import Result

public extension Signal {
    public func mapToVoid() -> Signal<Void, Error> {
        return map { _ in return () }
    }
    
    @discardableResult
    public func onValueReceived(_ action: @escaping (()) -> Void) -> Disposable? {
        return mapToVoid().observeResult { result in
            if case .success = result {
                action(())
            }
        }
    }
}

public extension Signal where Error == NoError {
    @discardableResult
    public func observeValuesOnUIScheduler(_ action: @escaping (Value) -> Void) -> Disposable? {
        return observe(on: UIScheduler())
            .observeValues(action)
    }
}

public extension Signal.Observer {
    @discardableResult
    public static func <~ <Source: BindingSource> (observer: Signal.Observer, source: Source) -> Disposable?
        where Source.Value == Value {
            return source.producer
                .startWithValues(observer.send)
    }
}
