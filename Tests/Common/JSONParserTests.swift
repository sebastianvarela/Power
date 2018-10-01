@testable import Power
import XCTest

public class JSONParserTests: XCTestCase {
    private let jsonParser = JSONParser()

    public func testParse() {
        let jsonParser = JSONParser()
        
        XCTAssertEqual(jsonParser.parse(CodableTest.self, from: "{\"field1\": \"hola\", \"field2\": 42}"),
                       CodableTest(field1: "hola", field2: 42))
        XCTAssertNil(jsonParser.parse(CodableTest.self, from: ""))
        XCTAssertNil(jsonParser.parse(CodableTest.self, from: "{}"))
        XCTAssertNil(jsonParser.parse(CodableTest.self, from: "5️⃣"))
    }
    
    public func testUnparse() {
        XCTAssertEqual(jsonParser.unparse(CodableTest(field1: "hola", field2: 42)), "{\"field2\":42,\"field1\":\"hola\"}")
        XCTAssertEqual(jsonParser.unparse(CodableTest(field1: "chau", field2: 69)), "{\"field2\":69,\"field1\":\"chau\"}")
        XCTAssertNil(jsonParser.unparse(CodableTestEncodeBlow(field1: "chau", field2: 69)))
    }
    
    public func testParseAndUnparse() {
        let expectSuccess = expectation(description: "Checking for success")
        let expectFail1 = expectation(description: "Checking for fail")
        expectFail1.isInverted = true
        let expectFail2 = expectation(description: "Checking for fail")
        expectFail2.isInverted = true

        let success = jsonParser.parseAndUnparse(CodableTest.self, from: "{\"field2\":69,\"field1\":\"chau\"}") { model in
            expectSuccess.fulfill()
            XCTAssertEqual(model.field1, "chau")
            XCTAssertEqual(model.field2, 69)
        }
        XCTAssertTrue(success)

        let fail1 = jsonParser.parseAndUnparse(CodableTestEncodeBlow.self, from: "{\"field2\":69,\"field1\":\"chau\"}") { _ in
            expectFail1.fulfill()
        }
        XCTAssertFalse(fail1)
        
        let fail2 = jsonParser.parseAndUnparse(CodableTest.self, from: "{}") { _ in
            expectFail2.fulfill()
        }
        XCTAssertFalse(fail2)
        
        waitForExpectations(timeout: 1)
    }
    
    public func testUnparseAndParse() {
        XCTAssertTrue(jsonParser.unparseAndParse(CodableTest(field1: "hola", field2: 42)))
        XCTAssertFalse(jsonParser.unparseAndParse(CodableTestEncodeBlow(field1: "hola", field2: 42)))
    }
}

// MARK: Internal type for test

internal class CodableTest: Codable, Equatable {
    internal let field1: String
    internal let field2: Int
    
    internal init(field1: String, field2: Int) {
        self.field1 = field1
        self.field2 = field2
    }
    
    internal static func == (lhs: CodableTest, rhs: CodableTest) -> Bool {
        return lhs.field1 == rhs.field1 && lhs.field2 == rhs.field2
    }
}

internal class CodableTestEncodeBlow: Codable, Equatable {
    internal let field1: String
    internal let field2: Int
    
    internal init(field1: String, field2: Int) {
        self.field1 = field1
        self.field2 = field2
    }
    
    internal required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodableTestCodingKeys.self)
        field1 = try container.decode(String.self, forKey: .keyField1)
        field2 = try container.decode(Int.self, forKey: .keyField2)
    }
    
    internal func encode( to encoder: Encoder) throws {
        throw NSError(domain: "BOOM", code: 24, userInfo: nil)
    }
    
    internal static func == (lhs: CodableTestEncodeBlow, rhs: CodableTestEncodeBlow) -> Bool {
        return lhs.field1 == rhs.field1 && lhs.field2 == rhs.field2
    }
    
    internal enum CodableTestCodingKeys: String, CodingKey {
        case keyField1 = "field1"
        case keyField2 = "field2"
    }
}
