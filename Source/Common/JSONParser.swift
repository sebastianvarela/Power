import Foundation

public class JSONParser {
    public func unparse<T: Codable>(_ model: T) -> String? {
        guard let modelData = try? JSONEncoder().encode(model) else {
            return nil
        }
        return modelData.stringUTF8
    }
    
    public func parse<T: Codable>(_ type: T.Type, from json: String) -> T? {
        return try? JSONDecoder().decode(T.self, from: json.dataUTF8)
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
