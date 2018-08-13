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
}
