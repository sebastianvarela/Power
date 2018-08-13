@testable import Power
import ReactiveSwift
import Result
import XCTest

public class SignalProducerExtensionsTests: XCTestCase {
    public func testDemoteErrorOnValueErrorInterrupted() {
        let valueToSend = "holita"
        let producer = SignalProducer<String, NSError> { observer, _ in
            observer.send(error: NSError(domain: "wawa", code: 214, userInfo: nil))
        }
        let expectCompleted = expectation(description: "Complete event")
        let expectValue = expectation(description: "Value event")
        let expectInterrupted = expectation(description: "Interrupted event")
        let expectError = expectation(description: "Error event")
        expectCompleted.isInverted = true
        expectValue.isInverted = true
        expectError.isInverted = true
        
        producer.demoteError().start { event in
            switch event {
            case .value(let value):
                if value == valueToSend {
                    expectValue.fulfill()
                }
            case .completed:
                expectCompleted.fulfill()
            case .failed:
                expectError.fulfill()
            case .interrupted:
                expectInterrupted.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    public func testDemoteErrorOnValueCompletedEvents() {
        let valueToSend = "holita"
        let producer = SignalProducer<String, NSError> { observer, _ in
            observer.send(value: valueToSend)
            observer.sendCompleted()
        }
        let expectCompleted = expectation(description: "Complete event")
        let expectValue = expectation(description: "Value event")
        let expectInterrupted = expectation(description: "Interrupted event")
        let expectError = expectation(description: "Error event")
        expectInterrupted.isInverted = true
        expectError.isInverted = true
        
        producer.demoteError().start { event in
            switch event {
            case .value(let value):
                if value == valueToSend {
                    expectValue.fulfill()
                }
            case .completed:
                expectCompleted.fulfill()
            case .failed:
                expectError.fulfill()
            case .interrupted:
                expectInterrupted.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
}
