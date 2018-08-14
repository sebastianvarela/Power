@testable import Power
import XCTest

public class StringUIExtensionsTests: XCTestCase {
    public func testHtmlConversion() {
        let message = "<b>Soy Nuñez</b>"
        
        XCTAssertEqual(message.htmlAttributedString?.string, "Soy Nuñez")
    }
}
