//
//  SolarTermsTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class SolarTermsTests: XCTestCase {
    func testSolarTerms1() throws {
        let solar = Solar(fromYmd: 1986, month: 1, day: 5)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJie(), "小寒")
        XCTAssertEqual(lunar.getJieQi(), "小寒")
        XCTAssertEqual(lunar.currentJie?.name, "小寒")
        XCTAssertNil(lunar.currentQi)
        XCTAssertEqual(lunar.getQi(),"")
        XCTAssertEqual(lunar.getPrevJie().name, "大雪")
        XCTAssertEqual(lunar.getPrevQi().name, "冬至")
        XCTAssertEqual(lunar.getPrevJieQi().name, "冬至")
    }
    
    func testSolarTerms2() throws {
        let solar = Solar(fromYmdHms: 1986, month: 1, day: 20, hour: 17, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJie(), "")
        XCTAssertEqual(lunar.getJieQi(), "大寒")
        XCTAssertNil(lunar.currentJie)
        XCTAssertEqual(lunar.currentJieQi!.name, "大寒")
        XCTAssertNil(lunar.currentJie)
        XCTAssertEqual(lunar.getQi(), "大寒")
        XCTAssertEqual(lunar.getNextJie().name, "立春")
        XCTAssertEqual(lunar.getNextQi().name, "雨水")
        XCTAssertEqual(lunar.getNextJieQi().name, "立春")
    }
    
    func testSolarTerms3() throws {
        let solar = Solar(fromYmdHms: 1986, month: 1, day: 20, hour: 14, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getPrevJie().name, "小寒")
        XCTAssertEqual(lunar.getPrevQi().name, "冬至")
        XCTAssertEqual(lunar.getPrevJieQi().name, "小寒")
    }
    
    func testSolarTerms4() throws {
        let solar = Solar(fromYmd: 1986, month: 12, day: 7)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJie(), "大雪")
        XCTAssertEqual(lunar.getJieQi(), "大雪")
        XCTAssertEqual(lunar.currentJie!.name, "大雪")
        XCTAssertEqual(lunar.currentJieQi!.name, "大雪")
        XCTAssertNil(lunar.currentQi)
        XCTAssertEqual(lunar.getQi(), "")
        XCTAssertEqual(lunar.getNextJie().name, "大雪")
        XCTAssertEqual(lunar.getNextQi().name, "冬至")
        XCTAssertEqual(lunar.getNextJieQi().name, "大雪")
    }
    func testSolarTerms5() throws {
        let solar = Solar(fromYmd: 1986, month: 1, day: 1)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJie(), "")
        XCTAssertEqual(lunar.getJieQi(), "")
        XCTAssertNil(lunar.currentJie)
        XCTAssertNil(lunar.currentJieQi)
        XCTAssertNil(lunar.currentQi)
        XCTAssertEqual(lunar.getQi(), "")
        XCTAssertEqual(lunar.getPrevJie().name, "大雪")
        XCTAssertEqual(lunar.getPrevQi().name, "冬至")
        XCTAssertEqual(lunar.getPrevJieQi().name, "冬至")
        XCTAssertEqual(lunar.getNextJie().name, "小寒")
        XCTAssertEqual(lunar.getNextQi().name, "大寒")
        XCTAssertEqual(lunar.getNextJieQi().name, "小寒")
    }
    
    func testSolarTerms6() throws {
        let solar = Solar(fromYmd: 1986, month: 1, day: 1)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJie(), "")
        XCTAssertEqual(lunar.getJieQi(), "")
        XCTAssertNil(lunar.currentJie)
        XCTAssertNil(lunar.currentJieQi)
        XCTAssertNil(lunar.currentQi)
        XCTAssertEqual(lunar.getQi(), "")
        XCTAssertEqual(lunar.getPrevJie().name, "大雪")
        XCTAssertEqual(lunar.getPrevQi().name, "冬至")
        XCTAssertEqual(lunar.getPrevJieQi().name, "冬至")
        XCTAssertEqual(lunar.getNextJie().name, "小寒")
        XCTAssertEqual(lunar.getNextQi().name, "大寒")
        XCTAssertEqual(lunar.getNextJieQi().name, "小寒")
    }
    
    func testSolarTerms7() throws {
        let solarTermsTable: [String: String] = [
            "冬至": "2021-12-21 23:59:09",
            "小寒": "2022-01-05 17:13:54",
            "大寒": "2022-01-20 10:38:56",
            "立春": "2022-02-04 04:50:36",
            "雨水": "2022-02-19 00:42:50",
            "惊蛰": "2022-03-05 22:43:34",
            "春分": "2022-03-20 23:33:15",
            "清明": "2022-04-05 03:20:03",
            "谷雨": "2022-04-20 10:24:07",
            "立夏": "2022-05-05 20:25:46",
            "小满": "2022-05-21 09:22:25",
            "芒种": "2022-06-06 00:25:37",
            "夏至": "2022-06-21 17:13:40",
            "小暑": "2022-07-07 10:37:49",
            "大暑": "2022-07-23 04:06:49",
            "立秋": "2022-08-07 20:28:57",
            "处暑": "2022-08-23 11:15:59",
            "白露": "2022-09-07 23:32:07",
            "秋分": "2022-09-23 09:03:31",
            "寒露": "2022-10-08 15:22:16",
            "霜降": "2022-10-23 18:35:31",
            "立冬": "2022-11-07 18:45:18",
            "小雪": "2022-11-22 16:20:18",
            "大雪": "2022-12-07 11:46:04"
        ]
        let solar: Solar = Solar(fromYmd: 2022, month: 7, day: 15)
        let result: [String: Solar] = solar.getLunar().getJieQiTable()
        for entry in solarTermsTable {
            let name: String = entry.key
            XCTAssertEqual(result[name]!.toYmdHms(), entry.value)
        }
    }
    
    func testSolarTerms8() throws {
        let solarTermsTable: [String: String] = [
            "冬至": "1985-12-22 06:07:40",
            "小寒": "1986-01-05 23:28:02",
            "大寒": "1986-01-20 16:46:12",
            "立春": "1986-02-04 11:07:42",
            "雨水": "1986-02-19 06:57:31",
            "惊蛰": "1986-03-06 05:12:08",
            "春分": "1986-03-21 06:02:41",
            "清明": "1986-04-05 10:06:07",
            "谷雨": "1986-04-20 17:12:08",
            "立夏": "1986-05-06 03:30:36",
            "小满": "1986-05-21 16:27:55",
            "芒种": "1986-06-06 07:44:23",
            "夏至": "1986-06-22 00:29:57",
            "小暑": "1986-07-07 18:00:45",
            "大暑": "1986-07-23 11:24:23",
            "立秋": "1986-08-08 03:45:36",
            "处暑": "1986-08-23 18:25:47",
            "白露": "1986-09-08 06:34:37",
            "秋分": "1986-09-23 15:58:52",
            "寒露": "1986-10-08 22:06:45",
            "霜降": "1986-10-24 01:14:11",
            "立冬": "1986-11-08 01:12:49",
            "小雪": "1986-11-22 22:44:20",
            "大雪": "1986-12-07 18:00:56"
        ]
        let solar: Solar = Solar(fromYmd: 1986, month: 7, day: 15)
        let result: [String: Solar] = solar.getLunar().getJieQiTable()
        for entry in solarTermsTable {
            let name: String = entry.key
            XCTAssertEqual(result[name]!.toYmdHms(), entry.value)
        }
    }
    
    func testSolarTerms9() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2012, lunarMonth: 9, lunarDay: 1)
        XCTAssertEqual(lunar.getJieQiTable()["白露"]!.toYmdHms(), "2012-09-07 13:29:00")
    }
    
    func testSolarTerms10() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2050, lunarMonth: 12, lunarDay: 1)
        XCTAssertEqual(lunar.getJieQiTable()["大雪"]!.toYmdHms(), "2050-12-07 06:41:00")
    }
    
    func testSolarTerms11() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 12, day: 21)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJieQi(), "冬至")
        XCTAssertEqual(lunar.getJie(), "")
        XCTAssertEqual(lunar.getQi(), "冬至")
    }
}
