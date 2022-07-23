//
//  LunarMonth.swift
//  
//
//  Created by 睿宁 on 2022/7/12.
//

import Foundation

// 农历月

@available(macOS 12.0, *)
struct LunarMonth {
    /// 农历年
    var year: Int = 0
    
    /// 农历月：1-12，闰月为负数，如闰2月为-2
    var month: Int = 0
    
    /// 天数，大月30天，小月29天
    var dayCount: Int = 0
    
    /// 初一的儒略日
    var firstJulianDay: Double = 0
    
    init(year: Int, month: Int, dayCount: Int, firstJulianDay: Double) {
        self.year = year
        self.month = month
        self.dayCount = dayCount
        self.firstJulianDay = firstJulianDay
    }
    
    
    static func fromYm(lunarYear: Int, lunarMonth: Int) -> LunarMonth? {
        return LunarYear.fromYear(lunarYear: lunarYear).getMonth(lunarMonth: lunarMonth)
    }
    
    func getYear() -> Int {
        return year
    }
    
    func getMonth() -> Int {
        return month
    }
    
    func getDayCount() -> Int {
        return dayCount
    }
    
    func getFirstJulianDay() -> Double {
        return  firstJulianDay
    }
    
    func isLeap() -> Bool {
        return month < 0
    }
    
    func getPositionTaiSui() -> String {
        var p: String = ""
        let m: Int = abs(month)
        switch (m) {
        case 1: break
        case 5: break
        case 9:
            p = "艮"
            break
        case 3: break
        case 7: break
        case 11:
            p = "坤"
            break
        case 4: break
        case 8: break
        case 12:
            p = "巽"
            break
        default:
            p = LunarUtil.POSITION_GAN[Solar(fromJulianDay: self.getFirstJulianDay())
                .getLunar()
                .getMonthGanIndex()]
        }
        return p
    }
    
    func getPositionTaiSuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getPositionTaiSui()]!
    }
    
//    func getNineStar() -> NineStar {
//        var index: Int = LunarYear(lunarYear: year).getZhiIndex() % 3
//        var m: Int = abs(month)
//        var monthZhiIndex: Int = (13 + m) % 12
//        var n: Int = 27 - (index * 3)
//        if (monthZhiIndex < LunarUtil.BASE_MONTH_ZHI_INDEX) {
//            n -= 3
//        }
//        var offset: Int = (n - monthZhiIndex) % 9
//        return NineStar.fromIndex(offset)
//    }
    
    func toString() -> String {
        let month: String = LunarUtil.MONTH[abs(month)]
        return "\(year)年\(isLeap() ? "闰" : "")\(month)月(\(dayCount))天"
    }
    
    func next(n: Int) -> LunarMonth{
        if (0 == n) {
            return LunarMonth.fromYm(lunarYear: year, lunarMonth: month)!
        } else if (n > 0) {
            var rest: Int = n
            var ny: Int = year
            var iy: Int = ny
            var im: Int = month
            var index: Int = 0
            var months: [LunarMonth] = LunarYear(lunarYear: ny).getMonths()
            while (true) {
                let size: Int = months.count
                for i in 0..<size {
                    let m: LunarMonth = months[i]
                    if (m.getYear() == iy && m.getMonth() == im) {
                        index = i
                        break
                    }
                }
                let more: Int = size - index - 1
                if (rest < more) {
                    break
                }
                rest -= more
                let lastMonth: LunarMonth = months[size - 1]
                iy = lastMonth.getYear()
                im = lastMonth.getMonth()
                ny += 1
                months = LunarYear(lunarYear: ny).getMonths()
            }
            return months[index + rest]
        } else {
            var rest: Int = -n
            var ny: Int = year
            var iy: Int = ny
            var im: Int = month
            var index: Int = 0
            var months: [LunarMonth] = LunarYear(lunarYear: ny).getMonths()
            while (true) {
                let size: Int = months.count
                for i in 0..<size {
                    let m: LunarMonth = months[i]
                    if (m.getYear() == iy && m.getMonth() == im) {
                        index = i
                        break
                    }
                }
                if (rest <= index) {
                    break
                }
                rest -= index
                let firstMonth: LunarMonth = months[0]
                iy = firstMonth.getYear()
                im = firstMonth.getMonth()
                ny -= 1
                months = LunarYear(lunarYear: ny).getMonths()
            }
            return months[index - rest]
        }
    }
}
