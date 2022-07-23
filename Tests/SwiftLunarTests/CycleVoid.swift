//
//  CycleVoid.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class CycleVoidTests: XCTestCase {
    func testCycleVoid1() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 19, hour: 0, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getYearXun(), "甲午")
    }
    
    func testCycleVoid2() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 19, hour: 0, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getYearXunKong(), "辰巳")
        XCTAssertEqual(lunar.getMonthXunKong(), "午未")
        XCTAssertEqual(lunar.getDayXunKong(), "戌亥")
    }
    
    func testCycleVoid3() throws {
        let solar: Solar = Solar(fromYmdHms: 1990, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getDayXunKong(), "子丑")
    }
}
