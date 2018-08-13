import Foundation

public extension Formatter {
    public static func formatterForDigits(digits: Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        
        return formatter
    }
}
