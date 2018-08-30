@testable import Power
import XCTest

public class DecimalExtensionsTests: XCTestCase {
    public func testFormattedAmountWithOneDigitsToTwoInEnglishFormat() {
        let amount: Decimal = 1_124.4
        
        XCTAssertEqual(amount.formatted(locale: .english, digits: 2, groupingSize: 3, currency: "U$S"), "1,124.40 U$S")
    }
    
    public func testFormattedAmountWithOneDigitsToTwoInSpanishFormat() {
        let amount: Decimal = 1_124.4
        
        XCTAssertEqual(amount.formatted(locale: .spanish, digits: 2, groupingSize: 3, currency: "€"), "1.124,40 €")
    }

    public func testFormattedAmountWithThreeDigitsToTwoInSpanishFormat() {
        let amount: Decimal = 124.447
        
        XCTAssertEqual(amount.formatted(locale: .spanish, digits: 2, groupingSize: 3, currency: "€"), "124,45 €")
    }

    public func testFormattedAmountWithNoCurrencyInSpanishFormat() {
        let amount: Decimal = 124.4
        
        XCTAssertEqual(amount.formatted(locale: .spanish, digits: 1, groupingSize: 3), "124,4")
    }

    public func testFormattedAmountWithInvalidCurrencyInSpanishFormat() {
        let amount: Decimal = 124.4
        
        XCTAssertEqual(amount.formatted(locale: .spanish, digits: 1, groupingSize: 3, currency: " € "), "124,4 €")
    }
}
