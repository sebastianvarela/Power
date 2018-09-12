@testable import Power
import XCTest

public class NSSetExtensionsTests: XCTestCase {
    public func testFilterThatPassAnyIntToStringInASafeWay() {
        let set = NSSet(array: [1, 2, Date(), 4])
        
        let maped = set.filterMap { ele -> String? in
            if let num = ele as? Int {
                return String(num)
            }
            return nil
        }
        
        XCTAssertEqual(maped.sorted(), ["1", "2", "4"])
    }
    
    public func testFilterMapWithClosureThatThrowAnError() {
        let set = NSSet(array: [1, 2, Date(), 4])
        
        let maped = set.filterMap { _ in
            throw NSError(domain: "Some", code: 2, userInfo: nil)
        }
        
        XCTAssertTrue(maped.isEmpty)
    }
}
