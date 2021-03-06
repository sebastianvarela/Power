@testable import Power
import ReactiveSwift
import Result
import XCTest

public class SignalProducerExtensionsTests: XCTestCase {
    public func testLifeCycleWithProducerThatEmitValueCompleted() {
        let expect = expectation(description: "Checking producer steps")
        expect.expectedFulfillmentCount = 5

        let producer = SignalProducer<String, NoError> { observer, _ in
            observer.send(value: "😚")
            observer.sendCompleted()
        }
        
        var step = 0
        producer
            .onStarting {
                step += 1
                XCTAssertEqual(step, 1)
                expect.fulfill()
            }
            .onValue { _ in
                step += 1
                XCTAssertEqual(step, 2)
                expect.fulfill()
            }
            .onCompleted {
                step += 1
                XCTAssertEqual(step, 3)
                expect.fulfill()
            }
            .onTerminated {
                step += 1
                XCTAssertEqual(step, 4)
                expect.fulfill()
            }
            .onStarted {
                step += 1
                XCTAssertEqual(step, 5)
                expect.fulfill()
            }
            .start()
        
        waitForExpectations(timeout: 1)
    }
    
    public func testLifeCycleWithProducerThatEmitValueError() {
        let expect = expectation(description: "Checking producer steps")
        expect.expectedFulfillmentCount = 5
        
        let producer = SignalProducer<String, NSError> { observer, _ in
            observer.send(value: "😚")
            observer.send(error: NSError(domain: "wawa", code: 214, userInfo: nil))
        }
        
        var step = 0
        producer
            .onStarting {
                step += 1
                XCTAssertEqual(step, 1)
                expect.fulfill()
            }
            .onValue { _ in
                step += 1
                XCTAssertEqual(step, 2)
                expect.fulfill()
            }
            .onFailed { _ in
                step += 1
                XCTAssertEqual(step, 3)
                expect.fulfill()
            }
            .onTerminated {
                step += 1
                XCTAssertEqual(step, 4)
                expect.fulfill()
            }
            .onStarted {
                step += 1
                XCTAssertEqual(step, 5)
                expect.fulfill()
            }
            .start()
        
        waitForExpectations(timeout: 1)
    }
    
    public func testLifeCycleWithProducerThatEmitError() {
        let expect = expectation(description: "Checking producer steps")
        expect.expectedFulfillmentCount = 4
        
        let producer = SignalProducer<String, NSError> { observer, _ in
            observer.send(error: NSError(domain: "wawa", code: 214, userInfo: nil))
        }
        
        var step = 0
        producer
            .onStarting {
                step += 1
                XCTAssertEqual(step, 1)
                expect.fulfill()
            }
            .onFailed { _ in
                step += 1
                XCTAssertEqual(step, 2)
                expect.fulfill()
            }
            .onTerminated {
                step += 1
                XCTAssertEqual(step, 3)
                expect.fulfill()
            }
            .onStarted {
                step += 1
                XCTAssertEqual(step, 4)
                expect.fulfill()
            }
            .start()
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnValue() {
        let value = "hola"
        let expect = expectation(description: "checking value async")
        let producer = SignalProducer<String, NoError> { observer, _ in
            observer.send(value: value)
            observer.sendCompleted()
        }
        
        producer
            .onValue { val in
                XCTAssertTrue(val == value)
                expect.fulfill()
            }
            .start()
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnError() {
        let expect = expectation(description: "checking value async")
        let producer = SignalProducer<String, NSError> { observer, _ in
            observer.send(error: NSError(domain: "wawa", code: 214, userInfo: nil))
        }
        
        producer
            .onFailed { err in
                XCTAssertTrue(err.domain == "wawa")
                expect.fulfill()
            }
            .start()
        
        waitForExpectations(timeout: 1)
    }
    
    public func testOnCompleted() {
        let expect = expectation(description: "checking value async")
        let producer = SignalProducer<String, NSError> { observer, _ in
            observer.send(value: "hi")
            observer.sendCompleted()
        }
        
        producer
            .onCompleted {
                expect.fulfill()
            }
            .start()
        
        waitForExpectations(timeout: 1)
    }
    
    public func testMapToVoid() {
        let expect = expectation(description: "checking value async")
        let producer = SignalProducer<String, NoError> { observer, _ in
            observer.send(value: "hola")
            observer.sendCompleted()
        }
        
        producer.mapToVoid().startWithValues { value in
            XCTAssert(value == ())
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

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
    
    public func testStartWithObserverAndSendValueOnSuccess() {
        let expectCompleted = expectation(description: "Complete event")

        let producer1 = SignalProducer<Int, NSError> { observer, _ in
            observer.send(value: 1)
            observer.sendCompleted()
        }
        let producer2 = SignalProducer<String, NSError> { observer, lifetime in
            lifetime += producer1.start(observer, replaceWithValue: "hola")
        }
        
        producer2.startWithResult { result in
            if let value = result.value {
                XCTAssertEqual(value, "hola")
                expectCompleted.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    public func testStartWithCompletedOnUIScheduler() {
        let expectCompleted = expectation(description: "Complete event")
        
        let producer1 = SignalProducer<Int, NoError> { observer, _ in
            observer.send(value: 1)
            observer.sendCompleted()
        }
        
        DispatchQueue.global(qos: .background).async {
            producer1.startWithCompletedOnUIScheduler {
                XCTAssertTrue(Thread.isMainThread)
                expectCompleted.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    public func testStartWithValuesOnUIScheduler() {
        let expectCompleted = expectation(description: "Complete event")
        
        let producer1 = SignalProducer<Int, NoError> { observer, _ in
            observer.send(value: 1)
            observer.sendCompleted()
        }
        
        DispatchQueue.global(qos: .background).async {
            producer1.startWithValuesOnUIScheduler { value in
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertEqual(value, 1)
                expectCompleted.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
}
