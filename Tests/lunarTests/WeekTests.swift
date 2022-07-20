//
//  WeekTests.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//

import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class testWeek: XCTestCase {
    func testWeekForFirst() throws {
        // 一周的开始从星期一开始计
        let start: Int = 1
        let week: SolarWeek = SolarWeek(year: 2019, month: 5, day: 1, start: start)
        XCTAssertEqual(week.toString(), "2019.5.1")
        XCTAssertEqual(week.toFullString(), "2019年5月第1周")
        XCTAssertEqual(SolarUtil.getWeeksOfMonth(year: week.year, month: week.month, start: start), 5)
        XCTAssertEqual(week.getFirstDay().toString(), "2019-04-29")
        XCTAssertEqual(week.getFirstDayInMonth()?.toString(), "2019-05-01")
    }
    
    func testWeekForSecond() throws {
        // 一周的开始从星期日开始计
        let start: Int = 0;
        let week: SolarWeek = SolarWeek(year: 2019, month: 5, day: 1, start: start)
        XCTAssertEqual(week.toString(), "2019.5.1")
        XCTAssertEqual(week.toFullString(), "2019年5月第1周")
        
        // 当月共几周
        XCTAssertEqual(
            SolarUtil.getWeeksOfMonth(year: week.year, month: week.month, start: start), 5)
        
        // 当周第一天
        XCTAssertEqual(week.getFirstDay().toString(), "2019-04-28")
        
        // 当周第一天（本月）
        XCTAssertEqual(week.getFirstDayInMonth()!.toString(), "2019-05-01")
        
    }
    
    func testWeekForThird() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 8, day: 11)
        XCTAssertEqual(solar.week, 3)
        XCTAssertEqual(solar.weekInChinese, "三")
    }
    
    func testWeekForFourth() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 8, day: 8)
        XCTAssertEqual(solar.week, 0)
        XCTAssertEqual(solar.weekInChinese, "日")
    }
    
    func testWeekForFifth() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 8, day: 14)
        XCTAssertEqual(solar.week, 6)
        XCTAssertEqual(solar.weekInChinese, "六")
    }
}
