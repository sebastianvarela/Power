@testable import Power
import XCTest

public class CollectionExtensionsTests: XCTestCase {
    public func testIsNotEmpty() {
        XCTAssertFalse([].isNotEmpty)
        XCTAssertTrue(["hi", "bye"].isNotEmpty)
    }
}
