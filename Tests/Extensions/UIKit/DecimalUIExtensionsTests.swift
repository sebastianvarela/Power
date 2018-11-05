@testable import Power
import UIKit
import XCTest

public class DecimalUIExtensionsTests: XCTestCase {
    public func testFormattedAmountWithDifferentFonts() {
        let amount: Decimal = 124.447
        
        let attributedString = amount.formatted(wholeFont: .systemFont(ofSize: 12), decimalFont: .systemFont(ofSize: 10), digits: 3, currency: "€")
        let string = amount.formatted(digits: 3, currency: "€")
        
        XCTAssertEqual(attributedString.string, string)
    }
    
    public func testFormattedAmountWithDifferentFontsAndSmallAmount() {
        let amount: Decimal = 0.57
        
        let attributedString = amount.formatted(wholeFont: .systemFont(ofSize: 12), decimalFont: .systemFont(ofSize: 10), digits: 3, currency: "€")
        let string = amount.formatted(digits: 3, currency: "€")
        
        XCTAssertEqual(attributedString.string, string)
    }
}
