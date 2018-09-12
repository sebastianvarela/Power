@testable import Power
import ReactiveSwift
import Result
import XCTest

public class ActionExtensionsTests: XCTestCase {
    public func testOnCompletedAction() {
        let expect = expectation(description: "checking value async")

        let enabledIf = Property(value: true)
        let action = Action<Void, Void, NoError>(enabledIf: enabledIf) { _ in
            return SignalProducer { observer, _ in
                observer.sendCompleted()
            }
        }
        action.onCompletedAction {
            XCTAssertTrue(Thread.isMainThread)
            expect.fulfill()
        }
        
        DispatchQueue.global(qos: .background).async {
            action.apply().start()
        }
        
        waitForExpectations(timeout: 1)
    }
}
