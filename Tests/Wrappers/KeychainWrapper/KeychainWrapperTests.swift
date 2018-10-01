@testable import Power
import XCTest

public class KeychainWrapperTests: XCTestCase {
    private let wrapper = DefaultKeychainWrapper()
    private let service = ConstantKey("net.s3ba")
    
    public override func tearDown() {
        wrapper.clear()
        
        super.tearDown()
    }
    
    public func testReadWriteDeleteString() {
        let value = "hola, quiero guardar esto"
        let account = ConstantKey("net.s3ba.net.Power.readWriteTestForString")
        
        let firstRead = wrapper.read(stringFromService: service, andAccount: account)
        XCTAssertNil(firstRead)
        
        let saveResult = wrapper.save(value, inService: service, andAccount: account)
        XCTAssertTrue(saveResult)
        
        let secondRead = wrapper.read(stringFromService: service, andAccount: account)
        XCTAssertEqual(secondRead, value)
        
        let deleteResult = wrapper.delete(service: service, account: account)
        XCTAssertTrue(deleteResult)

        let thirdRead = wrapper.read(stringFromService: service, andAccount: account)
        XCTAssertNil(thirdRead)
    }
    
    public func testReadWriteDeleteData() {
        let value = "some string".dataUTF8

        let account = ConstantKey("readWriteTestForData")

        let firstRead = wrapper.read(stringFromService: service, andAccount: account)
        XCTAssertNil(firstRead)
        
        let saveResult = wrapper.save(value, inService: service, andAccount: account)
        XCTAssertTrue(saveResult)
        
        let secondRead = wrapper.read(dataFromService: service, andAccount: account)
        XCTAssertEqual(secondRead, value)
        
        let deleteResult = wrapper.delete(service: service, account: account)
        XCTAssertTrue(deleteResult)
        
        let thirdRead = wrapper.read(stringFromService: service, andAccount: account)
        XCTAssertNil(thirdRead)
    }
}
