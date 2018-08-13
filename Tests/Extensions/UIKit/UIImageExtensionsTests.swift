@testable import Power
import UIKit
import XCTest

public class UIImageExtensionsTests: XCTestCase {
    private var squareImage: UIImage?
    private var nonSquareImage: UIImage?
    
    public override func setUp() {
        super.setUp()
        
        let bundle = Bundle(for: type(of: self))
        if let imagePath = bundle.path(forResource: "image-500x500", ofType: "jpg") {
            squareImage = UIImage(contentsOfFile: imagePath)
        }
        if let imagePath = bundle.path(forResource: "image-500x425", ofType: "jpg") {
            nonSquareImage = UIImage(contentsOfFile: imagePath)
        }
        XCTAssertNotNil(squareImage)
        XCTAssertEqual(squareImage?.size.width, squareImage?.size.height, "This image MUST BE an square")
        XCTAssertNotNil(nonSquareImage)
        XCTAssertNotEqual(nonSquareImage?.size.width, nonSquareImage?.size.height, "This image MUST BE an square")
    }
    
    public func testResizeToSpecificWidth() {
        let image = nonSquareImage?.resized(toWidth: 100)
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.size.width, 100)
        XCTAssertEqual(image?.size.height, 85)
    }

    public func testResizeToSpecificHeight() {
        let image = nonSquareImage?.resized(toHeight: 85)
        
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.size.width, 100)
        XCTAssertEqual(image?.size.height, 85)
    }
}
