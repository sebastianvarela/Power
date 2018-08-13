import Foundation

public struct ValueContainer: Equatable {
    public let id: Int
    public let value: String
}

public func == (lhs: ValueContainer, rhs: ValueContainer) -> Bool {
    return lhs.id == rhs.id
}
