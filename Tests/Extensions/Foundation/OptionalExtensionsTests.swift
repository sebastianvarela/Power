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
    
    public func testIsFalseForBoolWrapped() {
        let nilValue: Bool? = nil
        let trueValue: Bool? = true
        let falseValue: Bool? = false
        
        XCTAssertNil(nilValue)
        XCTAssertFalse(nilValue.isFalse)

        XCTAssertNotNil(trueValue)
        XCTAssertFalse(trueValue.isFalse)

        XCTAssertNotNil(falseValue)
        XCTAssertTrue(falseValue.isFalse)
    }
    
    public func testIsTrueForBoolWrapped() {
        let nilValue: Bool? = nil
        let trueValue: Bool? = true
        let falseValue: Bool? = false
        
        XCTAssertNil(nilValue)
        XCTAssertFalse(nilValue.isTrue)
        
        XCTAssertNotNil(trueValue)
        XCTAssertTrue(trueValue.isTrue)
        
        XCTAssertNotNil(falseValue)
        XCTAssertFalse(falseValue.isTrue)
    }
}
