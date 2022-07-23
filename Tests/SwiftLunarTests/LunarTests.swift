import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class LunarTests: XCTestCase {
    func testLunar() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2019, lunarMonth: 3, lunarDay: 27, hour: 0, minute: 0, second: 0)
        XCTAssertEqual(lunar.toString(), "二〇一九年三月廿七")
        XCTAssertEqual(lunar.toFullString(), "二〇一九年三月廿七 己亥(猪)年 戊辰(龙)月 戊戌(狗)日 子(鼠)时 纳音[平地木 大林木 平地木 桑柘木] 星期三 西方白虎 星宿[参水猿](吉) 彭祖百忌[戊不受田田主不祥 戌不吃犬作怪上床] 喜神方位[巽](东南) 阳贵神方位[艮](东北) 阴贵神方位[坤](西南) 福神方位[艮](东北) 财神方位[坎](正北) 冲[(壬辰)龙] 煞[北]")
        XCTAssertEqual(lunar.solar?.toString(), "2019-05-01")
        XCTAssertEqual(lunar.solar?.toFullString(), "2019-05-01 00:00:00 星期三 (劳动节) 金牛座")
    }
    func testLunar1() throws {
        let solar: Solar = Solar(fromYmdHms: 1, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar.getLunar().toString(), "〇年冬月十八")
    }
    func testLunar2() throws {
        let solar: Solar = Solar(fromYmdHms: 9999, month: 12, day: 31, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar.getLunar().toString(), "九九九九年腊月初二")
    }
    func testLunar3() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 0, lunarMonth: 11, lunarDay: 18, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "0001-01-01")
    }
    func testLunar4() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 9999, lunarMonth: 12, lunarDay: 2, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "9999-12-31")
    }
    func testLunar5() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1905, lunarMonth: 1, lunarDay: 1, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "1905-02-04")
    }
    func testLunar6() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2038, lunarMonth: 12, lunarDay: 29, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "2039-01-23")
    }
    func testLunar7() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2020, lunarMonth: -4, lunarDay: 2, hour: 13, minute: 0, second: 0)
        XCTAssertEqual(lunar.toString(), "二〇二〇年闰四月初二")
        XCTAssertEqual(lunar.solar!.toString(), "2020-05-24")
    }
    func testLunar8() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2020, lunarMonth: 12, lunarDay: 10, hour: 13, minute: 0, second: 0)
        XCTAssertEqual(lunar.toString(), "二〇二〇年腊月初十")
        XCTAssertEqual(lunar.solar!.toString(), "2021-01-22")
    }
    func testLunar9() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1500, lunarMonth: 1, lunarDay: 1, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "1500-01-31")
    }
    func testLunar10() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1500, lunarMonth: 12, lunarDay: 29, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "1501-01-18")
    }
    func testLunar11() throws {
        let solar: Solar = Solar(fromYmdHms: 1500, month: 1, day: 1, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar.getLunar().toString(), "一四九九年腊月初一")
    }
    func testLunar12() throws {
        let solar: Solar = Solar(fromYmdHms: 1500, month: 12, day: 31, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar.getLunar().toString(), "一五〇〇年腊月十一")
    }
    func testLunar13() throws {
        let solar: Solar = Solar(fromYmdHms: 1582, month: 10, day: 4, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar.getLunar().toString(), "一五八二年九月十八")
    }
    func testLunar14() throws {
        let solar: Solar = Solar(fromYmdHms: 1582, month: 10, day: 15, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar.getLunar().toString(), "一五八二年九月十九")
    }
    func testLunar15() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1582, lunarMonth: 9, lunarDay: 18, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "1582-10-04")
    }
    func testLunar16() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 1582, lunarMonth: 9, lunarDay: 19, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "1582-10-15")
    }
    func testLunar17() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2019, lunarMonth: 12, lunarDay: 12, hour: 11, minute: 22, second: 0)
        XCTAssertEqual(lunar.solar!.toString(), "2020-01-06")
    }
    func testLunar18() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2021, lunarMonth: 12, lunarDay: 29)
        XCTAssertEqual(lunar.getFestivals()[0], "除夕")
    }
    func testLunar19() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2020, lunarMonth: 12, lunarDay: 30)
        XCTAssertEqual(lunar.getFestivals()[0], "除夕")
    }
    func testLunar20() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2020, lunarMonth: 12, lunarDay: 29)
        XCTAssertEqual(lunar.getFestivals().count, 0)
    }
    func testLunar21() throws {
        let solar: Solar = Solar(fromYmd:2022, month:1, day:31)
        let lunar = solar.getLunar()
        XCTAssertEqual(lunar.getFestivals()[0], "除夕")
    }
    func testLunar22() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2033, lunarMonth: -11, lunarDay: 1)
        XCTAssertEqual(lunar.getSolar().toYmd(), "2033-12-22")
    }
    func testLunar23() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2022, lunarMonth: 1, lunarDay: 1)
        XCTAssertEqual(lunar.getYearNineStar().toString(), "六白金开阳")
    }
    func testLunar24() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2033, lunarMonth: 1, lunarDay: 1)
        XCTAssertEqual(lunar.getYearNineStar().toString(), "四绿木天权")
    }
    func testLunar25() throws {
        let solar: Solar = Solar(fromYmdHms: 2021, month: 6, day: 7, hour: 21, minute: 18, second: 0)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.toString(), "二〇二一年四月廿七")
    }
    func testLunar26() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2021, lunarMonth: 6, lunarDay: 7, hour: 21, minute: 18, second: 0)
        let solar: Solar = lunar.getSolar()
        XCTAssertEqual(solar.toString(), "2021-07-16")
    }
    func testNext() throws {
        let solar: Solar = Solar(fromYmdHms: 2020, month: 1, day: 10, hour: 12, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        for i in -50..<50 {
            //To-Do Using toFullString()
            XCTAssertEqual(lunar.next(days: i).toString(), solar.next(days: i).getLunar().toString())
        }
    }
    func testLunar27() throws {
        let solar: Solar = Solar(fromYmd: 1989, month: 4, day: 28)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.day, 23)
    }
    func testLunar28() throws {
        let solar: Solar = Solar(fromYmd: 1990, month: 10, day: 8)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getMonthInGanZhiExact(), "乙酉")
    }
    func testLunar29() throws {
        let solar: Solar = Solar(fromYmd: 1990, month: 10, day: 9)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getMonthInGanZhiExact(), "丙戌")
    }
    func testLunar30() throws {
        let solar: Solar = Solar(fromYmd: 1990, month: 10, day: 8)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getMonthInGanZhi(), "丙戌")
    }
    func testLunar31() throws {
        let solar: Solar = Solar(fromYmdHms: 1987, month: 4, day: 17, hour: 9, minute: 0, second: 0)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.toString(), "一九八七年三月二十")
        XCTAssertEqual(lunar.getSolar().toYmdHms(), "1987-04-17 09:00:00")
    }
    func testLunar32() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2034, lunarMonth: 1, lunarDay: 1)
        XCTAssertEqual(lunar.getSolar().toYmd(), "2034-02-19")
    }
    func testLunar33() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2033, lunarMonth: 12, lunarDay: 1)
        XCTAssertEqual(lunar.getSolar().toYmd(), "2034-01-20")
    }
    func testLunar34() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 37, lunarMonth: -12, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "闰腊")
    }
    func testLunar35() throws {
        var lunar: Lunar = Lunar(fromYmdHms: 56, lunarMonth: -12, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "闰腊")
        
        lunar = Lunar(fromYmdHms: 75, lunarMonth: -11, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "闰冬")
        
        lunar = Lunar(fromYmdHms: 94, lunarMonth: -11, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "闰冬")
        
        lunar = Lunar(fromYmdHms: 94, lunarMonth: 12, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "腊")
        
        lunar = Lunar(fromYmdHms: 113, lunarMonth: 12, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "腊")
        
        lunar = Lunar(fromYmdHms: 113, lunarMonth: -12, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "闰腊")
        
        lunar = Lunar(fromYmdHms: 5552, lunarMonth: -12, lunarDay: 1)
        XCTAssertEqual(lunar.getMonthInChinese(), "闰腊")
    }
    func testLunar36() throws {
        let solar: Solar = Solar(fromYmd: 5553, month: 1, day: 22)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.toString(), "五五五二年闰腊月初二")
    }
    
    func testLunar37() throws {
        let solar: Solar = Solar(fromYmd: 7013, month: 12, day: 24)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.toString(), "七〇一三年闰冬月初四")
    }
    
    func testLunar38() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 7013, lunarMonth: -11, lunarDay: 4)
        let solar: Solar = lunar.getSolar()
        XCTAssertEqual(solar.toString(), "7013-12-24")
    }
    
    func testLunar39() throws {
        let solar: Solar = Solar(fromYmd: 1987, month: 4, day: 12)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.toString(), "一九八七年三月十五")
    }
    
    func testLunar40() throws {
        let solar: Solar = Solar(fromYmd: 1987, month: 4, day: 13)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.toString(), "一九八七年三月十六")
    }
    
    func testLunar41() throws {
        let solar: Solar = Solar(fromYmd: 4, month: 2, day: 10)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getYearShengXiao(), "鼠")
    }
    
    func testLunar42() throws {
        let solar: Solar = Solar(fromYmd: 4, month: 2, day: 9)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getYearShengXiao(), "猪")
    }
    
    func testLunar43() throws {
        let solar: Solar = Solar(fromYmd: 1, month: 2, day: 12)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getYearShengXiao(), "鸡")
    }
    
    func testLunar44() throws {
        let solar: Solar = Solar(fromYmd: 1, month: 1, day: 1)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getYearShengXiao(), "猴")
    }
    
    func testLunar45() throws {
        let solar: Solar = Solar(fromYmd: 2017, month: 2, day: 15)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getDayLu(), "子命互禄 辛命进禄")
    }
    
    func testLunar57() throws {
        let solar: Solar = Solar(fromYmd: 1991, month: 2, day: 5)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getMonthInGanZhi(), "庚寅")
    }
    
    func testLunar58() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 3, day: 21)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getOtherFestivals(), ["春社"])
    }
    
    func testLunar59() throws {
        let solar: Solar = Solar(fromYmd: 2022, month: 3, day: 16)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getOtherFestivals(), ["春社"])
    }
    
    func testLunar60() throws {
        let solar: Solar = Solar(fromYmd: 1722, month: 9, day: 25)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getOtherFestivals(), ["秋社"])
    }
    
    func testLunar61() throws {
        let solar: Solar = Solar(fromYmd: 840, month: 9, day: 14)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getOtherFestivals(), ["秋社"])
    }
}
