import Foundation

public extension JSONEncoder {
    public func encodeToString<T>(_ value: T) throws -> String where T: Encodable {
        if let data = try encode(value).stringUTF8 {
            return data
        }
        throw NSError(domain: "DATA_INVALID", code: 0, userInfo: [NSLocalizedDescriptionKey: "The generated data could not be converted to string"])
    }
}

public extension JSONDecoder {
    public func decode<T>(_ type: T.Type, from string: String) throws -> T where T: Decodable {
        return try decode(T.self, from: string.dataUTF8)
    }
}

public class JSONParser {
    public init() {
        
    }
    
    public func unparse<T: Codable>(_ model: T) -> String? {
        guard let modelData = try? JSONEncoder().encodeToString(model) else {
            return nil
        }
        return modelData
    }
    
    public func parse<T: Codable>(_ type: T.Type, from json: String) -> T? {
        return try? JSONDecoder().decode(T.self, from: json)
    }
    
    public func parseAndUnparse<M: Codable & Equatable>(_ type: M.Type, from json: String, onSuccess: (M) -> Void) -> Bool {
        guard let model = parse(M.self, from: json) else {
            return false
        }
        if let modelJson = unparse(model), let decoded = parse(M.self, from: modelJson) {
            let success = model == decoded
            if success { onSuccess(model) }
            return success
        }
        return false
    }
    
    public func unparseAndParse<M: Codable & Equatable>(_ model: M) -> Bool {
        guard let modelJson = unparse(model), let decoded = parse(M.self, from: modelJson) else {
            return false
        }
        return model == decoded
    }
}
