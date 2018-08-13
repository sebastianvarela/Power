@testable import Power
import XCTest

public class TimeIntervalExtensionsTests: XCTestCase {
    public func testIntValueToFormattedTimeString() {
        XCTAssertEqual(TimeInterval(integerLiteral: 000).formattedTimeString, "0:00")
        XCTAssertEqual(TimeInterval(integerLiteral: 005).formattedTimeString, "0:05")
        XCTAssertEqual(TimeInterval(integerLiteral: 010).formattedTimeString, "0:10")
        XCTAssertEqual(TimeInterval(integerLiteral: 055).formattedTimeString, "0:55")
        XCTAssertEqual(TimeInterval(integerLiteral: 060).formattedTimeString, "1:00")
        XCTAssertEqual(TimeInterval(integerLiteral: 090).formattedTimeString, "1:30")
        XCTAssertEqual(TimeInterval(integerLiteral: 300).formattedTimeString, "5:00")
    }
    
    public func testFloatValueToFormattedTimeString() {
        let almost300: TimeInterval = 299.976_023_077_965
        let almost60: TimeInterval = 59.976_023_077_965
        let almost1: TimeInterval = 0.976_023_077_965
        
        XCTAssertEqual(almost300.formattedTimeString, "4:59")
        XCTAssertEqual(almost60.formattedTimeString, "0:59")
        XCTAssertEqual(almost1.formattedTimeString, "0:00")
    }
}
