import Foundation

public extension URL {
    public func starts(with url: URL) -> Bool {
        return self.absoluteString.starts(with: url.absoluteString)
    }
    
    public func ends(with path: String) -> Bool {
        return self.absoluteString.hasSuffix(path)
    }
    
    public var absoluteStringByTrimmingQuery: URL {
        if var components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            components.query = nil
            if let url = components.url {
                return url
            }
        }
        
        fatalError("Invalid url")
    }
    
    public var anchor: String? {
        guard let urlAnchor = absoluteString.split(separator: "#").last, urlAnchor != absoluteString else {
            return nil
        }
        return String(urlAnchor)
    }
    
    public func queryStringValue(key: String) -> String? {
        return URLComponents(url: URL.fromString(absoluteString.replacedPercentEncodingFromLatinToUTF8), resolvingAgainstBaseURL: false)?
            .queryItems?
            .first { $0.name == key }?
            .value
    }
    
    public static func processQuery(query: String) -> [URLQueryItem] {
        return query.split(separator: "&").map { slice in
            let parts = slice.split(separator: "=")
            if let first = parts.first, let last = parts.last, first != last, parts.count == 2 {
                return URLQueryItem(name: String(first), value: String(last))
            }
            return URLQueryItem(name: String(slice), value: nil)
        }
    }
    
    static func fromString(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Cannot build url from string: \"\(string)\"")
        }
        return url
    }
}
