@testable import Power
import XCTest

public class ConstantKeyTests: XCTestCase {
    public func testRawvalue() {
        let rawValue = "valor constante"
        let const1 = ConstantKey(rawValue: rawValue)
        let const2 = ConstantKey(rawValue)
        
        XCTAssertEqual(const1.rawValue, rawValue)
        XCTAssertEqual(const2.rawValue, rawValue)
    }
    
    public func testHashvalue() {
        let rawValue = "valor constante"
        let const1 = ConstantKey(rawValue: rawValue)
        
        XCTAssertEqual(rawValue.hashValue, const1.hashValue)
    }
    
    public func testEquality() {
        let value1 = ConstantKey("hola")
        let value2 = ConstantKey("hola")
        
        XCTAssertEqual(value1, value2)
    }
    
    public func testInequality() {
        let value1 = ConstantKey("hola")
        let value2 = ConstantKey("chau")
        
        XCTAssertNotEqual(value1, value2)
    }
    
    public func testAddition() {
        let value1 = ConstantKey("hola")
        let value2 = ConstantKey("chau")
        let value3 = ConstantKey("hola.chau")
        
        XCTAssertEqual(value1 + value2, value3)
    }
}

