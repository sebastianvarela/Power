@testable import Power
import XCTest

public class IntExtensionsTests: XCTestCase {
    public func testTimesWithoutIndex() {
        var count = 0
        
        3.times {
            count += 1
        }
        
        XCTAssertEqual(count, 3)
    }

    public func testTimesWithIndex() {
        var count = 0
        var sequence = ""
        
        5.times { idx in
            count += 1
            sequence += "\(idx)"
        }
        
        XCTAssertEqual(count, 5)
        XCTAssertEqual(sequence, "01234")
    }
}
