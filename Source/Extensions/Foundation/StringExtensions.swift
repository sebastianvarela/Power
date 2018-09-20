import Foundation

public extension String {
    public func decodeJsonString<T>() -> T? where T: Decodable {
        guard let data = self.data(using: .utf8),
              let object = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return object
    }
    
    public var decimalSpanishValue: Decimal? {
        return Decimal(string: self, locale: Locale.spanish)
    }
    
    public var base64Encoded: String {
        guard let plainData = dataUTF8 else {
            fatalError("could not get data from string")
        }
        let base64String = plainData.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithCarriageReturn)
        return base64String
    }
    
    public var base64Decoded: String? {
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        let decodedString = NSString(data: decodedData as Data, encoding: String.Encoding.utf8.rawValue)
        return decodedString as String?
    }
    
    public var dataUTF8: Data? {
        return data(using: String.Encoding.utf8)
    }
    
    public var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    public var trimed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func isValidUrl() -> Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public func suffix(from start: String) -> String? {
        if let foundRange = range(of: start) {
            return String(suffix(from: foundRange.upperBound))
        }
        
        return nil
    }
    
    public func prefix(upTo string: String) -> String {
        if let foundRange = range(of: string) {
            return String(prefix(upTo: foundRange.lowerBound))
        }
        
        return self
    }
    
    public var replacedPercentEncodingFromLatinToUTF8: String {
        let table = ["%E1": "%C3%A1",
                     "%E9": "%C3%A9",
                     "%ED": "%C3%AD",
                     "%F3": "%C3%B3",
                     "%FA": "%C3%BA",
                     "%FC": "%C3%BC",
                     "%C1": "%C3%81",
                     "%C9": "%C3%89",
                     "%CD": "%C3%8D",
                     "%D3": "%C3%93",
                     "%DA": "%C3%9A",
                     "%DC": "%C3%9C"]
        
        var newValue = self
        for pair in table {
            newValue = newValue.replacingOccurrences(of: pair.key, with: pair.value)
        }
        return newValue
    }
    
    public subscript (bounds: CountableClosedRange<Int>) -> String {
        if bounds.lowerBound > count - 1 {
            return ""
        }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = bounds.upperBound < count ?
            index(startIndex, offsetBy: bounds.upperBound) :
            index(startIndex, offsetBy: count - 1)
        return String(self[start...end])
    }
    
    public subscript (bounds: CountableRange<Int>) -> String {
        if bounds.lowerBound > count {
            return ""
        }
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = bounds.upperBound < count ?
            index(startIndex, offsetBy: bounds.upperBound) :
            index(startIndex, offsetBy: count)
        return String(self[start..<end])
    }
    
    public var withoutSpaces: String {
        return replacingOccurrences(of: " ", with: "")
    }
}
