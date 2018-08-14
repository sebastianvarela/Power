@testable import Power
import XCTest

public class LocaleExtensionsTests: XCTestCase {
    public func testLocalizedName() {
        XCTAssertEqual(Locale.spanish.localizedName, "Español")
        XCTAssertEqual(Locale.english.localizedName, "English")
        XCTAssertEqual(Locale(identifier: "ja").localizedName, "日本語") //Japanese
        XCTAssertEqual(Locale(identifier: "some random id").localizedName, "-")
    }
}
