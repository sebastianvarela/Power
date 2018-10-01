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

        XCTAssertEqual(Bool(yesNoString: "yes"), true)
        XCTAssertEqual(Bool(yesNoString: "YES"), true)
        XCTAssertEqual(Bool(yesNoString: "Yes"), true)
        XCTAssertEqual(Bool(yesNoString: "no"), false)
        XCTAssertEqual(Bool(yesNoString: "NO"), false)
        XCTAssertEqual(Bool(yesNoString: "No"), false)
        XCTAssertNil(Bool(yesNoString: "caca"))
        
        XCTAssertEqual(Bool(oneZeroString: "1"), true)
        XCTAssertEqual(Bool(oneZeroString: "0"), false)
        XCTAssertNil(Bool(oneZeroString: "caca"))

        XCTAssertEqual(Bool(enabledDisabledString: "enabled"), true)
        XCTAssertEqual(Bool(enabledDisabledString: "ENABLED"), true)
        XCTAssertEqual(Bool(enabledDisabledString: "Enabled"), true)
        XCTAssertEqual(Bool(enabledDisabledString: "disabled"), false)
        XCTAssertEqual(Bool(enabledDisabledString: "DISABLED"), false)
        XCTAssertEqual(Bool(enabledDisabledString: "Disabled"), false)
        XCTAssertNil(Bool(enabledDisabledString: "caca"))

        XCTAssertEqual(Bool(enableDisableString: "enable"), true)
        XCTAssertEqual(Bool(enableDisableString: "ENABLE"), true)
        XCTAssertEqual(Bool(enableDisableString: "Enable"), true)
        XCTAssertEqual(Bool(enableDisableString: "disable"), false)
        XCTAssertEqual(Bool(enableDisableString: "DISABLE"), false)
        XCTAssertEqual(Bool(enableDisableString: "Disable"), false)
        XCTAssertNil(Bool(enableDisableString: "caca"))
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

    public func testYesNoString() {
        XCTAssertEqual(false.yesNoString, "No")
        XCTAssertEqual(true.yesNoString, "Yes")
    }
    
    public func testTrueFalseString() {
        XCTAssertEqual(false.trueFalseString, "False")
        XCTAssertEqual(true.trueFalseString, "True")
    }

    public func testEnableDisableString() {
        XCTAssertEqual(false.enableDisableString, "Disable")
        XCTAssertEqual(true.enableDisableString, "Enable")
    }

    public func testEnabledDisabledString() {
        XCTAssertEqual(false.enabledDisabledString, "Disabled")
        XCTAssertEqual(true.enabledDisabledString, "Enabled")
    }

    public func testOneZeroString() {
        XCTAssertEqual(false.oneZeroString, "0")
        XCTAssertEqual(true.oneZeroString, "1")
    }
}
