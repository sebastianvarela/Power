import Foundation

public extension Data {
    public var stringUTF8: String? {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) as String?
    }
}
