@testable import Power
import XCTest

public class BoolExtensionsTests: XCTestCase {
    public func testInits() {
        XCTAssertEqual(Bool(onOffString: "on"), true)
        XCTAssertEqual(Bool(onOffString: "ON"), true)
        XCTAssertEqual(Bool(onOffString: "On"), true)
        XCTAssertEqual(Bool(onOffString: "off"), false)
        XCTAssertEqual(Bool(onOffString: "OFF"), false)
        XCTAssertEqual(Bool(onOffString: "Off"), false)
        XCTAssertNil(Bool(onOffString: "caca"))

        XCTAssertEqual(Bool(oneZeroString: "1"), true)
        XCTAssertEqual(Bool(oneZeroString: "0"), false)
        XCTAssertNil(Bool(oneZeroString: "caca"))
    }
    
    public func testIsFalse() {
        XCTAssertTrue(false.isFalse)
        XCTAssertFalse(true.isFalse)
    }

    public func testAsInt() {
        XCTAssertEqual(false.asInt, 0)
        XCTAssertEqual(true.asInt, 1)
    }

    public func testOnOffString() {
        XCTAssertEqual(false.onOffString, "Off")
        XCTAssertEqual(true.onOffString, "On")
    }

    public func testTrueFalseString() {
        XCTAssertEqual(false.trueFalseString, "False")
        XCTAssertEqual(true.trueFalseString, "True")
    }
    
    public func testOneZeroString() {
        XCTAssertEqual(false.oneZeroString, "0")
        XCTAssertEqual(true.oneZeroString, "1")
    }
}
