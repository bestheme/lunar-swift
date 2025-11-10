//
//  LunarYearTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//

import XCTest
@testable import SwiftLunar

@available(iOS 15.0, *)
@available(macOS 12.0, *)
final class LunarYearTests: XCTestCase {
    func testLunarYearForFirst() throws {
        let year: LunarYear = LunarYear(lunarYear: 2021)
        let lunar = Lunar(fromDate: Date())
//        let dayYi = LunarUtil.getDayYi(monthGanZhi: "壬子", dayGanZhi: "庚申")
//        let dayJi = LunarUtil.getDayJi(monthGanZhi: "壬子", dayGanZhi: "庚申")
//        let dayJiShen = LunarUtil.getDayJiShen(lunarMonth: lunar.month, dayGanZhi: "庚申")
//        let dayXiongShen = LunarUtil.getDayXiongSha(lunarMonth: lunar.month, dayGanZhi: "庚申")
        let timeYi = LunarUtil.getTimeYi(dayGanZhi: "庚申", timeGanZhi: "癸未")
        let timeJi = LunarUtil.getTimeJi(dayGanZhi: "庚申", timeGanZhi: "癸未")
        XCTAssertEqual(year.toString(), "2021")
    }
    
    func testLunarYearForSecond() throws {
        let year: LunarYear = LunarYear(lunarYear: 2017)
        XCTAssertEqual(year.getZhiShui(), "二龙治水")
        XCTAssertEqual(year.getFenBing(), "二人分饼")
    }
    
    func testLunarYearForThird() throws {
        let year: LunarYear = LunarYear(lunarYear: 2018)
        XCTAssertEqual(year.getZhiShui(), "二龙治水")
        XCTAssertEqual(year.getFenBing(), "八人分饼")
        XCTAssertEqual(year.getDeJin(), "三日得金")
    }
    
    func testLunarYearForFourth() throws {
        let year: LunarYear = LunarYear(lunarYear: 2021)
        XCTAssertEqual(year.getGengTian(), "十一牛耕田")
    }
}

