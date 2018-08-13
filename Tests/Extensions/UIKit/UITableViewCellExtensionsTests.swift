@testable import Power
import UIKit
import XCTest

public class UITableViewCellExtensionsTests: XCTestCase {
    public func testNibName() {
        XCTAssertEqual(TestTableViewCell.nibName, "TestTableViewCell")
    }
}

private class TestTableViewCell: UITableViewCell {
    
}
