@testable import Power
import XCTest

public class DateExtensionsTests: XCTestCase {
    public func testDateByAddingComponent() {
        let date = Date(timeIntervalSince1970: 1_523_190_896) //08-04-2018
        let datePlusOneMinute = Date(timeIntervalSince1970: 1_523_190_956) //08-04-2018
        let datePlusOneHour = Date(timeIntervalSince1970: 1_523_194_496) //08-04-2018
        let datePlusOneDay = Date(timeIntervalSince1970: 1_523_277_296) //09-04-2018
        let datePlusOneMonth = Date(timeIntervalSince1970: 1_525_782_896) //08-05-2018
        let datePlusOneYear = Date(timeIntervalSince1970: 1_554_726_896) //08-04-2019

        XCTAssertEqual(date.dateByAdding(minutes: 1), datePlusOneMinute)
        XCTAssertEqual(date.dateByAdding(hours: 1), datePlusOneHour)
        XCTAssertEqual(date.dateByAdding(days: 1), datePlusOneDay)
        XCTAssertEqual(date.dateByAdding(months: 1), datePlusOneMonth)
        XCTAssertEqual(date.dateByAdding(years: 1), datePlusOneYear)
    }
    
    public func testConversionFromDateToSpanishFormattedDate() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedSpanishDateString, "08/04/2018")
    }
    
    public func testConversionFromDateToFormattedShortDateInSpanish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedShortDateString(locale: .spanish), "08 abr")
    }

    public func testConversionFromDateToFormattedShortDateInEnglish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedShortDateString(locale: .english), "08 apr")
    }

    public func testConversionFromDateToFormattedShortDateTimeInEnglish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedShortDateTimeString(locale: .english), "08 apr ● 14:34")
    }
    
    public func testConversionFromDateToMonthYearStringInSpanish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedMonthYearString(locale: .spanish), "Abril 2018")
    }

    public func testConversionFromDateToMonthYearStringInEnglish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedMonthYearString(locale: .english), "April 2018")
    }
    
    public func testTotalDays() {
        let date1 = Date(timeIntervalSince1970: 1_523_190_896) //08-04-2018
        let date2 = Date(timeIntervalSince1970: 1_525_782_896) //08-05-2018
        
        XCTAssertEqual(date2.totalDays(from: date1), 30)
    }
}
