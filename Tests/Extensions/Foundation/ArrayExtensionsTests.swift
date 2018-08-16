@testable import Power
import XCTest

public class ArrayExtensionsTests: XCTestCase {
    public func testObjectAtIndex() {
        let array = ["A", "B", "C", "D"]
        
        XCTAssertEqual(array.object(atIndex: 0), "A")
        XCTAssertEqual(array.object(atIndex: 2), "C")
        XCTAssertNil(array.object(atIndex: 4))
    }
    
    public func testRemoveAnExistentElementInArray() {
        var array = ["A", "B", "C", "D"]
        
        let result = array.remove("C")
        
        XCTAssertEqual(array, ["A", "B", "D"])
        XCTAssertTrue(result)
    }
    
    public func testRemoveAnInexistentElementInArray() {
        var array = ["A", "B", "C", "D"]
        
        let result = array.remove("E")
        
        XCTAssertEqual(array, ["A", "B", "C", "D"])
        XCTAssertFalse(result)
    }
    
    public func testRemoveAnExistentElemenArraytInArray() {
        var array = ["A", "B", "C", "D"]
        
        let result = array.remove(["C", "D"])
        
        XCTAssertEqual(array, ["A", "B"])
        XCTAssertTrue(result)
    }
    
    public func testRemoveAnInexistentElementArrayInArray() {
        var array = ["A", "B", "C", "D"]
        
        let result = array.remove(["E", "F"])
        
        XCTAssertEqual(array, ["A", "B", "C", "D"])
        XCTAssertFalse(result)
    }

    public func testRemoveSomeElementsAccordingToFilter() {
        var array = ["A", "BB", "C", "DD"]
        
        let result = array.remove { $0.count == 2 }
        
        XCTAssertEqual(array, ["A", "C"])
        XCTAssertTrue(result)
    }
    
    public func testRemoveSomeElementsAccordingToFilterWithoutMatches() {
        var array = ["A", "BB", "C"]
        
        let result = array.remove { $0.count == 3 }
        
        XCTAssertEqual(array, ["A", "BB", "C"])
        XCTAssertFalse(result)
    }
    
    public func testRemovingOneElement() {
        let array = ["A", "B", "C", "D"]
        
        let result = array.removing("C")
        
        XCTAssertEqual(result, ["A", "B", "D"])
        XCTAssertEqual(array, ["A", "B", "C", "D"])
    }

    public func testRemovingAnArray() {
        let array = ["A", "B", "C", "D"]
        
        let result = array.removing(["C", "B"])
        
        XCTAssertEqual(result, ["A", "D"])
        XCTAssertEqual(array, ["A", "B", "C", "D"])
    }

    public func testUpsertWhenTheObjectDoesNotExists() {
        var array = ["A", "B", "C"]
        
        array.upsert("D")
        
        XCTAssertEqual(array, ["A", "B", "C", "D"])
    }

    public func testUpsertWhenTheObjectExists() {
        var array = [UniqueValue(id: 1, value: "hola")]
        
        array.upsert(UniqueValue(id: 1, value: "holita"))
        
        XCTAssertEqual(array.count, 1)
        XCTAssertEqual(array.first?.id, 1)
        XCTAssertEqual(array.first?.value, "holita")
    }
}
