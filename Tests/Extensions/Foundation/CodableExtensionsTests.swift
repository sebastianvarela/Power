@testable import Power
import XCTest

public class CodableExtensionsTests: XCTestCase {
    public func testJsonString() {
        let array = [1, 2, 3]
        let dict = [1: "one", 2: "two"]
        
        XCTAssertEqual(array.jsonString, "[1,2,3]")
        XCTAssertEqual(dict.jsonString, "{\"1\":\"one\",\"2\":\"two\"}")
    }
}
