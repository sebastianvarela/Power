@testable import Power
import XCTest

public class DecimalExtensionsTests: XCTestCase {
    public func testFormattedAmountWithOneDigitsToTwo() {
        let amount: Decimal = 124.4
        
        XCTAssertEqual(amount.formatted(digits: 2, currency: "€"), "124,40 €")
    }

    public func testFormattedAmountWithThreeDigitsToTwo() {
        let amount: Decimal = 124.447
        
        XCTAssertEqual(amount.formatted(digits: 2, currency: "€"), "124,45 €")
    }

    public func testFormattedAmountWithNoCurrency() {
        let amount: Decimal = 124.4
        
        XCTAssertEqual(amount.formatted(digits: 1, currency: nil), "124,4")
    }

    public func testFormattedAmountWithInvalidCurrency() {
        let amount: Decimal = 124.4
        
        XCTAssertEqual(amount.formatted(digits: 1, currency: " € "), "124,4 €")
    }
}
