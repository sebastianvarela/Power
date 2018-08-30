@testable import Power
import XCTest

public class CharacterExtensionsTests: XCTestCase {
    public func testStringValue() {
        let char: Character = "a"
        
        XCTAssertEqual(char.stringValue, "a")
    }
}
