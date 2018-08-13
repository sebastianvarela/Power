import Foundation

public extension Int {
    public func times(_ action: () -> Void) {
        if self > 0 {
            for _ in 0..<self {
                action()
            }
        }
    }

    public func times(_ action: (Int) -> Void) {
        if self > 0 {
            for i in 0..<self {
                action(i)
            }
        }
    }
}
