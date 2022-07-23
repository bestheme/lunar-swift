//
//  TimesetTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class TimesetTests: XCTestCase {
    func testTimeset1() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYear(), "乙酉")
        XCTAssertEqual(timeset.getMonth(), "戊子")
        XCTAssertEqual(timeset.getDay(), "辛巳")
        XCTAssertEqual(timeset.getTime(), "壬辰")
    }
    
    func testTimeset2() throws {
        let solar: Solar = Solar(fromYmdHms: 1988, month: 2, day: 15, hour: 23, minute: 30, second: 0)
        let lunar: Lunar = solar.getLunar()
        var timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYear(), "戊辰")
        XCTAssertEqual(timeset.getMonth(), "甲寅")
        XCTAssertEqual(timeset.getDay(), "辛丑")
        XCTAssertEqual(timeset.getTime(), "戊子")
        
        timeset.genre = 2
        XCTAssertEqual(timeset.getYear(), "戊辰")
        XCTAssertEqual(timeset.getMonth(), "甲寅")
        XCTAssertEqual(timeset.getDay(), "庚子")
        XCTAssertEqual(timeset.getTime(), "戊子")
    }
    
    func testTimeset3() throws {
        let solar: Solar = Solar(fromYmdHms: 1988, month: 2, day: 15, hour: 22, minute: 30, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYear(), "戊辰")
        XCTAssertEqual(timeset.getMonth(), "甲寅")
        XCTAssertEqual(timeset.getDay(), "庚子")
        XCTAssertEqual(timeset.getTime(), "丁亥")
    }
    
    func testTimeset4() throws {
        let solar: Solar = Solar(fromYmdHms: 1988, month: 2, day: 2, hour: 22, minute: 30, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYear(), "丁卯")
        XCTAssertEqual(timeset.getMonth(), "癸丑")
        XCTAssertEqual(timeset.getDay(), "丁亥")
        XCTAssertEqual(timeset.getTime(), "辛亥")
    }
    
    func testTimeset5() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2019, lunarMonth: 12, lunarDay: 12, hour: 11, minute: 22, second: 0)
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYear(), "己亥")
        XCTAssertEqual(timeset.getMonth(), "丁丑")
        XCTAssertEqual(timeset.getDay(), "戊申")
        XCTAssertEqual(timeset.getTime(), "戊午")
    }
    
    func testTimeset6() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearHideGan(), ["辛"])
        XCTAssertEqual(timeset.getMonthHideGan(), ["癸"])
        XCTAssertEqual(timeset.getDayHideGan(), ["丙","庚","戊"])
        XCTAssertEqual(timeset.getTimeHideGan(), ["戊","乙","癸"])
    }
    
    func testTimeset7() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearShiShenGan(), "偏财")
        XCTAssertEqual(timeset.getMonthShiShenGan(), "正印")
        XCTAssertEqual(timeset.getDayShiShenGan(), "日元")
        XCTAssertEqual(timeset.getTimeShiShenGan(), "伤官")
    }
    
    func testTimeset8() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearShiShenZhi(), ["比肩"])
        XCTAssertEqual(timeset.getMonthShiShenZhi(), ["食神"])
        XCTAssertEqual(timeset.getDayShiShenZhi(), ["正官","劫财","正印"])
        XCTAssertEqual(timeset.getTimeShiShenZhi(), ["正印","偏财","食神"])
    }
    
    func testTimeset9() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "临官")
        XCTAssertEqual(timeset.getMonthDiShi(), "长生")
        XCTAssertEqual(timeset.getDayDiShi(), "死")
        XCTAssertEqual(timeset.getTimeDiShi(), "墓")
    }
    
    func testTimeset10() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 18, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "病")
        XCTAssertEqual(timeset.getMonthDiShi(), "死")
        XCTAssertEqual(timeset.getDayDiShi(), "衰")
        XCTAssertEqual(timeset.getTimeDiShi(), "绝")
    }
    
    func testTimeset11() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 19, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "胎")
        XCTAssertEqual(timeset.getMonthDiShi(), "绝")
        XCTAssertEqual(timeset.getDayDiShi(), "长生")
        XCTAssertEqual(timeset.getTimeDiShi(), "死")
    }
    
    func testTimeset12() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 20, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "绝")
        XCTAssertEqual(timeset.getMonthDiShi(), "胎")
        XCTAssertEqual(timeset.getDayDiShi(), "病")
        XCTAssertEqual(timeset.getTimeDiShi(), "长生")
    }
    
    func testTimeset13() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 21, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "胎")
        XCTAssertEqual(timeset.getMonthDiShi(), "绝")
        XCTAssertEqual(timeset.getDayDiShi(), "冠带")
        XCTAssertEqual(timeset.getTimeDiShi(), "死")
    }
    
    func testTimeset14() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 22, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "绝")
        XCTAssertEqual(timeset.getMonthDiShi(), "胎")
        XCTAssertEqual(timeset.getDayDiShi(), "帝旺")
        XCTAssertEqual(timeset.getTimeDiShi(), "长生")
    }
    
    func testTimeset15() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 23, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "死")
        XCTAssertEqual(timeset.getMonthDiShi(), "病")
        XCTAssertEqual(timeset.getDayDiShi(), "沐浴")
        XCTAssertEqual(timeset.getTimeDiShi(), "帝旺")
    }
    
    func testTimeset16() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 24, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "长生")
        XCTAssertEqual(timeset.getMonthDiShi(), "沐浴")
        XCTAssertEqual(timeset.getDayDiShi(), "衰")
        XCTAssertEqual(timeset.getTimeDiShi(), "临官")
    }
    
    func testTimeset17() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 25, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "帝旺")
        XCTAssertEqual(timeset.getMonthDiShi(), "临官")
        XCTAssertEqual(timeset.getDayDiShi(), "长生")
        XCTAssertEqual(timeset.getTimeDiShi(), "沐浴")
    }
    
    func testTimeset18() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 26, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "临官")
        XCTAssertEqual(timeset.getMonthDiShi(), "帝旺")
        XCTAssertEqual(timeset.getDayDiShi(), "病")
        XCTAssertEqual(timeset.getTimeDiShi(), "病")
    }
    
    func testTimeset19() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 11, day: 27, hour: 17, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearDiShi(), "沐浴")
        XCTAssertEqual(timeset.getMonthDiShi(), "长生")
        XCTAssertEqual(timeset.getDayDiShi(), "养")
        XCTAssertEqual(timeset.getTimeDiShi(), "胎")
    }
    
    func testTimeset20() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getYearNaYin(), "泉中水")
        XCTAssertEqual(timeset.getMonthNaYin(), "霹雳火")
        XCTAssertEqual(timeset.getDayNaYin(), "白蜡金")
        XCTAssertEqual(timeset.getTimeNaYin(), "长流水")
    }
    
    func testTimeset21() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 30, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getTaiYuan(), "己卯")
    }
    
    func testTimeset22() throws {
        let solar: Solar = Solar(fromYmdHms: 1995, month: 12, day: 18, hour: 10, minute: 28, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getTaiYuan(), "己卯")
    }
    
    func testTimeset23() throws {
        let solar: Solar = Solar(fromYmdHms: 2005, month: 12, day: 23, hour: 8, minute: 37, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getMingGong(), "己丑")
    }
    
    func testTimeset24() throws {
        let solar: Solar = Solar(fromYmdHms: 1998, month: 6, day: 11, hour: 4, minute: 28, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getMingGong(), "辛酉")
    }
    
    func testTimeset25() throws {
        let solar: Solar = Solar(fromYmdHms: 1995, month: 12, day: 18, hour: 10, minute: 28, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getMingGong(), "戊子")
    }
    
    func testTimeset26() throws {
        let solar: Solar = Solar(fromYmdHms: 1995, month: 12, day: 18, hour: 10, minute: 28, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getShenGong(), "壬午")
    }
    
    func testTimeset27() throws {
        let solar: Solar = Solar(fromYmdHms: 1994, month: 12, day: 6, hour: 2, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getShenGong(), "丁丑")
    }
    
    func testTimeset28() throws {
        let solar: Solar = Solar(fromYmdHms: 1990, month: 12, day: 11, hour: 6, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getShenGong(), "庚辰")
    }
    
    func testTimeset29() throws {
        let solar: Solar = Solar(fromYmdHms: 1993, month: 5, day: 23, hour: 4, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        let timeset: Timeset = lunar.getTimeset()
        XCTAssertEqual(timeset.getShenGong(), "庚申")
    }
    
    func testTimeset30() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1985, lunarMonth: 12, lunarDay: 27)
        XCTAssertEqual(lunar.getTimeset().getYun(gender: 1).getStartSolar().toYmd(), "1995-11-05")
    }
    
    func testTimeset31() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1985, lunarMonth: 1, lunarDay: 27)
        XCTAssertEqual(lunar.getTimeset().getYun(gender: 1).getStartSolar().toYmd(), "1989-03-28")
    }
    
    func testTimeset32() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1986, lunarMonth: 12, lunarDay: 27)
        XCTAssertEqual(lunar.getTimeset().getYun(gender: 1).getStartSolar().toYmd(), "1990-04-15")
    }
}
