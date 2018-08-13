import ReactiveSwift

public extension Action {
    @discardableResult
    public func onCompletedAction(_ action: @escaping (()) -> Void) -> Disposable? {
        return completed
            .observe(on: UIScheduler())
            .observeValues(action)
    }
}
