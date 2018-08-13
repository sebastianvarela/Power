@testable import Power
import XCTest

public class URLExtensionsTests: XCTestCase {
    public func testStartsWith() {
        let base = URL.fromString("http://www.google.com")
        let complete = URL.fromString("http://www.google.com/somePath")
        
        XCTAssertTrue(complete.starts(with: complete))
        XCTAssertTrue(complete.starts(with: base))
        XCTAssertFalse(base.starts(with: complete))
    }
    
    public func testEndsWith() {
        let base = URL.fromString("http://www.google.com/somePath")
        
        XCTAssertTrue(base.ends(with: "/somePath"))
        XCTAssertFalse(base.ends(with: "/otherPath"))
    }
    
    public func testTrimQuery() {
        let url = URL.fromString("http://www.cuenca.com?from=madrid")
        
        XCTAssertEqual(url.absoluteStringByTrimmingQuery, URL.fromString("http://www.cuenca.com"))
    }
}
