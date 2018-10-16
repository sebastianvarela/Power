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
    
    public func testURLWithAnchor() {
        let urlWithAnchor = URL.fromString("http://www.hola.com#home")
        let urlWithoutAnchor = URL.fromString("http://www.chau.com")
        
        XCTAssertEqual(urlWithAnchor.anchor, "home")
        XCTAssertNil(urlWithoutAnchor.anchor)
    }
    
    public func testProcessQuery() {
        let query1 = URL.processQuery(query: "home&hola=chau")
        let query2 = URL.processQuery(query: "hi")
        
        XCTAssertEqual(query1, [URLQueryItem(name: "home", value: nil), URLQueryItem(name: "hola", value: "chau")])
        XCTAssertEqual(query2, [URLQueryItem(name: "hi", value: nil)])
    }
    
    public func testExtractQueryString() {
        let url = URL.fromString("http://www.google.com/somePath?wawa=wewe&yuyu=yaya")
        
        XCTAssertEqual(url.queryStringValue(key: "wawa"), "wewe")
        XCTAssertEqual(url.queryStringValue(key: "yuyu"), "yaya")
        XCTAssertEqual(url.queryStringValue(key: "pepe"), nil)
    }
}
