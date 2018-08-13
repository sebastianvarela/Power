import Foundation

public extension Decimal {
    public func formatted(digits: Int, currency: String? = nil) -> String {
        let formatter = Formatter.formatterForDigits(digits: digits)
        
        guard let stringWithFormat = formatter.string(for: self) else {
            return "--"
        }
        
        if let currency = currency {
            return "\(stringWithFormat) \(currency.trimed)"
        }
        return stringWithFormat
    }
}
