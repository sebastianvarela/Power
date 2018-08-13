@testable import Power
import UIKit
import XCTest

public class UITableViewHeaderFooterViewTests: XCTestCase {
    public func testNibName() {
        XCTAssertEqual(TestTableViewHeaderFooterView.nibName, "TestTableViewHeaderFooterView")
    }
}

private class TestTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
}
