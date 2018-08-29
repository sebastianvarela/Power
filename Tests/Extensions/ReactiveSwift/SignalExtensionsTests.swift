@testable import Power
import ReactiveSwift
import Result
import XCTest

public class SignalExtensionsTests: XCTestCase {
    public func testOnValueReceivedWhenObserverSendAValue() {
        let expect = expectation(description: "Closure for code filled completed")
        let (signal, observer) = Signal<Int, NoError>.pipe()
        
        signal.onValueReceived {
            expect.fulfill()
        }
        observer.send(value: 3)
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnValueReceivedWhenObserverDoesNotSendNothing() {
        let expect = expectation(description: "Closure for code filled completed")
        expect.isInverted = true
        let (signal, _) = Signal<Int, NoError>.pipe()
        
        signal.onValueReceived {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnErrorReceivedWhenObserverSendAValue() {
        let expect = expectation(description: "checking error async")
        let (signal, observer) = Signal<Int, NSError>.pipe()
        
        signal.onErrorReceived {
            expect.fulfill()
        }
        observer.send(error: NSError(domain: "error", code: 123, userInfo: nil))
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnErrorReceivedWhenObserverDoesNotSendNothing() {
        let expect = expectation(description: "checking no error async")
        expect.isInverted = true
        let (signal, _) = Signal<Int, NSError>.pipe()
        
        signal.onErrorReceived {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    public func testDemoteError() {
        let expect = expectation(description: "checking value async")
        let (signal, observer) = Signal<Int, NSError>.pipe()
        let value = 123
        
        signal.demoteError().observeResult { action in
            switch action {
            case .failure:
                XCTFail("This should not be fired")
            case .success(let val):
                expect.fulfill()
                XCTAssertEqual(value, val)
            }
        }

        observer.send(value: value)
        observer.send(error: NSError(domain: "error", code: 1234, userInfo: nil))
        
        waitForExpectations(timeout: 1)
    }
}
