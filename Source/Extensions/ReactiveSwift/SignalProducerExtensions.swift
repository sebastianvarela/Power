import ReactiveSwift
import Result

public extension SignalProducer {
    public func onStarting(action: @escaping (() -> Void)) -> SignalProducer<Value, Error> {
        return on(starting: action)
    }

    public func onStarted(action: @escaping (() -> Void)) -> SignalProducer<Value, Error> {
        return on(started: action)
    }
    
    public func onFailed(action: @escaping ((Error) -> Void)) -> SignalProducer<Value, Error> {
        return on(failed: action)
    }
    
    public func onValue(action: @escaping ((Value) -> Void)) -> SignalProducer<Value, Error> {
        return on(value: action)
    }
    
    public func onCompleted(action: @escaping (() -> Void)) -> SignalProducer<Value, Error> {
        return on(completed: action)
    }
    
    public func onTerminated(action: @escaping (() -> Void)) -> SignalProducer<Value, Error> {
        return on(terminated: action)
    }
    
    public func mapToVoid() -> SignalProducer<Void, Error> {
        return map { _ in return () }
    }
    
    public func demoteError() -> SignalProducer<Value, NoError> {
        return SignalProducer<Value, NoError> { observer, disposable in
            disposable += self.start { event in
                switch event {
                case .value(let value):
                    observer.send(value: value)
                case .completed:
                    observer.sendCompleted()
                default: break
                }
            }
        }
    }

    @discardableResult
    public func start<OtherValue>(_ observer: Signal<OtherValue, Error>.Observer, replaceWithValue value: OtherValue) -> Disposable {
        return start(observer) { _ in value }
    }
    
    @discardableResult
    public func start<OtherValue>(_ observer: Signal<OtherValue, Error>.Observer, mapValue: @escaping (Value) -> OtherValue) -> Disposable {
        return map(mapValue).start(observer)
    }
    
    @discardableResult
    public func startWithCompletedOnUIScheduler(_ action: @escaping () -> Void) -> Disposable {
        return start(on: UIScheduler())
            .startWithCompleted(action)
    }
}

public extension SignalProducer where Error == NoError {
    @discardableResult
    public func startWithValuesOnUIScheduler(_ action: @escaping (Value) -> Void) -> Disposable {
        return start(on: UIScheduler())
            .startWithValues(action)
    }
}
