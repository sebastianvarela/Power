import Foundation

public extension Decimal {
    public func formatted(locale: Locale? = nil, digits: Int = 2, groupingSize: Int = 3, currency: String? = nil) -> String {
        let formatter = Formatter.formatterForDigits(locale: locale, digits: digits, groupingSize: groupingSize)
        
        guard var stringWithFormat = formatter.string(for: self) else {
            return "--"
        }
        
        if self < 1 {
            stringWithFormat = "0\(stringWithFormat)"
        }
        
        if let currency = currency {
            return "\(stringWithFormat) \(currency.trimed)"
        }
        return stringWithFormat
    }
}
