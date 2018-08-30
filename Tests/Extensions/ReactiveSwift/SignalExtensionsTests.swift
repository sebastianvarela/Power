@testable import Power
import ReactiveSwift
import Result
import XCTest

public class SignalExtensionsTests: XCTestCase {
    public func testMapToVoid() {
        let expect = expectation(description: "checking value async")
        let (signal, observer) = Signal<Int, NoError>.pipe()
        
        signal.mapToVoid().observeValues { void in
            XCTAssert(void == ())
            expect.fulfill()
        }
        
        observer.send(value: 4)
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnValueReceivedWhenObserverSendAValue() {
        let expect = expectation(description: "checking value async")
        let (signal, observer) = Signal<Int, NoError>.pipe()
        
        signal.onValueReceived {
            expect.fulfill()
        }
        observer.send(value: 3)
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnValueReceivedWhenObserverDoesNotSendNothing() {
        let expect = expectation(description: "checking no value async")
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
    
    public func testBindingSignalToObserverWithNoError() {
        let expect = expectation(description: "checking value async throught binding")
        let (signal2, observer2) = Signal<Int, NoError>.pipe()
        let (signal1, observer1) = Signal<Int, NoError>.pipe()

        observer1 <~ signal2
        signal1.onValueReceived {
            expect.fulfill()
        }
        observer2.send(value: 3)

        waitForExpectations(timeout: 1)
    }

    public func testBindingSignalToObserverWithError() {
        let valueExpect = expectation(description: "checking value async throught binding")
        let errorExpect = expectation(description: "checking error async throught binding")
        let error = NSError(domain: "error", code: 123, userInfo: nil)
        let value = 3
        let (signal2, observer2) = Signal<Int, NSError>.pipe()
        let (signal1, observer1) = Signal<Int, NSError>.pipe()
        
        observer1 <~ signal2
        signal1.observeResult { action in
            switch action {
            case .failure(let err):
                errorExpect.fulfill()
                XCTAssertEqual(error, err)
            case .success(let val):
                valueExpect.fulfill()
                XCTAssertEqual(value, val)
            }
        }
        observer2.send(value: value)
        observer2.send(error: error)
        
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
        observer.send(error: NSError(domain: "error", code: 1_234, userInfo: nil))
        
        waitForExpectations(timeout: 1)
    }
}
