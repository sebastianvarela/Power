@testable import Power
import UIKit
import XCTest

public class UIColorExtensionsTests: XCTestCase {
    public func testConversionToWhite() {
        let white = UIColor.fromHex("FFFFFF")
        XCTAssert(white.equals(.white))
    }

    public func testConversionToBlack() {
        let black = UIColor.fromHex("000000")
        XCTAssert(black.equals(.black))
    }

    public func testConversionToRed() {
        let red = UIColor.fromHex("FF0000")
        XCTAssert(red.equals(.red))
    }

    public func testConversionToGreen() {
        let green = UIColor.fromHex("00FF00")
        XCTAssert(green.equals(.green))
    }

    public func testConversionToBlue() {
        let blue = UIColor.fromHex("0000FF")
        XCTAssert(blue.equals(.blue))
    }
    
    public func testIsClear() {
        let clear = UIColor.clear
        XCTAssertTrue(clear.isClear)
    }
}
