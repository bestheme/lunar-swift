//
//  Yun.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
// 运

import Foundation

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct Yun: Hashable {
    // 性别(1男，0女)
    public var gender: Int = 0
    
    // 起运年数
    public var startYear: Int = 0
    
    // 起运月数
    public var startMonth: Int = 0
    
    // 起运天数
    public var startDay: Int = 0
    
    // 起运小时数
    public var startHour: Int = 0
    
    // 是否顺推
    public var isGoWith: Bool = false
    
    public var genre: Int = 1
    
    // 阴历
    public var lunar: Lunar? {
        didSet {
            let yang = 0 == (lunar?.getYearGanIndexExact())! % 2
            let man = 1 == gender
            isGoWith = (yang && man) || (!yang && !man)
            computeStart(genre: genre)
        }
    }
    
    public init(lunar: Lunar, gender: Int, genre: Int = 1) {
        self.lunar = lunar
        self.gender = gender
        // 阳
        let yang: Bool = 0 == lunar.getYearGanIndexExact() % 2
        // 男
        let man: Bool = 1 == gender
        isGoWith = (yang && man) || (!yang && !man)
        computeStart(genre: genre)
    }
    
    mutating func computeStart(genre: Int) {
        // 上节
        let prev: JieQi = lunar!.getPrevJie()
        // 下节
        let next: JieQi = lunar!.getNextJie()
        // 出生日期
        let current: Solar = lunar!.solar!
        // 阳男阴女顺推，阴男阳女逆推
        let start: Solar = isGoWith ? current : prev.solar!
        let end: Solar = isGoWith ? next.solar! : current
        
        var year: Int
        var month: Int
        var day: Int
        var hour: Int = 0
        
        if (2 == genre) {
            var minutes: Int = Calendar(identifier: .gregorian).dateComponents([.minute], from: start.calendar, to: end.calendar).minute!
            year = Int(floor(Double(minutes) / 4320))
            minutes -= year * 4320
            month = Int(floor(Double(minutes) / 360))
            minutes -= month * 360
            day = Int(floor(Double(minutes) / 12))
            minutes -= day * 12
            hour = minutes * 2
        } else {
            let endTimeZhiIndex: Int = (end.hour == 23)
            ? 11
            : LunarUtil.getTimeZhiIndex(hm: end.toHm())
            let startTimeZhiIndex: Int = (start.hour == 23)
            ? 11
            : LunarUtil.getTimeZhiIndex(hm: start.toHm())
            // 时辰差
            var hourDiff: Int = endTimeZhiIndex - startTimeZhiIndex
            // 天数差
            var dayDiff: Int = ExactDate.getDaysBetween(ay: start.year, am: start.month,
                                                        ad: start.day, by: end.year, bm: end.month, bd: end.day)
            if (hourDiff < 0) {
                hourDiff += 12
                dayDiff -= 1
            }
            let monthDiff: Int = Int(floor(Double(hourDiff) * 10 / 30))
            month = dayDiff * 4 + monthDiff
            day = hourDiff * 10 - monthDiff * 30
            year = Int(floor(Double(month) / 12))
            month = month - year * 12
        }
        startYear = year
        startMonth = month
        startDay = day
        startHour = hour
    }
    
    //  int getGender() => _gender
    //
    //  int getStartYear() => _startYear
    //
    //  int getStartMonth() => _startMonth
    //
    //  int getStartDay() => _startDay
    //
    //  int getStartHour() => _startHour
    //
    //  bool isForward() => _forward
    
    //  Lunar getLunar() => _lunar!
    
    public func getStartSolar() -> Solar {
        let birth: Solar = lunar!.solar!
        var year: Int = birth.year + startYear
        var month: Int = birth.month + startMonth
        if (month > 12) {
            month -= 12
            year += 1
        }
        var day: Int = birth.day + startDay
        var hour: Int = birth.hour + startHour
        if (hour > 24) {
            day += 1
            hour -= 24
        }
        let days: Int = SolarUtil.getDaysOfMonth(year: year, month: month)
        if (day > days) {
            day -= days
            month += 1
            if (month > 12) {
                month -= 12
                year += 1
            }
        }
        return Solar(fromYmdHms: year, month: month, day: day, hour: hour, minute: birth.minute, second: birth.second)
    }
    
    /// 获取10轮大运
    public func getDaYun() -> [DaYun]{
            return getDaYunBy(n: 10)
        }
    
    /// 获取大运
    /// [n] 轮数
    public func getDaYunBy(n: Int) -> [DaYun]{
            var l: [DaYun] = []
            for i in 0..<n {
                l.append(DaYun(yun: self, index: i))
            }
            return l
        }
}
