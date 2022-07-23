//
//  SolarTests.swift
//  
//
//  Created by 睿宁 on 2022/7/12.
//

import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class SolarTests: XCTestCase {
    func testSolar() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let solar: Solar = Solar(fromYmd: 2019, month: 5, day: 1)
        XCTAssertEqual(solar.toString(), "2019-05-01")
        XCTAssertEqual(solar.toFullString(), "2019-05-01 00:00:00 星期三 (劳动节) 金牛座")
//        XCTAssertEqual(solar.getLunar().toString(), "二〇一九年三月廿七")
//        XCTAssertEqual(solar.getLunar().toFullString(), "二〇一九年三月廿七 己亥(猪)年 戊辰(龙)月 戊戌(狗)日 子(鼠)时 纳音[平地木 大林木 平地木 桑柘木] 星期三 西方白虎 星宿[参水猿](吉) 彭祖百忌[戊不受田田主不祥 戌不吃犬作怪上床] 喜神方位[巽](东南) 阳贵神方位[艮](东北) 阴贵神方位[坤](西南) 福神方位[艮](东北) 财神方位[坎](正北) 冲[(壬辰)龙] 煞[北]")
    }
    
    func testFromYmd() throws {
        var solar: Solar = Solar(fromYmd: 2020, month: 1, day: 23)
        XCTAssertEqual(solar.next(days: 1).toString(), "2020-01-24")
        /// 仅工作日，跨越春节假期
        XCTAssertEqual(solar.next(days: 1, onlyWorkday: true).toString(), "2020-02-03")
        
        solar = Solar(fromYmd: 2020, month: 2, day: 3)
        XCTAssertEqual(solar.next(days: -3).toString(), "2020-01-31")
        /// 仅工作日，跨越春节假期
        XCTAssertEqual(solar.next(days: -3, onlyWorkday: true).toString(), "2020-01-21")
        
        solar = Solar(fromYmd: 2020, month: 2, day: 9)
        XCTAssertEqual(solar.next(days: 6).toString(), "2020-02-15")
        /// 仅工作日，跨越周末
        XCTAssertEqual(solar.next(days: 6, onlyWorkday: true).toString(), "2020-02-17")
        
        solar = Solar(fromYmd: 2020, month: 1, day: 17)
        XCTAssertEqual(solar.next(days: 1).toString(), "2020-01-18")
        /// 仅工作日，周日调休按上班算
        XCTAssertEqual(solar.next(days: 1, onlyWorkday: true).toString(), "2020-01-19")
    }
    
    func testIsLeepYear() throws {
        XCTAssertEqual(SolarUtil.isLeapYear(year: 1500), false)
    }
    
    func testSolarGetterAndSetter() {
        let dateFormat: DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date: Date = dateFormat.date(from: "2022-07-22 18:59:56")!
        let solar: Solar = Solar(fromDate: date)
//        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(solar.calendar, date)
    }
}

