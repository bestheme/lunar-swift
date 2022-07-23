//
//  SolarWeekTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//

import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class SolarWeekTests: XCTestCase {
    func testSolarWeekForFirst() throws {
        let week: SolarWeek = SolarWeek(year: 2021, month: 5, day: 1, start: 0)
        XCTAssertEqual(week.index, 1)
    }
    
    func testSolarWeekForSecond() throws {
        let week: SolarWeek = SolarWeek(year: 2021, month: 5, day: 4, start: 2)
        XCTAssertEqual(week.index, 2)
    }
    
    func testSolarWeekForThird() throws {
        let week: SolarWeek = SolarWeek(year: 2022, month: 5, day: 1, start: 0)
        XCTAssertEqual(week.index, 1)
    }
    
    func testSolarWeekForFourth() throws {
        let week: SolarWeek = SolarWeek(year: 2022, month: 5, day: 1, start: 1)
        XCTAssertEqual(week.index, 1)
    }
    
    func testSolarWeekForFifth() throws {
        let week: SolarWeek = SolarWeek(year: 2022, month: 3, day: 6, start: 0)
        XCTAssertEqual(week.getIndexInYear(), 11)
    }
}

