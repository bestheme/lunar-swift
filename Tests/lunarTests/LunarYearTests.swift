//
//  LunarYearTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//

import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class LunarYearTests: XCTestCase {
    func testLunarYearForFirst() throws {
        let year: LunarYear = LunarYear(lunarYear: 2021)
        XCTAssertEqual(year.toString(), "2021")
    }
    
    func testLunarYearForSecond() throws {
        let year: LunarYear = LunarYear(lunarYear: 2017)
        XCTAssertEqual(year.getZhiShui(), "二龙治水")
        XCTAssertEqual(year.getFenBing(), "二人分饼")
    }
}

