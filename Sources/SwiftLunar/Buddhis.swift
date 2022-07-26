//
//  Buddhis.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
// 佛历
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct Buddhis {
    static let DEAD_YEAR: Int = -543;
    
    /// 阴历
    public var lunarOfBuddhis: Lunar;
    
    public init(lunar: Lunar) {
        self.lunarOfBuddhis = lunar
    }
    
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        let y: Int = year + Buddhis.DEAD_YEAR - 1
        self.lunarOfBuddhis = Lunar(fromYmdHms: y, lunarMonth: month, lunarDay: day, hour: hour, minute: minute, second: second)
    }
    
    
    public var year: Int {
        get {
            let sy: Int = lunarOfBuddhis.getSolar().year;
            var y: Int = sy - Buddhis.DEAD_YEAR;
            if (sy == lunarOfBuddhis.year) {
                y += 1;
            }
            return y;
        }
    }
    
    public var month: Int {
        get {
            return lunarOfBuddhis.month
        }
    }
    
    public var day: Int {
        get {
            return lunarOfBuddhis.day
        }
    }
    
    public var yearInChinese: String {
        let y: String = "\(year)"
        var s: String = ""
        for v in y.utf16  {
            s += LunarUtil.NUMBER[Int(v) - 48]
        }
        return s;
    }
    
    public var monthInChinese: String {
        get {
            return lunarOfBuddhis.getMonthInChinese()
        }
    }
    
    public var dayInChinese: String {
        get {
            return lunarOfBuddhis.getDayInChinese()
        }
    }
    
    public var festivals: [BuddhistFestival] {
        var l: [BuddhistFestival] = [];
        let fs: [BuddhistFestival]? = BuddhistUtil.FESTIVAL["\(month)-\(day)"]
        if (nil != fs) {
            l.append(contentsOf: fs!)
        }
        return l;
    }
    
    public var isMonthZhai: Bool {
        get {
            let m: Int = month;
            return 1 == m || 5 == m || 9 == m;
        }
    }
    
    public var isDayYangGong: Bool {
        get {
            for festival in festivals {
                if ("杨公忌" == festival.name) {
                    return true;
                }
            }
            return false
        }
    }
    
    public var isDayZhaiShuoWang: Bool {
        get {
            let d: Int = day
            return 1 == d || 15 == d
        }
    }
    
    public var isDayZhaiSix: Bool {
        get {
            let d: Int = day
            if (8 == d || 14 == d || 15 == d || 23 == d || 29 == d || 30 == d) {
                return true
            } else if (28 == d) {
                let m: LunarMonth? = LunarMonth.fromYm(lunarYear: lunarOfBuddhis.year, lunarMonth: month)!
                return nil != m && 30 != m!.dayCount
            }
            return false;
        }
    }
    
    public var isDayZhaiTen: Bool {
        get {
            let d: Int = day
            return 1 == d ||
            8 == d ||
            14 == d ||
            15 == d ||
            18 == d ||
            23 == d ||
            24 == d ||
            28 == d ||
            29 == d ||
            30 == d
        }
    }
    
    public var isDayZhaiGuanYin: Bool {
        get {
            let k: String = "\(month)-\(day)"
            for d in BuddhistUtil.DAY_ZHAI_GUAN_YIN {
                if (k == d) {
                    return true;
                }
            }
            return false;
        }
    }
    
    var xiu: String {
        get {
            return BuddhistUtil.getXiu(month: month, day: day)
        }
    }
    
    var xiuLuck: String {
        get {
            return LunarUtil.XIU_LUCK[xiu]!
        }
    }
    
    var xiuSong: String {
        get {
            return LunarUtil.XIU_SONG[xiu]!
        }
    }
    
    var zheng: String {
        return LunarUtil.ZHENG[xiu]!
    }
    
    var animal: String {
        get {
            return LunarUtil.ANIMAL[xiu]!
        }
    }
    
    var gong: String {
        get {
            return LunarUtil.GONG[xiu]!
        }
    }
    
    var shou: String {
        get {
            return LunarUtil.SHOU[gong]!
        }
    }
    
    
    func toString() -> String {
        return "\(yearInChinese)年\(monthInChinese)月\(dayInChinese)"
    }
    
    func toFullString() -> String {
        var s: String = toString()
        for festival in festivals {
            s += " ("
            s += festival.toString()
            s += ")"
        }
        return s;
    }
}

