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
    
    public func testIsNilAndIsNotNil() {
        let property = MutableProperty<String?>(nil)
        let finalValue = "chau"
        
        let expect = expectation(description: "checking value async")
        expect.expectedFulfillmentCount = 2
        
        property.isNil.signal.observeValues { isNil in
            XCTAssertFalse(isNil)
            expect.fulfill()
        }
        property.isNotNil.signal.observeValues { isNotNil in
            XCTAssertTrue(isNotNil)
            expect.fulfill()
        }
        
        property.silentSwap(finalValue)
        waitForExpectations(timeout: 1)
    }
}
