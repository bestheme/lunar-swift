//
//  TaoistTests.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class TaoistTests: XCTestCase {
    func testTaoist1() throws {
        let taoist: Taoist = Taoist.fromLunar(lunar: Lunar(fromYmdHms: 2021, lunarMonth: 10, lunarDay: 17, hour: 18, minute: 0, second: 0))
        XCTAssertEqual(taoist.toString(), "四七一八年十月十七")
        XCTAssertEqual(taoist.toFullString(), "道歷四七一八年，天運辛丑年，己亥月，癸酉日。十月十七日，酉時。")
      }

    func testTaoist2() throws {
        let taoist1: Taoist = Taoist.fromYmd(year: 4718, month: 10, day: 18);
        var l1: [String] = []
        for taoistFestival in taoist1.getFestivals() {
            l1.append(taoistFestival.name)
        }
        XCTAssertEqual(l1, ["地母娘娘圣诞", "四时会"])

        
        let taoist2 = Lunar(fromYmdHms: 2021, lunarMonth: 10, lunarDay: 18).getTaoist()
        var l2: [String] = []
        for taoistFestival in taoist2.getFestivals() {
            l2.append(taoistFestival.name)
        }
        XCTAssertEqual(l2, ["地母娘娘圣诞", "四时会"])
      }
}
    
