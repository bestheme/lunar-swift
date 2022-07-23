//
//  YunTests.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class YunTests: XCTestCase {
    func testYun1() throws {
        let solar: Solar = Solar(fromYmdHms: 1981, month: 1, day: 29, hour: 23, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        let yun: Yun = timeset.getYun(gender: 0)
        XCTAssertEqual(yun.startYear, 8)
        XCTAssertEqual(yun.startMonth, 0)
        XCTAssertEqual(yun.startDay, 20)
        XCTAssertEqual(yun.getStartSolar().toYmd(), "1989-02-18")
      }

    func testYun2() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2019, lunarMonth: 12, lunarDay: 12, hour: 11, minute: 22, second: 0)
        let timeset: Timeset = lunar.getTimeset()
        let yun: Yun = timeset.getYun(gender: 1)
        XCTAssertEqual(yun.startYear, 0)
        XCTAssertEqual(yun.startMonth, 1)
        XCTAssertEqual(yun.startDay, 0)
        XCTAssertEqual(yun.getStartSolar().toYmd(), "2020-02-06")
      }

    func testYun3() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 1, day: 6, hour: 11, minute: 22, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        let yun: Yun = timeset.getYun(gender: 1)
        XCTAssertEqual(yun.startYear, 0)
        XCTAssertEqual(yun.startMonth, 1)
        XCTAssertEqual(yun.startDay, 0)
        XCTAssertEqual(yun.getStartSolar().toYmd(), "2020-02-06")
      }

    func testYun4() throws {
        let solar: Solar = Solar(fromYmdHms: 2022, month: 3, day: 9, hour: 20, minute: 51, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        let yun: Yun = timeset.getYun(gender: 1)
        XCTAssertEqual(yun.getStartSolar().toYmd(), "2030-12-19")
      }

    func testYun5() throws {
        let solar: Solar = Solar(fromYmdHms: 2022, month: 3, day: 9, hour: 20, minute: 51, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        let yun: Yun = timeset.getYun(gender: 1, genre: 2)
        XCTAssertEqual(yun.startYear, 8)
        XCTAssertEqual(yun.startMonth, 9)
        XCTAssertEqual(yun.startDay, 2)
        XCTAssertEqual(yun.getStartSolar().toYmd(), "2030-12-12")
      }

    func testYun6() throws {
        let solar: Solar = Solar(fromYmdHms: 2018, month: 6, day: 11, hour: 9, minute: 30, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        let yun: Yun = timeset.getYun(gender: 0, genre: 2)
        XCTAssertEqual(yun.getStartSolar().toYmd(), "2020-03-21")
      }
}
