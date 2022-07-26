//
//  Solar.swift
//  
//
//  Created by 睿宁 on 2022/7/11.
//

import Foundation

// 阳历日期

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct Solar {
    static let J2000: Double = 2451545
    
    public var year: Int = 0
    
    public var month: Int = 0
    
    public var day: Int = 0
    
    public var hour: Int = 0
    
    public var minute: Int = 0
    
    public var second:Int = 0
    
    public var isLeapYear: Bool {
        return SolarUtil.isLeapYear(year: self.year)
    }
    
    public var calendar: Date {
        get {
//            let dc = DateComponents(calendar: Calendar(identifier: .gregorian), year: year, month: month, day: day, hour: hour, minute: minute, second: second)
            return ExactDate.fromYmdHms(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        }
        set (date) {
            let setDate: Date = ExactDate.fromDate(date: date)
//            let dateCompment: DateComponents = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            year = setDate.get(.year) //dateCompment.year!
            month = setDate.get(.month)   //dateCompment.month!
            day = calcDay(day: setDate.get(.day))
            hour = setDate.get(.hour) //dateCompment.hour!
            minute = setDate.get(.minute) // dateCompment.minute!
            second = setDate.get(.second) //dateCompment.second!
        }
    }
    
    public var julianDay: Double {
        get {
            var y: Int = year
            var m: Int = month
            let d: Double = Double(day) + ((Double(second) * 1.0 / 60 + Double(minute)) / 60 + Double(hour)) / 24
            var n: Int = 0
            var g: Bool = false
            if (y * 372 + m * 31 + Int(floor(d)) >= 588829) {
                g = true
            }
            if (m <= 2) {
                m += 12
                y -= 1
            }
            if (g) {
                n = Int(floor(Double(y) * 1.0 / 100))
                n = 2 - n + Int(floor(Double(n) * 1.0 / 4))
            }
            return floor(365.25 * (Double(y) + 4716)) +
            floor(30.6001 * (Double(m) + 1)) +
            d +
            Double(n) -
            1524.5
        }
        set (julianDay) {
            var d: Int = Int(floor(julianDay + 0.5))
            var f: Double = julianDay + 0.5 - Double(d)
            var c: Double
            
            if (d >= 2299161) {
                c = floor((Double(d) - 1867216.25) / 36524.25)
                d += Int(1 + c - floor(c * 1.0 / 4))
            }
            d += 1524
            var year: Int = Int(floor((Double(d) - 122.1) / 365.25))
            d -= Int(floor(365.25 * Double(year)))
            var month: Int = Int(floor(Double(d) * 1.0 / 30.601))
            d -= Int(floor(30.601 * Double(month)))
            let day: Int = d
            if (month > 13) {
                month -= 13
                year -= 4715
            } else {
                month -= 1
                year -= 4716
            }
            f *= 24
            var hour: Int = Int(floor(f))
            
            f -= Double(hour)
            f *= 60
            var minute: Int = Int(floor(f))
            
            f -= Double(minute)
            f *= 60
            var second: Int = Int(round(f))
            
            if (second > 59) {
                second -= 60
                minute += 1
            }
            if (minute > 59) {
                minute -= 60
                hour += 1
            }
            
            self.year = Int(year)
            self.month = Int(month)
            self.day = calcDay(day: Int(day))
            self.hour = Int(hour)
            self.minute = Int(minute)
            self.second = Int(second)
        }
    }
    
    public init(fromYmd year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = calcDay(day: day)
    }
    
    public init(fromYmdHms year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        self.year = year
        self.month = month
        self.day = calcDay(day: day)
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    public init() {
        let date: Date = Date()
        self.calendar = date
    }

    public init(fromDate date: Date) {
        self.calendar = date
    }
    
    public init(fromJulianDay julianDay: Double) {
        self.julianDay = julianDay
    }
    
//    init(fromJulianDay julianDay: Double) {
//        var d: Double = (julianDay + 0.5)
//        var f: Double = julianDay + 0.5 - d
//        var c: Double
//
//        if (d >= 2299161) {
//            c = ((d - 1867216.25) / 36524.25)
//          d += 1 + c - (c * 1.0 / 4)
//        }
//        d += 1524
//        var year: Double = ((d - 122.1) / 365.25)
//        d -= (365.25 * year)
//        var month: Double = (d * 1.0 / 30.601)
//        d -= (30.601 * month)
//        var day: Double = d
//        if (month > 13) {
//          month -= 13
//          year -= 4715
//        } else {
//          month -= 1
//          year -= 4716
//        }
//        f *= 24
//        var hour: Double = f
//
//        f -= hour
//        f *= 60
//        var minute: Double = f
//
//        f -= minute
//        f *= 60
//        var second: Double = f
//
//        if (second > 59) {
//          second -= 60
//          minute += 1
//        }
//        if (minute > 59) {
//          minute -= 60
//          hour += 1
//        }
//
//        self.calendar = ExactDate.fromYmdHms(year, month, day, hour, minute, second)
//        self.year = calendar.get(.year)
//        self.month = calendar.get(.month)
//        self.day = calendar.get(.day)
//        self.hour = calendar.get(.hour)
//        self.minute = calendar.get(.minute)
//        self.second = calendar.get(.second)
//      }
    
    //  static List<Solar>? getSolarfromBaZi(
    //      {required String yearGanZhi,
    //      required String monthGanZhi,
    //      required String dayGanZhi,
    //      required String timeGanZhi,
    //      int sect = 2,
    //      int baseYear = 1900,
    //      int endYear = 2100}) {
    //    List<Solar>? l = []
    //    Solar today = Solar.fromDate(DateTime(endYear))
    //    Lunar lunar = today.getLunar()
    //
    //    int offsetYear = LunarUtil.getJiaZiIndex(lunar.getYearInGanZhiExact()) -
    //        LunarUtil.getJiaZiIndex(yearGanZhi)
    //    if (offsetYear < 0) {
    //      offsetYear = offsetYear + 60
    //    }
    //    int startYear = lunar.getYear() - offsetYear
    //    int hour = 0
    //    String timeZhi = timeGanZhi.substring(1)
    //    for (int i = 0, j = LunarUtil.ZHI.length i < j i++) {
    //      if (LunarUtil.ZHI[i] == timeZhi) {
    //        hour = (i - 1) * 2
    //      }
    //    }
    //    while (startYear >= baseYear) {
    //      int year = startYear - 1
    //      int counter = 0
    //      int month = 12
    //      int day
    //      bool found = false
    //      while (counter < 15) {
    //        if (year >= baseYear) {
    //          day = 1
    //          Solar solar = Solar.fromYmdHms(year, month, day, hour, 0, 0)
    //          lunar = solar.getLunar()
    //          if (lunar.getYearInGanZhiExact() == yearGanZhi &&
    //              lunar.getMonthInGanZhiExact() == monthGanZhi) {
    //            found = true
    //            break
    //          }
    //        }
    //        month++
    //        if (month > 12) {
    //          month = 1
    //          year++
    //        }
    //        counter++
    //      }
    //
    //      if (found) {
    //        counter = 0
    //        month--
    //        if (month < 1) {
    //          month = 12
    //          year--
    //        }
    //        day = 1
    //        Solar solar = Solar.fromYmdHms(year, month, day, hour, 0, 0)
    //        while (counter < 61) {
    //          lunar = solar.getLunar()
    //          String dgz = (2 == sect)
    //              ? lunar.getDayInGanZhiExact2()
    //              : lunar.getDayInGanZhiExact()
    //          if (lunar.getYearInGanZhiExact() == yearGanZhi &&
    //              lunar.getMonthInGanZhiExact() == monthGanZhi &&
    //              dgz == dayGanZhi &&
    //              lunar.getTimeInGanZhi() == timeGanZhi) {
    //            l.add(solar)
    //            break
    //          }
    //          solar = solar.next(1)
    //          counter ++
    //        }
    //      }
    //      startYear -= 60
    //    }
    //    return l
    //  }
    
    //  int getYear() => _year //get method
    //
    //  int getMonth() => _month
    //
    //  int getDay() => _day
    //
    //  int getHour() => _hour
    //
    //  int getMinute() => _minute
    //
    //  int getSecond() => _second
    //
    //  DateTime getCalendar() => _calendar!
    
    
    func toString() -> String {
        return toYmd()
    }


//    func isLeapYear() -> Bool {
//        return SolarUtil.isLeapYear(year: year)
//    }
    
    //   获取星期，0代表周日，1代表周一
    //   @return 0123456
    public var week: Int {
        var w: Int = Calendar(identifier: .gregorian).component(.weekday, from: calendar) - 1
        if (w == -1) {
            w = 0
        }
        return w
    }
    
    //   获取星期的中文
    //   @return 日一二三四五六
    public  var weekInChinese: String {
        return SolarUtil.WEEK[week]
    }
    
    /// 获取星座
    /// @return 星座
    public var constellation: String {
        var index: Int = 11
        let y: Int = month * 100 + day
        if (y >= 321 && y <= 419) {
            index = 0
        } else if (y >= 420 && y <= 520) {
            index = 1
        } else if (y >= 521 && y <= 621) {
            index = 2
        } else if (y >= 622 && y <= 722) {
            index = 3
        } else if (y >= 723 && y <= 822) {
            index = 4
        } else if (y >= 823 && y <= 922) {
            index = 5
        } else if (y >= 923 && y <= 1023) {
            index = 6
        } else if (y >= 1024 && y <= 1122) {
            index = 7
        } else if (y >= 1123 && y <= 1221) {
            index = 8
        } else if (y >= 1222 || y <= 119) {
            index = 9
        } else if (y <= 218) {
            index = 10
        }
        return SolarUtil.XING_ZUO[index]
    }
    
    /// 获取儒略日
    /// @return 儒略日
//    func getJulianDay() -> Double{
//        var y: Int = year
//        var m: Int = month
//        var d: Double = day + ((second * 1.0 / 60 + minute) / 60 + hour) / 24
//        var n: Int = 0
//        var g: Bool = false
//        if (y * 372 + m * 31 + d.floor() >= 588829) {
//            g = true
//        }
//        if (m <= 2) {
//            m += 12
//            y -= 1
//        }
//        if (g) {
//            n = (y * 1.0 / 100).floor()
//            n = 2 - n + (n * 1.0 / 4).floor()
//        }
//        return ((365.25 * (y + 4716)).floor()) +
//        ((30.6001 * (m + 1)).floor()) +
//        d +
//        n -
//        1524.5
//    }
    
    /// 获取节日，有可能一天会有多个节日
    /// @return 劳动节等
    public var festivals: [String] {
        var l: [String] = []
        //获取几月几日对应的节日
        var f: String? = SolarUtil.FESTIVAL["\(month)-\(day)"]
        if (nil != f) {
            l.append(f!)
        }
        //计算几月第几个星期几对应的节日
        let weeks: Int = Int(ceil(Double(day) / 7.0))
        //星期几，1代表星期天
//        let week: Int = eek()
        f = SolarUtil.WEEK_FESTIVAL["\(month)-\(weeks)-\(week)"]
        if (nil != f) {
            l.append(f!)
        }
        if (day + 7 > SolarUtil.getDaysOfMonth(year: year, month: month)) {
            f = SolarUtil.WEEK_FESTIVAL["\(month)-0-\(week)"]
            if (nil != f) {
                l.append(f!)
            }
        }
        return l
    }
    
    func calcDay(day: Int) -> Int {
        var newDay: Int = day
        if (year == 1582 && month == 10) {
              if (newDay >= 15) {
                  newDay -= 10
                  return newDay
              }
            }
        return newDay
    }
    /// 获取非正式的节日，有可能一天会有多个节日
    /// @return 非正式的节日列表，如中元节
    public var otherFestivals: [String] {
        var l: [String] = []
        let fs: [String]? = SolarUtil.OTHER_FESTIVAL["\(month)-\(day)"]
        if (nil != fs) {
            l.append(contentsOf: fs!)
        }
        return l
    }
    
    /// 获取往后推几天的阳历日期，如果要往前推，则天数用负数
    /// @param days 天数
    /// @param onlyWorkday 是否仅限工作日
    /// @return 阳历日期
    public func next(days:Int, onlyWorkday: Bool = false) -> Solar {
        var c: Date = calendar
        let timeInterval: TimeInterval =  Double(days * 86400)
        if (0 != days) {
            if (!onlyWorkday) {
                c.addTimeInterval(timeInterval)
            } else {
                var rest: Int = abs(days)
                let add: TimeInterval = days < 1 ? -86400 : 86400
                while (rest > 0) {
                    c.addTimeInterval(add)
                    var work: Bool = true
                    let holiday: Holiday? =
                    HolidayUtil.getHolidayByYmd(year: c.get(.year), month: c.get(.month), day: c.get(.day))
                    if (nil == holiday) {
                        let week: Int = Calendar(identifier: .gregorian).component(.weekday, from: c)
                        if (1 == week || 7 == week) {
                            work = false
                        }
                    } else {
                        work = holiday!.isWork
                    }
                    if (work) {
                        rest-=1
                    }
                }
            }
        }
        return Solar(fromDate: c)
    }
    
    func toYmd() -> String {
        var d: Int = day
        if (year == 1582 && month == 10) {
            if (d >= 5) {
                d += 10
            }
        }
        var y: String = Swift.String(year)
        while (y.count < 4) {
            y = "0" + y
        }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        return dateFormat.string(from: calendar)
//        return calendar.formatted(.dateTime.locale(Locale(identifier: "zh_HK")).year(.defaultDigits).month(.twoDigits).day(.twoDigits))
    }
    
    func toYmdHms() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormat.string(from: calendar)
//        return calendar.formatted(.dateTime.locale(Locale(identifier: "zh_CN")).year(.defaultDigits).month(.twoDigits).day(.twoDigits).hour(.twoDigits(amPM: .narrow)).minute(.twoDigits).second(.twoDigits))
    }
    
    func toHm() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        return dateFormat.string(from: calendar)
//        return calendar.formatted(.dateTime.locale(Locale(identifier: "zh_CN")).hour(.twoDigits(amPM: .narrow)).minute(.twoDigits))
    }
    
    func toFullString() -> String {
        var s: String = toYmdHms()
        if (isLeapYear) {
            s += " 闰年"
        }
        s += " 星期" + weekInChinese
        let festivals: [String] = festivals
        for festival in festivals {
            s += " (\(festival))"
        }
        s += " " + constellation + "座"
        return s
    }
    
    public func getLunar() -> Lunar {
        return Lunar(fromDate: calendar)
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
