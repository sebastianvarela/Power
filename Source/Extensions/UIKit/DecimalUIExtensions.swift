import Foundation
import UIKit

public extension Decimal {
    public func formatted(wholeFont: UIFont, decimalFont: UIFont, digits: Int, currency: String?) -> NSAttributedString {
        let amount = formatted(digits: digits, currency: currency)
        let amountAttributedString = NSMutableAttributedString(string: amount)
        let rangeWholeText = NSRange(location: 0, length: amount.count)
        amountAttributedString.setAttributes([.font: wholeFont], range: rangeWholeText)
        
        guard let commaIndex = amount.index(of: ","),
            let spaceIndex = amount.index(of: " ") else {
                return amountAttributedString
        }
        
        let decimalSubstring = amount.suffix(from: commaIndex).prefix(upTo: spaceIndex)
        let rangeSmallText = NSRange(location: commaIndex.encodedOffset, length: decimalSubstring.count)
        
        amountAttributedString.setAttributes([.font: decimalFont], range: rangeSmallText)
        
        return amountAttributedString
    }
}
