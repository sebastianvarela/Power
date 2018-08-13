@testable import Power
import XCTest

public class UICollectionViewCellsExtensionsTests: XCTestCase {
    public func testNibName() {
        XCTAssertEqual(TestCollectionViewCell.nibName, "TestCollectionViewCell")
    }
}

private class TestCollectionViewCell: UICollectionViewCell {
    
}
