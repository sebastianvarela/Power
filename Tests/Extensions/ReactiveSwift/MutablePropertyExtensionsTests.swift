@testable import Power
import ReactiveSwift
import Result
import XCTest

public class MutablePropertyExtensionsTests: XCTestCase {
    public func testSilentSwap() {
        let property = MutableProperty("hola")
        let finalValue = "chau"
        
        let expect = expectation(description: "checking value async")
        
        property.signal.observeValues { changes in
            XCTAssert(changes == finalValue)
            expect.fulfill()
        }
        
        property.silentSwap(finalValue)
        waitForExpectations(timeout: 1)
    }
}
