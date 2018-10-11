import Foundation

public extension Locale {
    static let spanish = Locale(identifier: "es_ES")
    static let english = Locale(identifier: "en_US")
    
    public var localizedName: String {
        guard let name = localizedString(forLanguageCode: identifier) else {
            return "-"
        }
        return name.capitalized
    }
}

public extension TimeZone {
    static let EuropeMadrid = TimeZone(identifier: "Europe/Madrid")
}
