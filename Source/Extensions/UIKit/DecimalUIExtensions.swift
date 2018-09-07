import Foundation
import UIKit

public extension Decimal {
    public func formatted(locale: Locale? = nil, wholeFont: UIFont, decimalFont: UIFont, digits: Int = 2, groupingSize: Int = 3, currency: String?) -> NSAttributedString {
        let formatter = Formatter.formatterForDigits(locale: locale, digits: digits, groupingSize: groupingSize)
        let amount = formatted(locale: locale, digits: digits, groupingSize: groupingSize, currency: currency)
        let amountAttributedString = NSMutableAttributedString(string: amount)
        let rangeWholeText = NSRange(location: 0, length: amount.count)
        amountAttributedString.setAttributes([.font: wholeFont], range: rangeWholeText)
        
        guard let decimalSeparator = formatter.decimalSeparator.first,
              let commaIndex = amount.index(of: decimalSeparator),
              let spaceIndex = amount.index(of: " ") else {
            return amountAttributedString
        }
        
        let decimalSubstring = amount.suffix(from: commaIndex).prefix(upTo: spaceIndex)
        let rangeSmallText = NSRange(location: commaIndex.encodedOffset, length: decimalSubstring.count)
        
        amountAttributedString.setAttributes([.font: decimalFont], range: rangeSmallText)
        
        return amountAttributedString
    }
}
