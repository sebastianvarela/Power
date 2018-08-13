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
    
    static func fromString(_ string: String) -> URL {
        guard let url = URL(string: string) else {
            fatalError("Cannot build url from string: \"\(string)\"")
        }
        return url
    }
}
