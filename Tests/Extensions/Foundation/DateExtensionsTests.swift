@testable import Power
import XCTest

public class DateExtensionsTests: XCTestCase {
    private let timeZone = TimeZone(secondsFromGMT: 0)
    
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
        
        XCTAssertEqual(date.formattedSpanishDateString(timeZone: timeZone), "08/04/2018")
    }
    
    public func testConversionFromDateToFormattedShortDateInSpanish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedShortDateString(locale: .spanish, timeZone: timeZone), "08 abr")
    }

    public func testConversionFromDateToFormattedShortDateInEnglish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedShortDateString(locale: .english, timeZone: timeZone), "08 apr")
    }

    public func testConversionFromDateToFormattedShortDateTimeInEnglish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedShortDateTimeString(locale: .english, timeZone: timeZone), "08 apr ● 12:34")
    }
    
    public func testConversionFromDateToMonthYearStringInSpanish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedMonthYearString(locale: .spanish, timeZone: timeZone), "Abril 2018")
    }

    public func testConversionFromDateToMonthYearStringInEnglish() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
        
        XCTAssertEqual(date.formattedMonthYearString(locale: .english, timeZone: timeZone), "April 2018")
    }
    
    public func testTotalDays() {
        let date1 = Date(timeIntervalSince1970: 1_523_190_896) //08-04-2018
        let date2 = Date(timeIntervalSince1970: 1_525_782_896) //08-05-2018
        
        XCTAssertEqual(date2.totalDays(from: date1), 30)
        XCTAssertEqual(date1.totalDays(from: date2), 30)
    }
    
    public func testSubstration() {
        let diffToAdd: TimeInterval = 600_212
        let date1 = Date()
        let date2 = date1.addingTimeInterval(diffToAdd)
        
        let dateDiffInSeconds = date2 - date1
        
        XCTAssertEqual(dateDiffInSeconds, diffToAdd)
    }
    
    public func testExportingDateToISO8601Format() {
        let date = Date(timeIntervalSince1970: 1_523_190_896)
 
        XCTAssertEqual(date.iso8601String(utc: true), "2018-04-08T12:34:56Z")
        XCTAssertEqual(date.iso8601String(utc: false, timeZone: TimeZone(secondsFromGMT: 3_600)), "2018-04-08T13:34:56+01:00")
        XCTAssertEqual(date.iso8601String(utc: false, timeZone: TimeZone(secondsFromGMT: 7_200)), "2018-04-08T14:34:56+02:00")
    }
    
    public func testCreatingDateFromISO8601Date() {
        XCTAssertEqual(Date(iso8601String: "2018-09-25T15:25:51+02:00")?.iso8601String(utc: true), "2018-09-25T13:25:51Z")
        XCTAssertEqual(Date(iso8601String: "2015-12-11T20:28:23+0100")?.iso8601String(utc: true), "2015-12-11T19:28:23Z")
        XCTAssertEqual(Date(iso8601String: "2018-09-25T15:25:51Z")?.iso8601String(utc: true), "2018-09-25T15:25:51Z")
        XCTAssertNil(Date(iso8601String: "2018-09-02"))
    }
}
