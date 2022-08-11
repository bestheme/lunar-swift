//
//  SolarWeek.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//

import Foundation

// 阳历周
@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct SolarWeek {
    
    private static let durationOfDay: Int = 86400
    /// 年
    public var year: Int = 0
    
    /// 月
    public var month: Int = 0
    
    /// 日
    public var day: Int = 0
    
    /// 星期几作为一周的开始，1234560分别代表星期一至星期天
    public var start: Int = 0
    
    var index: Int {
        get {
            let c: Date = ExactDate.fromYmd(year: year, month: month, day: 1)
            var firstDayWeek: Int = c.get(.weekday) - 1
            if (7 == firstDayWeek) {
                firstDayWeek = 0;
            }
            var offset: Int = firstDayWeek - start
            if (offset < 0) {
                offset += 7
            }
            return Int(ceil(Double(day + offset) / 7.0))
        }
    }
    
    public init(year: Int, month: Int, day: Int, start: Int) {
        self.year = year
        self.month = month
        self.day = day
        self.start = start
    }
    
    public init(date: Date = Date(), start: Int = 0) {
        self.year = date.get(.year)
        self.month = date.get(.month)
        self.day = date.get(.day)
        self.start = start
    }
    
    public func next(weeks: Int, separateMonth: Bool) -> SolarWeek {
        if (0 == weeks) {
            return SolarWeek(year: year, month: month, day: day, start: start)
        }
        if (separateMonth) {
            var n: Int = weeks
            var c: Date = ExactDate.fromYmd(year: year, month: month, day: day)
            var week: SolarWeek = SolarWeek(date: c, start: start)
            var month: Int = month;
            let plus: Bool = n > 0;
            while (0 != n) {
                c = c.addingTimeInterval(TimeInterval((plus ? 7 : -7) * 86400))
                week = SolarWeek(date: c, start: start);
                var weekMonth: Int = week.month;
                if (month != weekMonth) {
                    let index: Int = week.index
                    if (plus) {
                        if (1 == index) {
                            let firstDay: Solar = week.getFirstDay();
                            week = SolarWeek(year: firstDay.year, month: firstDay.month,
                                             day: firstDay.day, start: start)
                            weekMonth = week.month
                        } else {
                            c = ExactDate.fromYmd(year: week.year, month: week.month, day: 1);
                            week = SolarWeek(date:c, start: start)
                        }
                    } else {
                        let size: Int = SolarUtil.getWeeksOfMonth(year: week.year, month: week.month, start: start)
                        if (size == index) {
                            let firstDay: Solar = week.getFirstDay()
                            let lastDay: Solar = firstDay.next(days: 6)
                            week = SolarWeek(year: lastDay.year, month: lastDay.month,
                                             day: lastDay.day, start: start)
                            weekMonth = week.month;
                        } else {
                            c = ExactDate.fromYmd(year: week.year, month: week.month,
                                                  day: SolarUtil.getDaysOfMonth(year: week.year, month: week.month))
                            week = SolarWeek(date:c, start: start)
                        }
                    }
                    month = weekMonth
                }
                n -= plus ? 1 : -1;
            }
            return week
        } else {
            var c: Date = ExactDate.fromYmd(year: year, month: month, day: day)
            c = c.addingTimeInterval(TimeInterval(weeks * 7 * SolarWeek.durationOfDay))
            return SolarWeek(date:c, start: start)
        }
    }
    
    public func getFirstDay() -> Solar {
        var c: Date = ExactDate.fromYmd(year: year, month: month, day: day);
        var week: Int = c.get(.weekday) - 1
        if (week == -1) {
            week = 0;
        }
        var prev: Int = week - start
        if (prev < 0) {
            prev += 7;
        }
        c = c.addingTimeInterval(TimeInterval(-prev * SolarWeek.durationOfDay))
        return Solar(fromDate: c)
    }
    
    public func getFirstDayInMonth() -> Solar? {
        let days: [Solar] = getDays()
        for day in days  {
            if (month == day.month) {
                return day
            }
        }
        return nil;
    }
    
    public func getDays() -> [Solar] {
        let firstDay: Solar = getFirstDay()
        var l: [Solar] = [];
        l.append(firstDay);
        for i in 1..<7  {
            l.append(firstDay.next(days: i))
        }
        return l
    }
    
    public func getDaysInMonth() -> [Solar] {
        let days: [Solar] = self.getDays()
        var l: [Solar] = []
        for day in days {
            if (month != day.month) {
                continue;
            }
            l.append(day)
        }
        return l;
    }
    
    //  func getIndex() -> Int {
    //      let c: Date = ExactDate.fromYmd(year: year, month: month, day: 1);
    //      var firstDayWeek: Int = c.get(.weekday) - 1
    //    if (7 == firstDayWeek) {
    //      firstDayWeek = 0;
    //    }
    //      var offset: Int = firstDayWeek - start;
    //    if (offset < 0) {
    //      offset += 7
    //    }
    //      return Int(ceil(Double(day + offset) / 7.0))
    //  }
    
    func getIndexInYear() -> Int {
        let c: Date = ExactDate.fromYmd(year: year, month: 1, day: 1);
        var firstDayWeek: Int = c.get(.weekday) - 1
        if (-1 == firstDayWeek) {
            firstDayWeek = 0
        }
        var offset: Int = firstDayWeek - start;
        if (offset < 0) {
            offset += 7
        }
        return Int(ceil(Double(SolarUtil.getDaysInYear(year: year, month: month, day: day) + offset) / 7.0))
        
    }
    
    
    func toString() -> String {
        return "\(year).\(month).\(index)"
    }
    
    func toFullString() -> String {
        return "\(year)年\(month)月第\(index)周"
    }
}
