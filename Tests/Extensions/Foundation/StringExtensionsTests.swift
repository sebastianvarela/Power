@testable import Power
import XCTest

public class StringExtensionsTests: XCTestCase {
    public func testDecimalSpanishParser() {
        XCTAssertEqual("".decimalSpanishValue, nil)
        XCTAssertEqual("123,45".decimalSpanishValue, 123.45)
        XCTAssertEqual("12345,23".decimalSpanishValue, 12_345.23)
    }
    
    public func testTrimmed() {
        let text = " wawa"
        XCTAssertEqual(text.trimed, "wawa")
    }
    
    public func testInNotEmpty() {
        let text = "hola"
        XCTAssert(text.isNotEmpty)
    }
    
    public func testValidEmail() {
        let email = "sebastian@elmasgrande.com"
        XCTAssert(email.isValidEmail())
        
        let email2 = "rana"
        XCTAssertFalse(email2.isValidEmail())
    }
    
    public func testBase64EncodeAndDecode() {
        let plainMessage = "hola ke ace"
        
        let encoded = plainMessage.base64Encoded
        let decoded = encoded.base64Decoded
        
        XCTAssertEqual(plainMessage, decoded)
        XCTAssertNotEqual(plainMessage, encoded)
    }
    
    public func testEncodeKnowTextInBase64() {
        let message = "hola holita"
        
        XCTAssertEqual(message.base64Encoded, "aG9sYSBob2xpdGE=")
    }
    
    public func testDecodeInvalidTextFromBase64() {
        let message = "this is not a base64 message"
        
        XCTAssertEqual(message.base64Decoded, nil)
    }
    
    public func testStringToDataConvertion() {
        let message = "Pablito clavó un clavito"
        
        XCTAssertEqual(message.dataUTF8?.stringUTF8, message)
    }
    
    public func testReplacedPercentEncodingFromLatinToUTF8() {
        let original = "int%E9ntelo"
        let expected = "inténtelo"
        
        XCTAssertEqual(original.replacedPercentEncodingFromLatinToUTF8.removingPercentEncoding, expected)
    }
    
    public func testSubscriptWithCountableClosedRange() {
        let string = "holachau"
        
        XCTAssertEqual(string[0...155], "holachau")
        XCTAssertEqual(string[0...2], "hol")
        XCTAssertEqual(string[2...3], "la")
        XCTAssertEqual(string[7...8], "u")
        XCTAssertEqual(string[8...10], "")
    }
    
    public func testSubscriptWithCountableRange() {
        let string = "holachau"
        
        XCTAssertEqual(string[100..<113], "")
        XCTAssertEqual(string[0..<113], "holachau")
        XCTAssertEqual(string[0..<1], "h")
        XCTAssertEqual(string[2..<4], "la")
        XCTAssertEqual(string[7..<8], "u")
        XCTAssertEqual(string[4..<8], "chau")
    }
    
    public func testSuffixFromString() {
        XCTAssertEqual("123,4224".suffix(from: ","), "4224")
        XCTAssertEqual("123--4224".suffix(from: "--"), "4224")
        XCTAssertEqual("12354224".suffix(from: "a"), nil)
    }
    
    public func testPrefixUpToString() {
        XCTAssertEqual("123,4224".prefix(upTo: ","), "123")
        XCTAssertEqual("123--4224".prefix(upTo: "--"), "123")
        XCTAssertEqual("12354224".prefix(upTo: "a"), "12354224")
    }
    
    public func testWithoutSpaces() {
        XCTAssertEqual("123 456 789".withoutSpaces, "123456789")
        XCTAssertEqual(" 12 3".withoutSpaces, "123")
    }
}
