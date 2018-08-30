import ReactiveSwift
import Result

public extension Signal {
    public func mapToVoid() -> Signal<Void, Error> {
        return map { _ in return () }
    }
    
    public func demoteError() -> Signal<Value, NoError> {
        return Signal<Value, NoError> { observer, _ in
            self.observeResult { result in
                if case .success(let value) = result {
                    observer.send(value: value)
                }
            }
        }
    }
    
    @discardableResult
    public func onValueReceived(_ action: @escaping (()) -> Void) -> Disposable? {
        return mapToVoid().observeResult { result in
            if case .success = result {
                action(())
            }
        }
    }
    
    @discardableResult
    public func onErrorReceived(_ action: @escaping (()) -> Void) -> Disposable? {
        return mapToVoid().observeResult { result in
            if case .failure = result {
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
    public static func <~ <Source: SignalProducerConvertible> (observer: Signal.Observer, source: Source) -> Disposable?
        where Source.Value == Value, Source.Error == Error {
            return source.producer
                .startWithResult { action in
                    switch action {
                    case .failure(let error):
                        observer.send(error: error)
                    case .success(let value):
                        observer.send(value: value)
                    }
                }
    }
}
