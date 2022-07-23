//
//  BuddhisTests.swift
//  
//
//  Created by 睿宁 on 2022/7/21.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class BuddhisTests: XCTestCase {
    func testBuddhis1() throws {
        let buddhis: Buddhis = Buddhis(lunar: Lunar(fromYmdHms: 2021, lunarMonth: 10, lunarDay: 14))
        XCTAssertEqual(buddhis.toFullString(), "二五六五年十月十四 (三元降) (四天王巡行)")
    }
    
    func testBuddhis2() throws {
        let buddhis: Buddhis = Buddhis(lunar: Lunar(fromYmdHms: 2020, lunarMonth: 4, lunarDay: 13))
        XCTAssertEqual(buddhis.xiu, "氐")
        XCTAssertEqual(buddhis.zheng, "土")
        XCTAssertEqual(buddhis.animal, "貉")
        XCTAssertEqual(buddhis.gong, "东")
        XCTAssertEqual(buddhis.shou, "青龙")
    }
}
