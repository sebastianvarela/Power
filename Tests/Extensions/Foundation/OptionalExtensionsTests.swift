@testable import Power
import XCTest

public class OptionalExtensionsTests: XCTestCase {
    public func testTextualDescriptionForOptionalString() {
        let text: String? = "hola ke ace"
        
        XCTAssertEqual(text.textualDescription, "hola ke ace")
    }

    public func testTextualDescriptionForOptionalStringEmpty() {
        let nothing: String? = nil
        
        XCTAssertEqual(nothing.textualDescription, "<nil>")
    }
    
    public func testTextualDescriptionForOptionalInt() {
        let number: Int? = 4
        
        XCTAssertEqual(number.textualDescription, "4")
    }

    public func testIsNotNil() {
        let nothing: String? = "pole"
        
        XCTAssertNotNil(nothing)
        XCTAssertTrue(nothing.isNotNil)
    }
    
    public func testIsNil() {
        let nothing: String? = nil
        
        XCTAssertNil(nothing)
        XCTAssertTrue(nothing.isNil)
    }
    
    public func testIsNilOrEmpty() {
        let nothing: String? = nil
        let something: String? = "hola"
        let trap: String? = ""
        
        XCTAssertNil(nothing)
        XCTAssertTrue(nothing.isNilOrEmpty)
        XCTAssertNotNil(something)
        XCTAssertFalse(something.isNilOrEmpty)
        XCTAssertNotNil(trap)
        XCTAssertTrue(trap.isNilOrEmpty)
    }
}
