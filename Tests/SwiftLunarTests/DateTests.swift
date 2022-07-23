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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date: Date = dateFormatter.date(from: "0320-02-03 08:00:00.000")!
        XCTAssertEqual(date.formatted(.dateTime.year()), "320")
    }
    
}
