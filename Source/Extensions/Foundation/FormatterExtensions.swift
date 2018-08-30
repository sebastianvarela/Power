import Foundation

public extension Formatter {
    public static func formatterForDigits(locale: Locale? = nil, digits: Int, groupingSize: Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale ?? PowerBag.shared.locale.value
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        formatter.groupingSize = groupingSize
        formatter.usesGroupingSeparator = true
        
        return formatter
    }
}
