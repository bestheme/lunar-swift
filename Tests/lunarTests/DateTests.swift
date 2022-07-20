//
//  Date_test.swift
//  
//
//  Created by 睿宁 on 2022/7/13.
//
import XCTest

@available(macOS 12.0, *)
final class DateTests: XCTestCase {
    func testDate() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date: Date = dateFormatter.date(from: "0320-02-03 08:00:00.000")!
        XCTAssertEqual(date.formatted(.dateTime.year()), "320")
//        DateTime.parse('0320-02-03 08:00:00.000');
//        expect(date.year, 320);
//        XCTAssertEqual(solar.toString(), "2019/05/01")
//        XCTAssertEqual(solar.toFullString(), "2019/05/01 00:00:00 星期三 (劳动节) 金牛座")
    }
    
}
