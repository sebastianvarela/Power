@testable import Power
import XCTest

public class UserDefaultsWrapperTests: XCTestCase {
    private let wrapper = DefaultUserDefaultsWrapper()
    
    public func testDeleteInBackground() {
        let value = "delete this to background"
        let key = ConstantKey("testBackground1")
        
        wrapper.set(value: value, forKey: key, background: false)

        let firstRead = wrapper.string(forKey: key)
        XCTAssertEqual(firstRead, value)

        wrapper.delete(key: key, background: true)
        
        let expectCompleted = expectation(description: "checking delete async")
        
        DispatchQueue.main.async {
            for _ in 1...5 {
                sleep(1)
                let loopRead = self.wrapper.string(forKey: key)
                if loopRead.isNil {
                    expectCompleted.fulfill()
                    break
                }
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
    public func testWriteStringInBackground() {
        let value = "write this to background"
        let key = ConstantKey("testBackground2")
        
        let firstRead = wrapper.string(forKey: key)
        XCTAssertNil(firstRead)
        
        wrapper.set(value: value, forKey: key, background: true)
        
        let expectCompleted = expectation(description: "checking write async")
        
        DispatchQueue.main.async {
            for _ in 1...5 {
                sleep(1)
                let loopRead = self.wrapper.string(forKey: key)
                if loopRead == value {
                    expectCompleted.fulfill()
                    break
                }
            }
        }
        
        waitForExpectations(timeout: 5)
        wrapper.delete(key: key)
    }
    
    public func testWriteBoolInBackground() {
        let key = ConstantKey("testBackground3")
        
        let firstRead = wrapper.bool(forKey: key)
        XCTAssertFalse(firstRead)
        
        wrapper.set(value: true, forKey: key, background: true)
        
        let expectCompleted = expectation(description: "checking write async")
        
        DispatchQueue.main.async {
            for _ in 1...5 {
                sleep(1)
                let loopRead = self.wrapper.bool(forKey: key)
                if loopRead {
                    expectCompleted.fulfill()
                    break
                }
            }
        }
        
        waitForExpectations(timeout: 5)
        wrapper.delete(key: key)
    }
    
    public func testReadWriteDeleteString() {
        let value = "hola, quiero guardar esto"
        let key = ConstantKey("test1")
        
        let firstRead = wrapper.string(forKey: key)
        XCTAssertNil(firstRead)
        
        wrapper.set(value: value, forKey: key)
        
        let secondRead = wrapper.string(forKey: key)
        XCTAssertEqual(secondRead, value)
        
        wrapper.delete(key: key)
        
        let thirdRead = wrapper.string(forKey: key)
        XCTAssertNil(thirdRead)
    }
    
    public func testReadWriteDeleteBool() {
        let key = ConstantKey("test2")
        
        let firstRead = wrapper.bool(forKey: key)
        XCTAssertFalse(firstRead)
        
        wrapper.set(value: true, forKey: key)

        let secondRead = wrapper.bool(forKey: key)
        XCTAssertTrue(secondRead)
        
        wrapper.delete(key: key)
        
        let thirdRead = wrapper.bool(forKey: key)
        XCTAssertFalse(thirdRead)
    }
}
