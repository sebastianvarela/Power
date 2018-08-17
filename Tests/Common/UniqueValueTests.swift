@testable import Power
import XCTest

public class UniqueValueTests: XCTestCase {
    public func testEquality() {
        let value1 = UniqueValue(id: 1, value: "hola")
        let value2 = UniqueValue(id: 1, value: "chau")
        let value3 = UniqueValue(id: 1, value: "adios")

        XCTAssertEqual(value1, value2)
        XCTAssertEqual(value1, value3)
        XCTAssertEqual(value2, value3)
    }
    
    public func testInequality() {
        let value1 = UniqueValue(id: 1, value: "hola")
        let value2 = UniqueValue(id: 2, value: "hola")
        let value3 = UniqueValue(id: 3, value: "chau")

        XCTAssertNotEqual(value1, value2)
        XCTAssertNotEqual(value1, value3)
        XCTAssertNotEqual(value2, value3)
    }
    
    public func testFindById() {
        let value1 = UniqueValue(id: 1, value: "hola")
        let value2 = UniqueValue(id: 2, value: "chau")
        let value3 = UniqueValue(id: 3, value: "adios")
        
        XCTAssertEqual([value1, value2, value3].find(byId: value3.id), value3)
        XCTAssertNil([value1, value2, value3].find(byId: 4))
    }
}
