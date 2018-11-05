import Foundation

public extension Decimal {
    public func formatted(locale: Locale? = nil, digits: Int = 2, groupingSize: Int = 3, currency: String? = nil) -> String {
        let formatter = Formatter.formatterForDigits(locale: locale, digits: digits, groupingSize: groupingSize)
        
        guard var stringWithFormat = formatter.string(for: self) else {
            return "--"
        }
        
        if self < 1 && self > 0 {
            stringWithFormat = "0\(stringWithFormat)"
        }
        
        if
            self < 0 && self > -1,
            let decimalSeparator = formatter.decimalSeparator.first,
            let negativeIndex = stringWithFormat.firstIndex(of: decimalSeparator) {
                stringWithFormat.insert("0", at: negativeIndex)
        }
        
        if let currency = currency {
            return "\(stringWithFormat) \(currency.trimed)"
        }
        return stringWithFormat
    }
}
