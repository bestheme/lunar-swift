//
//  Taoist.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
@available(iOS 15.0, *)
@available(macOS 12.0, *)
struct Taoist {
    static let BIRTH_YEAR: Int = -2697
    
    /// 阴历
    var lunar: Lunar?
    
    static func fromLunar(lunar: Lunar) -> Taoist{
        return Taoist(lunar: lunar)
    }
    
    static func fromYmdHms(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Taoist {
        return fromLunar(
            lunar: SwiftLunar.Lunar(fromYmdHms: year + BIRTH_YEAR, lunarMonth: month, lunarDay: day, hour: hour, minute: minute, second: second));
    }
    
    static func fromYmd(year: Int, month: Int, day: Int) -> Taoist {
        return fromYmdHms(year: year, month: month, day: day, hour: 0, minute: 0, second: 0);
    }
    
    var year: Int {
        get {
            return lunar!.year - Taoist.BIRTH_YEAR
        }
    }
    
    var month: Int {
        get {
            return lunar!.month
        }
    }
    
    var day: Int {
        get {
            return lunar!.day
        }
    }
    
    var yearInChinese: String {
        get {
            let y: String = Swift.String(year)
            var s: String = ""
            for v in y.utf16 {
                s += LunarUtil.NUMBER[Int(v) - 48]
            }
            return s
        }
    }
    
    var monthInChinese: String {
        get {
            return lunar!.getMonthInChinese()
        }
    }
    
    var dayInChinese: String {
        get {
            lunar!.getDayInChinese()
        }
    }
    
    func getFestivals() -> [TaoistFestival] {
        var l: [TaoistFestival] = [];
        let fs: [TaoistFestival]? = TaoistUtil.FESTIVAL["\(month)-\(day)"]
        if (nil != fs) {
            l.append(contentsOf: fs!)
        }
        let solarTerm: String = lunar!.getJieQi()
        if (solarTerm == "冬至") {
            l.append(TaoistFestival(name: "元始天尊圣诞"))
        } else if (solarTerm == "夏至") {
            l.append(TaoistFestival(name: "灵宝天尊圣诞"))
        }
        // 八节日
        var f: String? = TaoistUtil.BA_JIE[solarTerm]
        if (f != nil) {
            l.append(TaoistFestival(name: f!))
        }
        // 八会日
        f = TaoistUtil.BA_HUI[lunar!.getDayInGanZhi()]
        if (f != nil) {
            l.append(TaoistFestival(name: f!))
        }
        return l;
    }
    
    func isDayIn(days: [String]) -> Bool {
        let md: String = "\(month)-\(day)"
        for day in days {
            if (md == day) {
                return true;
            }
        }
        return false;
    }
    
    var isDaySanHuiL: Bool {
        get {
            return isDayIn(days: TaoistUtil.SAN_HUI)
        }
    }
    
    var isDaySanYuan: Bool {
        get {
            return isDayIn(days: TaoistUtil.SAN_YUAN)
        }
    }
    
    var isDayBaJie: Bool {
        get {
            return TaoistUtil.BA_JIE.keys.contains(lunar!.getJieQi())
        }
    }
    
    var isDayWuLa: Bool {
        get {
            return isDayIn(days: TaoistUtil.WU_LA)

        }
    }
    
    var isDayBaHui: Bool {
        get {
            return TaoistUtil.BA_HUI.keys.contains(lunar!.getDayInGanZhi())
        }
    }
    
    var isDayMingWu:Bool {
        get {
            return "戊" == lunar!.getDayGan()
        }
    }
    
    var isDayAnWu: Bool {
        get {
            return lunar!.getDayZhi() == TaoistUtil.AN_WU[abs(month) - 1]
        }
    }

    var isDayWu: Bool {
        get {
            return isDayMingWu || isDayAnWu
        }
    }

    var isDayTianShe: Bool {
        get {
            var ret: Bool = false;
            let monthRoot: String = lunar!.getMonthZhi()
            let dayColumn: String = lunar!.getDayInGanZhi();
            if ("寅卯辰".contains(monthRoot)) {
                if ("戊寅" == dayColumn) {
                    ret = true;
                }
            } else if ("巳午未".contains(monthRoot)) {
                if ("甲午" == dayColumn) {
                    ret = true;
                }
            } else if ("申酉戌".contains(monthRoot)) {
                if ("戊申" == dayColumn) {
                    ret = true;
                }
            } else if ("亥子丑".contains(monthRoot)) {
                if ("甲子" == dayColumn) {
                    ret = true;
                }
            }
            return ret;
        }
  }

  func toString() -> String {
    return "\(yearInChinese)年\(monthInChinese)月\(dayInChinese)";
  }

  func toFullString() -> String {
    return "道歷\(yearInChinese)年，天運\(lunar!.getYearInGanZhi())年，\(lunar!.getMonthInGanZhi())月，\(lunar!.getDayInGanZhi())日。\(monthInChinese)月\(dayInChinese)日，\(lunar!.getTimeZhi())時。"
  }
}
