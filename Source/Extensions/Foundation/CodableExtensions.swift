import Foundation

public extension Encodable {
    public var jsonString: String? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return data.stringUTF8
    }
}
