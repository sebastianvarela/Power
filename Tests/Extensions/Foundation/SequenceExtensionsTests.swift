@testable import Power
import XCTest

public class SequenceExtensionsTests: XCTestCase {
    public func testGroup() {
        let array = ["AA", "AB", "BC", "BD", ""]
        let grouped = array.group { $0.first }
        
        XCTAssertEqual(grouped["A"], ["AA", "AB"])
        XCTAssertEqual(grouped["B"], ["BC", "BD"])
        XCTAssertEqual(grouped["C"], nil)
        XCTAssertEqual(grouped[nil], [""])
    }
}
