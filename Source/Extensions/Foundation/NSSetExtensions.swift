import Foundation

public extension NSSet {
    public func filterMap<T>(_ transform: @escaping (Any) throws -> T?) -> [T] {
        if let values = try? self.allObjects.compactMap(transform) {
            return values
        }
        return []
    }
}
