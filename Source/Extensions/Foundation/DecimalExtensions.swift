import Foundation

public extension Decimal {
    public func formatted(locale: Locale? = nil, digits: Int = 2, groupingSize: Int = 3, currency: String? = nil) -> String {
        let formatter = Formatter.formatterForDigits(locale: locale, digits: digits, groupingSize: groupingSize)
        
        guard let stringWithFormat = formatter.string(for: self) else {
            return "--"
        }
        
        if let currency = currency {
            return "\(stringWithFormat) \(currency.trimed)"
        }
        return stringWithFormat
    }
}
