//
//  TimesetTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//
import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class testTimeset: XCTestCase {
    func testTimesetForFirst() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYear(), "乙酉")
//        XCTAssertEqual(week.toFullString(), "2019年5月第1周")
//        XCTAssertEqual(SolarUtil.getWeeksOfMonth(year: week.year, month: week.month, start: start), 5)
//        XCTAssertEqual(week.getFirstDay().toString(), "2019-04-29")
//        XCTAssertEqual(week.getFirstDayInMonth()?.toString(), "2019-05-01")
    }
}
