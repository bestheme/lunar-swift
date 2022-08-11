import Foundation
// 阴历日期

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct Lunar {
    static let JIE_QI_IN_USE: [String] = [
        "DA_XUE",
        "冬至",
        "小寒",
        "大寒",
        "立春",
        "雨水",
        "惊蛰",
        "春分",
        "清明",
        "谷雨",
        "立夏",
        "小满",
        "芒种",
        "夏至",
        "小暑",
        "大暑",
        "立秋",
        "处暑",
        "白露",
        "秋分",
        "寒露",
        "霜降",
        "立冬",
        "小雪",
        "大雪",
        "DONG_ZHI",
        "XIAO_HAN",
        "DA_HAN",
        "LI_CHUN",
        "YU_SHUI",
        "JING_ZHE"
    ]
    
    public var year: Int = 0
    
    public var month: Int = 0
    
    public var day: Int = 0
    
    public var hour: Int = 0
    
    public var minute: Int = 0
    
    public var second: Int = 0
    
    public var timeGanIndex: Int = 0
    public var timeZhiIndex: Int = 0
    public var dayGanIndex: Int = 0
    public var dayZhiIndex: Int = 0
    public var dayGanIndexExact: Int = 0
    public var dayZhiIndexExact: Int = 0
    public var dayGanIndexExact2: Int = 0
    public var dayZhiIndexExact2: Int = 0
    public var monthGanIndex: Int = 0
    public var monthZhiIndex: Int = 0
    public var monthGanIndexExact: Int = 0
    public var monthZhiIndexExact: Int = 0
    public var yearGanIndex: Int = 0
    public var yearZhiIndex: Int = 0
    public var yearGanIndexByLiChun: Int = 0
    public var yearZhiIndexByLiChun: Int = 0
    public var yearGanIndexExact: Int = 0
    public var yearZhiIndexExact: Int = 0
    public var weekIndex: Int = 0
    
    public var solar: Solar? {
        didSet {
            self.weekIndex = solar!.week
        }
    }
    
    //    var timeset: Timeset?
    
    public var jieQi: [String: Solar] = [:]
    //    var jieQi: [String: Solar] {
    //        get {
    //            let lunarYear: LunarYear = LunarYear(lunarYear: year)
    //            let julianDays: [Double] = lunarYear.getJieQiJulianDays()
    //            var jieQi: [String: Solar]
    //            for i in 0..<Lunar.JIE_QI_IN_USE.count {
    //                jieQi[Lunar.JIE_QI_IN_USE[i]] = Solar(fromJulianDay: julianDays[i])
    //            }
    //            return jieQi
    //        }
    //    }
    
    public init(fromYmdHms lunarYear: Int, lunarMonth: Int, lunarDay: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        let y: LunarYear = LunarYear(lunarYear: lunarYear)
        let m: LunarMonth? = y.getMonth(lunarMonth: lunarMonth)
        if (nil == m) {
            print("wrong lunar year \(lunarYear) month \(lunarMonth)") //To-Do
        }
        if (lunarDay < 1) {
            print("lunar day must bigger than 0") //To-Do
        }
        let days: Int = m!.getDayCount()
        if (lunarDay > days) {
            print("only $days days in lunar year $lunarYear month $lunarMonth") //To-Do
        }
        self.year = lunarYear
        self.month = lunarMonth
        self.day = lunarDay
        self.hour = hour
        self.minute = minute
        self.second = second
        let noon: Solar = Solar(fromJulianDay: m!.getFirstJulianDay() + Double(lunarDay) - 1)
        self.solar = Solar(fromYmdHms:
                            noon.year, month: noon.month, day: noon.day, hour: hour, minute: minute, second: second)
        compute(lunarYear: y)
    }
    
    public init(fromDate date: Date) {
        self.solar = Solar(fromDate: date)
        let currentYear = solar!.year
        let currentMonth = solar!.month
        let currentDay = solar!.day
        let ly: LunarYear = LunarYear(lunarYear: currentYear)
        for m in ly.months {
            // 初一
            let firstDay: Solar = Solar(fromJulianDay: m.getFirstJulianDay())
            let days: Int = ExactDate.getDaysBetween(
                ay: firstDay.year,
                am: firstDay.month,
                ad: firstDay.day,
                by: currentYear,
                bm: currentMonth,
                bd: currentDay)
            if (days < m.getDayCount()) {
                self.year = m.getYear()
                self.month = m.getMonth()
                self.day = days + 1
                break
            }
        }
        self.hour = solar!.hour
        self.minute = solar!.minute
        self.second = solar!.second
        compute(lunarYear: ly)
    }
    
    mutating func computeJieQi(lunarYear: LunarYear) { //Move to didset
        let julianDays: [Double] = lunarYear.getJieQiJulianDays()
        for i in 0..<Lunar.JIE_QI_IN_USE.count {
            jieQi[Lunar.JIE_QI_IN_USE[i]] = Solar(fromJulianDay: julianDays[i])
        }
    }
    
    mutating func computeYear() {
        //以正月初一开始
        let offset: Int = year - 4
        self.yearGanIndex = offset % 10
        self.yearZhiIndex = offset % 12
        
        if (yearGanIndex < 0) {
            self.yearGanIndex += 10
        }
        
        if (yearZhiIndex < 0) {
            self.yearZhiIndex += 12
        }
        
        ///以立春作为新一年的开始的干支纪年
        var g: Int = yearGanIndex
        var z: Int = yearZhiIndex
        
        ///精确的干支纪年，以立春交接时刻为准
        var gExact: Int = yearGanIndex
        var zExact: Int = yearZhiIndex
        
        let solarYear: Int = solar!.year
        let solarYmd: String = solar!.toYmd()
        let solarYmdHms: String = solar!.toYmdHms()
        
        ///获取立春的阳历时刻
        var liChun: Solar = jieQi["立春"]!
        if (liChun.year != solarYear) {
            liChun = jieQi["LI_CHUN"]!
        }
        let liChunYmd: String = liChun.toYmd()
        let liChunYmdHms: String = liChun.toYmdHms()
        
        ///阳历和阴历年份相同代表正月初一及以后
        if (year == solarYear) {
            //立春日期判断
            if (solarYmd.compare(liChunYmd).rawValue < 0) {
                g -= 1
                z -= 1
            }
            ///立春交接时刻判断
            if (solarYmdHms.compare(liChunYmdHms).rawValue < 0) {
                gExact -= 1
                zExact -= 1
            }
        } else if (year < solarYear) {
            if (solarYmd.compare(liChunYmd).rawValue >= 0) {
                g += 1
                z += 1
            }
            if (solarYmdHms.compare(liChunYmdHms).rawValue >= 0 ) {
                gExact += 1
                zExact += 1
            }
        }
        
        self.yearGanIndexByLiChun = (g < 0 ? g + 10 : g) % 10
        self.yearZhiIndexByLiChun = (z < 0 ? z + 12 : z) % 12
        
        self.yearGanIndexExact = (gExact < 0 ? gExact + 10 : gExact) % 10
        self.yearZhiIndexExact = (zExact < 0 ? zExact + 12 : zExact) % 12
    }
    
    mutating func computeMonth() {
        var start: Solar?
        var end: Solar
        let ymd: String = solar!.toYmd()
        let time: String = solar!.toYmdHms()
        let size: Int = Lunar.JIE_QI_IN_USE.count
        
        //序号：大雪以前-3，大雪到小寒之间-2，小寒到立春之间-1，立春之后0
        var index: Int = -3
        for i in stride(from: 0, to: size, by: 2) {
            end = jieQi[Lunar.JIE_QI_IN_USE[i]]!
            let symd: String = (nil == start) ? ymd : start!.toYmd()
            if (ymd.compare(symd).rawValue >= 0 && ymd.compare(end.toYmd()).rawValue < 0) {
                break
            }
            start = end
            index += 1
        }
        
        //干偏移值（以立春当天起算）
        var offset: Int = (((yearGanIndexByLiChun + (index < 0 ? 1 : 0)) % 5 + 1) * 2) % 10
        self.monthGanIndex = ((index < 0 ? index + 10 : index) + offset) % 10
        self.monthZhiIndex =
        ((index < 0 ? index + 12 : index) + LunarUtil.BASE_MONTH_ZHI_INDEX) %
        12
        
        start = nil
        index = -3
        for i in stride(from: 0, to: size, by: 2) {
            end = jieQi[Lunar.JIE_QI_IN_USE[i]]!
            let stime: String = nil == start ? time : start!.toYmdHms()
            if (time.compare(stime).rawValue >= 0 && time.compare(end.toYmdHms()).rawValue < 0) {
                break
            }
            start = end
            index += 1
        }
        
        //干偏移值（以立春交接时刻起算）
        offset = (((yearGanIndexExact + (index < 0 ? 1 : 0)) % 5 + 1) * 2) % 10
        self.monthGanIndexExact = ((index < 0 ? index + 10 : index) + offset) % 10
        self.monthZhiIndexExact =
        ((index < 0 ? index + 12 : index) + LunarUtil.BASE_MONTH_ZHI_INDEX) %
        12
    }
    
    mutating func computeDay() {
        let noon: Solar  = Solar(fromYmdHms: solar!.year, month: solar!.month, day: solar!.day, hour: 12, minute: 0, second: 0)
        let offset: Double = floor(noon.julianDay) - 11
        dayGanIndex = Int(offset.truncatingRemainder(dividingBy: 10))
        dayZhiIndex = Int(offset.truncatingRemainder(dividingBy: 12))
        
        var dayGanExact: Int = dayGanIndex
        var dayZhiExact: Int = dayZhiIndex
        
        // 八字流派2，晚子时（夜子/子夜）日柱算当天
        dayGanIndexExact2 = dayGanExact
        dayZhiIndexExact2 = dayZhiExact
        
        // 八字流派1，晚子时（夜子/子夜）日柱算明天
        //              var hm: String = "\(hour < 10 ? "0" : "")\(hour.toString()):\(_minute < 10 ? "0" : "")\(minute.toString())"
        let hm: String = (DateComponents(calendar: Calendar(identifier: .gregorian), hour: hour, minute: minute).date?.formatted(.dateTime.hour(.twoDigits(amPM: .narrow)).minute(.twoDigits)))!
        if (hm.compare("23:00").rawValue >= 0 && hm.compare("23:59").rawValue <= 0) {
            dayGanExact += 1
            if (dayGanExact >= 10) {
                dayGanExact -= 10
            }
            dayZhiExact += 1
            if (dayZhiExact >= 12) {
                dayZhiExact -= 12
            }
        }
        
        dayGanIndexExact = dayGanExact
        dayZhiIndexExact = dayZhiExact
    }
    
    mutating func computeTime() {
        let hm: String = (hour < 10 ? "0" : "") + String(hour) + ":" + (minute < 10 ? "0" : "") + String(minute)
        //        let hm: String = DateComponents(calendar: Calendar(identifier: .gregorian), hour: hour, minute: minute).date!.formatted(.dateTime.hour(.twoDigits(amPM: .narrow)).minute(.twoDigits))
        timeZhiIndex = LunarUtil.getTimeZhiIndex(hm: hm)
        timeGanIndex = (dayGanIndexExact % 5 * 2 + timeZhiIndex) % 10
    }
    
    mutating func computeWeek() { //Move to didset
        weekIndex = solar!.week
    }
    
    mutating func compute(lunarYear: LunarYear) {
        computeJieQi(lunarYear: lunarYear)
        computeYear()
        computeMonth()
        computeDay()
        computeTime()
        computeWeek()
    }
    
    //                int getYear() => _year
    //
    //                int getMonth() => _month
    //
    //                int getDay() => _day
    //
    //                int getHour() => _hour
    //
    //                int getMinute() => _minute
    //
    //                int getSecond() => _second
    
    public func getGan() -> String {
        return getYearGan()
    }
    
    public func getYearGan() -> String {
        return LunarUtil.GAN[yearGanIndex + 1]
    }
    
    public func getYearGanByLiChun() -> String {
        return LunarUtil.GAN[yearGanIndexByLiChun + 1]
    }
    
    public func  getYearGanExact() -> String {
        return LunarUtil.GAN[yearGanIndexExact + 1]
    }
    
    public func getZhi() -> String {
        return getYearZhi()
    }
    
    public func getYearZhi() -> String {
        return  LunarUtil.ZHI[yearZhiIndex + 1]
    }
    
    public func getYearZhiByLiChun() -> String {
        return LunarUtil.ZHI[yearZhiIndexByLiChun + 1]
    }
    
    public func getYearZhiExact() -> String {
        return LunarUtil.ZHI[yearZhiIndexExact + 1]
    }
    
    public func getYearInGanZhi() -> String {
        return "\(getYearGan())\(getYearZhi())"
    }
    
    public func getYearInGanZhiByLiChun() -> String {
        return "\(getYearGanByLiChun())\(getYearZhiByLiChun())"
    }
    
    func getYearInGanZhiExact() -> String {
        return "\(getYearGanExact())\(getYearZhiExact())"
    }
    
    func getMonthInGanZhi() -> String {
        return "\(getMonthGan())\(getMonthZhi())"
    }
    
    func getMonthInGanZhiExact() -> String {
        return "\(getMonthGanExact())\(getMonthZhiExact())"
    }
    
    public func getMonthGan() -> String {
        return LunarUtil.GAN[monthGanIndex + 1]
    }
    
    func getMonthGanExact() -> String {
        return LunarUtil.GAN[monthGanIndexExact + 1]
    }
    
    public func getMonthZhi() -> String {
        return LunarUtil.ZHI[monthZhiIndex + 1]
    }
    
    func getMonthZhiExact() -> String {
        return LunarUtil.ZHI[monthZhiIndexExact + 1]
    }
    
    public func getDayInGanZhi() -> String {
        return "\(getDayGan())\(getDayZhi())"
    }
    
    func getDayInGanZhiExact() -> String {
        return "\(getDayGanExact())\(getDayZhiExact())"
    }
    
    func getDayInGanZhiExact2() -> String {
        return "\(getDayGanExact2())\(getDayZhiExact2())"
    }
    
    public func getDayGan() -> String {
        return LunarUtil.GAN[dayGanIndex + 1]
    }
    
    func getDayGanExact() -> String {
        return LunarUtil.GAN[dayGanIndexExact + 1]
    }
    
    func getDayGanExact2() -> String {
        return LunarUtil.GAN[dayGanIndexExact2 + 1]
    }
    
    public func getDayZhi() -> String {
        return LunarUtil.ZHI[dayZhiIndex + 1]
    }
    
    func getDayZhiExact() -> String {
        return LunarUtil.ZHI[dayZhiIndexExact + 1]
    }
    
    func getDayZhiExact2() -> String { return LunarUtil.ZHI[dayZhiIndexExact2 + 1]
    }
    
    @available(*, deprecated, message: "Use getYearShengXiao() instead")
    public func getShengxiao() -> String {
        return getYearShengXiao()
    }
    
    public func getYearShengXiao() -> String {
        return LunarUtil.SHENGXIAO[yearZhiIndex + 1]
    }
    
    public func getYearShengXiaoByLiChun() -> String {
        return LunarUtil.SHENGXIAO[yearZhiIndexByLiChun + 1]
    }
    
    public func getYearShengXiaoExact() -> String {
        return LunarUtil.SHENGXIAO[yearZhiIndexExact + 1]
    }
    
    public func getMonthShengXiao() -> String { return LunarUtil.SHENGXIAO[monthZhiIndex + 1]
    }
    
    public func getDayShengXiao() -> String { return LunarUtil.SHENGXIAO[dayZhiIndex + 1]
    }
    
    public func getTimeShengXiao() -> String { return LunarUtil.SHENGXIAO[timeZhiIndex + 1]
    }
    
    public func getYearInChinese() -> String {
        let y: String = String(year)
        var s: String = ""
        for v in y.utf16  {
            s += LunarUtil.NUMBER[Int(v) - 48]
        }
        return s
    }
    
    public func getMonthInChinese() -> String {
        return (month < 0 ? "闰" : "") + LunarUtil.MONTH[abs(month)]
    }
    
    public func getDayInChinese() -> String {
        return LunarUtil.DAY[day]
    }
    
    public func getTimeZhi() -> String {
        return LunarUtil.ZHI[timeZhiIndex + 1]
    }
    
    public func  getTimeGan() -> String {
        LunarUtil.GAN[timeGanIndex + 1]
    }
    
    public func getTimeInGanZhi() -> String {
        return "\(getTimeGan())\(getTimeZhi())"
    }
    
    public func getSeason() -> String {
        LunarUtil.SEASON[abs(month)]
    }
    
    private func convertJieQi(SolarTerm name: String) -> String {
        var jq: String = name
        if ("DONG_ZHI" == jq) {
            jq = "冬至"
        } else if ("DA_HAN" == jq) {
            jq = "大寒"
        } else if ("XIAO_HAN" == jq) {
            jq = "小寒"
        } else if ("LI_CHUN" == jq) {
            jq = "立春"
        } else if ("DA_XUE" == jq) {
            jq = "大雪"
        } else if ("YU_SHUI" == jq) {
            jq = "雨水"
        } else if ("JING_ZHE" == jq) {
            jq = "惊蛰"
        }
        return jq
    }
    
    public func getJie() -> String {
        for i in stride(from: 0, to: Lunar.JIE_QI_IN_USE.count, by: 2) {
            let key: String = Lunar.JIE_QI_IN_USE[i]
            let d: Solar? = jieQi[key]
            if (d?.year == solar?.year &&
                d?.month == solar?.month &&
                d?.day == solar?.day) {
                return convertJieQi(SolarTerm: key)
            }
        }
        return ""
    }
    
    public func getQi() -> String {
        for i in stride(from: 1, to: Lunar.JIE_QI_IN_USE.count, by: 2) {
            let key: String = Lunar.JIE_QI_IN_USE[i]
            let d: Solar? = jieQi[key]
            if (d?.year == solar?.year &&
                d?.month == solar?.month &&
                d?.day == solar?.day) {
                return convertJieQi(SolarTerm: key)
            }
        }
        return ""
    }
    
    public func getWeek() -> Int {
        return weekIndex
    }
    
    public func getWeekInChinese() -> String {
        SolarUtil.WEEK[getWeek()]
    }
    
    func getXiu() -> String {
        LunarUtil.XIU["\(getDayZhi())\(getWeek())"]!
    }
    
    func getXiuLuck() -> String {
        LunarUtil.XIU_LUCK[getXiu()]!
    }
    
    func getXiuSong() -> String {
        LunarUtil.XIU_SONG[getXiu()]!
    }
    
    func getZheng() -> String {
        LunarUtil.ZHENG[getXiu()]!
    }
    
    func getAnimal() -> String {
        LunarUtil.ANIMAL[getXiu()]!
    }
    
    func getGong() -> String {
        LunarUtil.GONG[getXiu()]!
    }
    
    func getShou() -> String {
        LunarUtil.SHOU[getGong()]!
    }
    
    public func getFestivals() -> [String] {
        var l: [String] = []
        let f: String? = LunarUtil.FESTIVAL["\(month)-\(day)"]
        if (nil != f) {
            l.append(f!)
        }
        if (abs(month) == 12 && day >= 29 && year != next(days: 1).year) {
            l.append("除夕")
        }
        return l
    }
    
    public func getOtherFestivals() -> [String] {
        var l: [String] = []
        let fs: [String] = LunarUtil.OTHER_FESTIVAL["\(month)-\(day)"] ?? []
        l.append(contentsOf: fs)
        let solarYmd: String = solar!.toYmd()
        if (solarYmd == jieQi["清明"]!.next(days: -1).toYmd()) {
            l.append("寒食节")
        }
        var jq: Solar = jieQi["立春"]!
        var offset: Int = 4 - jq.getLunar().dayGanIndex
        if (offset < 0) {
            offset += 10
        }
        if (solarYmd == jq.next(days: offset + 40).toYmd()) {
            l.append("春社")
        }
        
        jq = jieQi["立秋"]!
        offset = 4 - jq.getLunar().dayGanIndex
        if (offset < 0) {
            offset += 10
        }
        if (solarYmd == jq.next(days: offset + 40).toYmd()) {
            l.append("秋社")
        }
        return l
    }
    
    func getPengZuGan() -> String {
        return LunarUtil.PENGZU_GAN[dayGanIndex + 1]
    }
    
    func getPengZuZhi() -> String {
        return LunarUtil.PENGZU_ZHI[dayZhiIndex + 1]
    }
    
    func getPositionXi() -> String {
        return getDayPositionXi()
    }
    
    func getPositionXiDesc() -> String {
        return getDayPositionXiDesc()
    }
    
    func getPositionYangGui() -> String {
        return getDayPositionYangGui()
    }
    
    func getPositionYangGuiDesc() -> String {
        return getDayPositionYangGuiDesc()
    }
    
    func getPositionYinGui() -> String {
        return getDayPositionYinGui()
    }
    
    func getPositionYinGuiDesc() -> String {
        return getDayPositionYinGuiDesc()
    }
    
    func getPositionFu() -> String {
        return getDayPositionFu()
    }
    
    func getPositionFuDesc() -> String {
        return getDayPositionFuDesc()
    }
    
    func getPositionCai() -> String {
        return getDayPositionCai()
    }
    
    func getPositionCaiDesc() -> String {
        return getDayPositionCaiDesc()
    }
    
    func getDayPositionXi() -> String {
        return LunarUtil.POSITION_XI[dayGanIndex + 1]
    }
    
    func getDayPositionXiDesc() -> String {
        return LunarUtil.POSITION_DESC[getDayPositionXi()]!
    }
    
    func getDayPositionYangGui() -> String {
        LunarUtil.POSITION_YANG_GUI[dayGanIndex + 1]
    }
    
    func getDayPositionYangGuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getDayPositionYangGui()]!
    }
    
    func getDayPositionYinGui() -> String {
        return LunarUtil.POSITION_YIN_GUI[dayGanIndex + 1]
    }
    
    func getDayPositionYinGuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getDayPositionYinGui()]!
    }
    
    func getDayPositionFu(genre: Int = 1) -> String {
        return (genre == 1
                ? LunarUtil.POSITION_FU
                : LunarUtil.POSITION_FU_2)[dayGanIndex + 1]
    }
    
    func getDayPositionFuDesc(genre: Int = 1) -> String {
        return LunarUtil.POSITION_DESC[getDayPositionFu(genre: genre)]!
    }
    
    func getDayPositionCai() -> String {
        return LunarUtil.POSITION_CAI[dayGanIndex + 1]
    }
    
    func getDayPositionCaiDesc() -> String {
        return LunarUtil.POSITION_DESC[getDayPositionCai()]!
    }
    
    func getTimePositionXi() -> String {
        return LunarUtil.POSITION_XI[timeGanIndex + 1]
    }
    
    func getTimePositionXiDesc() -> String {
        return LunarUtil.POSITION_DESC[getTimePositionXi()]!
    }
    
    func getTimePositionYangGui() -> String {
        return LunarUtil.POSITION_YANG_GUI[timeGanIndex + 1]
    }
    
    func getTimePositionYangGuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getTimePositionYangGui()]!
    }
    
    func getTimePositionYinGui() -> String {
        return LunarUtil.POSITION_YIN_GUI[timeGanIndex + 1]
    }
    
    func getTimePositionYinGuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getTimePositionYinGui()]!
    }
    
    func getTimePositionFu(sect: Int = 1) -> String {
        return (1 == sect
                ? LunarUtil.POSITION_FU
                : LunarUtil.POSITION_FU_2)[timeGanIndex + 1]
    }
    
    func getTimePositionFuDesc(sect: Int = 1) -> String {
        return LunarUtil.POSITION_DESC[getTimePositionFu(sect: sect)]!
    }
    
    func getTimePositionCai() -> String {
        return LunarUtil.POSITION_CAI[timeGanIndex + 1]
    }
    
    func getTimePositionCaiDesc() -> String {
        return LunarUtil.POSITION_DESC[getTimePositionCai()]!
    }
    
    func getYearPositionTaiSui(sect: Int = 1) -> String{
        var yearZhiIndexSelector: Int
        switch (sect) {
        case 1:
            yearZhiIndexSelector = yearZhiIndex
            break
        case 3:
            yearZhiIndexSelector = yearZhiIndexExact
            break
        default:
            yearZhiIndexSelector = yearZhiIndexByLiChun
        }
        return LunarUtil.POSITION_TAI_SUI_YEAR[yearZhiIndexSelector]
    }
    
    func getYearPositionTaiSuiDesc(sect: Int = 1) -> String {
        LunarUtil.POSITION_DESC[getYearPositionTaiSui(sect: sect)]!
    }
    
    
    private func getMonthPositionTaiSui(monthZhiIndex: Int, monthGanIndex: Int) -> String {
        var p: String = ""
        var m: Int = monthZhiIndex - LunarUtil.BASE_MONTH_ZHI_INDEX
        if (m < 0) {
            m += 12
        }
        switch (m) {
        case 0: break
        case 4: break
        case 8:
            p = "艮"
            break
        case 2: break
        case 6: break
        case 10:
            p = "坤"
            break
        case 3: break
        case 7: break
        case 11:
            p = "巽"
            break
        default:
            p = LunarUtil.POSITION_GAN[monthGanIndex]
        }
        return p
    }
    
    func getMonthPositionTaiSui(geren: Int = 1) -> String {
        var monthZhiIndexSelector: Int
        var monthGanIndexSelector: Int
        switch (geren) {
        case 3:
            monthZhiIndexSelector = monthZhiIndexExact
            monthGanIndexSelector = monthGanIndexExact
            break
        default:
            monthZhiIndexSelector = monthZhiIndex
            monthGanIndexSelector = monthGanIndex
        }
        return getMonthPositionTaiSui(monthZhiIndex: monthZhiIndexSelector, monthGanIndex: monthGanIndexSelector)
    }
    
    func getMonthPositionTaiSuiDesc(geren: Int = 1) -> String {
        LunarUtil.POSITION_DESC[getMonthPositionTaiSui(geren: geren)]!
    }
    
    private func getDayPositionTaiSui(dayInGanZhi: String, yearZhiIndex: Int) -> String {
        var p: String
        if ("甲子,乙丑,丙寅,丁卯,戊辰,已巳".contains(dayInGanZhi)) {
            p = "震"
        } else if ("丙子,丁丑,戊寅,已卯,庚辰,辛巳".contains(dayInGanZhi)) {
            p = "离"
        } else if ("戊子,已丑,庚寅,辛卯,壬辰,癸巳".contains(dayInGanZhi)) {
            p = "中"
        } else if ("庚子,辛丑,壬寅,癸卯,甲辰,乙巳".contains(dayInGanZhi)) {
            p = "兑"
        } else if ("壬子,癸丑,甲寅,乙卯,丙辰,丁巳".contains(dayInGanZhi)) {
            p = "坎"
        } else {
            p = LunarUtil.POSITION_TAI_SUI_YEAR[yearZhiIndex]
        }
        return p
    }
    
    func getDayPositionTaiSui(sect: Int = 1) -> String {
        var dayInGanZhiSelector: String
        var yearZhiIndexSelector: Int
        switch (sect) {
        case 1:
            dayInGanZhiSelector = getDayInGanZhi()
            yearZhiIndexSelector = yearZhiIndex
            break
        case 3:
            dayInGanZhiSelector = getDayInGanZhi()
            yearZhiIndexSelector = yearZhiIndexExact
            break
        default:
            dayInGanZhiSelector = getDayInGanZhiExact2()
            yearZhiIndexSelector = yearZhiIndexByLiChun
        }
        return getDayPositionTaiSui(dayInGanZhi: dayInGanZhiSelector, yearZhiIndex: yearZhiIndexSelector)
    }
    
    func getDayPositionTaiSuiDesc(sect: Int = 2) -> String {
        return LunarUtil.POSITION_DESC[getDayPositionTaiSui(sect: sect)]!
    }
    
    @available(*, deprecated, message: "Use getDayChong() instead")
    func getChong() -> String {
        return getDayChong()
    }
    
    @available(*, deprecated, message: "Use getDayChongGan() instead")
    func getChongGan() -> String {
        return getDayChongGan()
    }
    
    @available(*, deprecated, message: "Use getDayChongGanTie() instead")
    func getChongGanTie() -> String {
        return getDayChongGanTie()
    }
    
    @available(*, deprecated, message: "Use getDayChongShengXiao() instead")
    func getChongShengXiao() -> String {
        return getDayChongShengXiao()
    }
    
    @available(*, deprecated, message: "Use getDayChongDesc() instead")
    func getChongDesc() -> String {
        return getDayChongDesc()
    }
    
    @available(*, deprecated, message: "Use getDaySha() instead")
    func getSha() -> String {
        return getDaySha()
    }
    
    func getYearNaYin() -> String {
        return LunarUtil.NAYIN[getYearInGanZhi()]!
    }
    
    func getMonthNaYin() -> String {
        return LunarUtil.NAYIN[getMonthInGanZhi()]!
    }
    
    func getDayNaYin() -> String {
        return LunarUtil.NAYIN[getDayInGanZhi()]!
    }
    
    func getTimeNaYin() -> String {
        return LunarUtil.NAYIN[getTimeInGanZhi()]!
    }
    
    func getBaZi() -> [String] {
        var l: [String] = []
        let timeset: Timeset = getTimeset()
        l.append(timeset.getYear())
        l.append(timeset.getMonth())
        l.append(timeset.getDay())
        l.append(timeset.getTime())
        return l
    }
    
    func getBaZiWuXing() -> [String] {
        var l: [String] = []
        let timeset: Timeset = getTimeset()
        l.append(timeset.getYearWuXing())
        l.append(timeset.getMonthWuXing())
        l.append(timeset.getDayWuXing())
        l.append(timeset.getTimeWuXing())
        return l
    }
    
    func getBaZiNaYin() -> [String] {
        var l: [String] = []
        let timeset: Timeset = getTimeset()
        l.append(timeset.getYearNaYin())
        l.append(timeset.getMonthNaYin())
        l.append(timeset.getDayNaYin())
        l.append(timeset.getTimeNaYin())
        return l
    }
    
    func  getBaZiShiShenGan() -> [String]{
        var l: [String] = []
        let timeset: Timeset = getTimeset()
        l.append(timeset.getYearShiShenGan())
        l.append(timeset.getMonthShiShenGan())
        l.append(timeset.getDayShiShenGan())
        l.append(timeset.getTimeShiShenGan())
        return l
    }
    
    func getBaZiShiShenZhi() ->[String] {
        var l: [String] = []
        let timeset: Timeset = getTimeset()
        l.append(timeset.getYearShiShenZhi()[0])
        l.append(timeset.getMonthShiShenZhi()[0])
        l.append(timeset.getDayShiShenZhi()[0])
        l.append(timeset.getTimeShiShenZhi()[0])
        return l
    }
    
    func getBaZiShiShenYearZhi() -> [String] {
        return getTimeset().getYearShiShenZhi()
    }
    
    func getBaZiShiShenMonthZhi() -> [String] {
        return getTimeset().getMonthShiShenZhi()
    }
    
    func getBaZiShiShenDayZhi() -> [String] {
        return getTimeset().getDayShiShenZhi()
    }
    
    func getBaZiShiShenTimeZhi() -> [String] {
        return getTimeset().getTimeShiShenZhi()
    }
    
    func getZhiXing() -> String{
        var offset: Int = dayZhiIndex - monthZhiIndex
        if (offset < 0) {
            offset += 12
        }
        return LunarUtil.ZHI_XING[offset + 1]
    }
    
    func getDayTianShen() -> String {
        let monthZhi: String = getMonthZhi()
        let offset: Int = LunarUtil.ZHI_TIAN_SHEN_OFFSET[monthZhi]!
        return LunarUtil.TIAN_SHEN[(dayZhiIndex + offset) % 12 + 1]
    }
    
    func getTimeTianShen() -> String {
        let dayZhi: String = getDayZhiExact()
        let offset: Int = LunarUtil.ZHI_TIAN_SHEN_OFFSET[dayZhi]!
        return LunarUtil.TIAN_SHEN[(timeZhiIndex + offset) % 12 + 1]
    }
    
    func getDayTianShenType() -> String {
        return LunarUtil.TIAN_SHEN_TYPE[getDayTianShen()]!
    }
    
    func getTimeTianShenType() -> String {
        return LunarUtil.TIAN_SHEN_TYPE[getTimeTianShen()]!
    }
    
    func getDayTianShenLuck() -> String {
        return LunarUtil.TIAN_SHEN_TYPE_LUCK[getDayTianShenType()]!
    }
    
    func getTimeTianShenLuck() -> String {
        return LunarUtil.TIAN_SHEN_TYPE_LUCK[getTimeTianShenType()]!
    }
    
    func getDayPositionTai() -> String {
        return LunarUtil.POSITION_TAI_DAY[LunarUtil.getJiaZiIndex(ganZhi: getDayInGanZhi())]
    }
    
    func getMonthPositionTai() -> String {
        return month < 0 ? "" : LunarUtil.POSITION_TAI_MONTH[month - 1]
    }
    
    func getDayYi() -> [String] {
        return LunarUtil.getDayYi(monthGanZhi: getMonthInGanZhiExact(), dayGanZhi: getDayInGanZhi())
    }
    
    func getDayJi() -> [String] {
        return LunarUtil.getDayJi(monthGanZhi: getMonthInGanZhiExact(), dayGanZhi: getDayInGanZhi())
    }
    
    func getDayJiShen() -> [String] {
        return LunarUtil.getDayJiShen(lunarMonth: String(month), dayGanZhi: getDayInGanZhi())
    }
    
    func getDayXiongSha() -> [String] {
        return LunarUtil.getDayXiongSha(lunarMonth: month, dayGanZhi: getDayInGanZhi())
    }
    
    func getDayChong() -> String {
        return LunarUtil.CHONG[dayZhiIndex]
    }
    
    func getDaySha() -> String {
        return LunarUtil.SHA[getDayZhi()]!
    }
    
    func getDayChongDesc() -> String {
        return "(\(getDayChongGan())\(getDayChong()))\(getDayChongShengXiao())"
    }
    
    func getDayChongShengXiao() -> String {
        let chong: String = getDayChong()
        for i in 0..<LunarUtil.ZHI.count  {
            if (LunarUtil.ZHI[i] == chong) {
                return LunarUtil.SHENGXIAO[i]
            }
        }
        return ""
    }
    
    func getDayChongGan() -> String {
        return LunarUtil.CHONG_GAN[dayGanIndex]
    }
    
    func getDayChongGanTie() -> String {
        return LunarUtil.CHONG_GAN_TIE[dayGanIndex]
    }
    
    func getTimeChong() -> String {
        return LunarUtil.CHONG[timeZhiIndex]
    }
    
    func getTimeSha() -> String {
        return LunarUtil.SHA[getTimeZhi()]!
    }
    
    func getTimeChongShengXiao() -> String {
        let chong: String = getTimeChong()
        for i in 0..<LunarUtil.ZHI.count {
            if (LunarUtil.ZHI[i] == chong) {
                return LunarUtil.SHENGXIAO[i]
            }
        }
        return ""
    }
    
    func getTimeChongDesc() -> String {
        return "(\(getTimeChongGan())\(getTimeChong()))\(getTimeChongShengXiao())"
    }
    
    func getTimeChongGan() -> String {
        return LunarUtil.CHONG_GAN[timeGanIndex]
    }
    
    func getTimeChongGanTie() -> String {
        return LunarUtil.CHONG_GAN_TIE[timeGanIndex]
    }
    
    func getTimeYi() -> [String] {
        return LunarUtil.getTimeYi(dayGanZhi: getDayInGanZhiExact(), timeGanZhi: getTimeInGanZhi())
    }
    
    func getTimeJi() -> [String] {
        return LunarUtil.getTimeJi(dayGanZhi: getDayInGanZhiExact(), timeGanZhi: getTimeInGanZhi())
    }
    
    func getYueXiang() -> String {
        return LunarUtil.YUE_XIANG[day]
    }
    
    private func getYearNineStar(yearInGanZhi: String) -> NineStar {
        let index: Int = LunarUtil.getJiaZiIndex(ganZhi: yearInGanZhi) + 1
        var yearOffset: Int = 0
        if (index != LunarUtil.getJiaZiIndex(ganZhi: self.getYearInGanZhi()) + 1) {
            yearOffset = -1
        }
        let yuan: Int = ((year + yearOffset + 2696) / 60) % 3
        var offset: Int = (62 + yuan * 3 - index) % 9
        if (0 == offset) {
            offset = 9
        }
        return NineStar(index: offset - 1)
    }
    
    func getYearNineStar(geren: Int = 2) -> NineStar {
        var yearInGanZhi: String
        switch (geren) {
        case 1:
            yearInGanZhi = self.getYearInGanZhi()
            break
        case 3:
            yearInGanZhi = self.getYearInGanZhiExact()
            break
        default:
            yearInGanZhi = self.getYearInGanZhiByLiChun()
        }
        return getYearNineStar(yearInGanZhi: yearInGanZhi)
    }
    
    private func getMonthNineStar(yearZhiIndex: Int, monthZhiIndex: Int) -> NineStar {
        let index: Int = yearZhiIndex % 3
        var n: Int = 27 - (index * 3)
        if (monthZhiIndex < LunarUtil.BASE_MONTH_ZHI_INDEX) {
            n -= 3
        }
        let offset: Int = (n - monthZhiIndex) % 9
        return NineStar(index: offset)
    }
    
    func getMonthNineStar(geren: Int = 1) -> NineStar {
        var yearZhiIndexSelector: Int
        var monthZhiIndexSelector: Int
        switch (geren) {
        case 1:
            yearZhiIndexSelector = yearZhiIndex
            monthZhiIndexSelector = monthZhiIndex
            break
        case 3:
            yearZhiIndexSelector = yearZhiIndexExact
            monthZhiIndexSelector = monthZhiIndexExact
            break
        default:
            yearZhiIndexSelector = yearZhiIndexByLiChun
            monthZhiIndexSelector = monthZhiIndex
        }
        return getMonthNineStar(yearZhiIndex: yearZhiIndexSelector, monthZhiIndex: monthZhiIndexSelector)
    }
    
    func getDayNineStar() -> NineStar {
        let solarYmd: String = solar!.toYmd()
        let dongZhi: Solar = jieQi["冬至"]!
        let dongZhi2: Solar = jieQi["DONG_ZHI"]!
        let xiaZhi: Solar = jieQi["夏至"]!
        let dongZhiIndex: Int =
        LunarUtil.getJiaZiIndex(ganZhi: dongZhi.getLunar().getDayInGanZhi())
        let dongZhiIndex2: Int =
        LunarUtil.getJiaZiIndex(ganZhi: dongZhi2.getLunar().getDayInGanZhi())
        let xiaZhiIndex: Int =
        LunarUtil.getJiaZiIndex(ganZhi: xiaZhi.getLunar().getDayInGanZhi())
        var solarShunBai: Solar
        var solarShunBai2: Solar
        var solarNiZi: Solar
        if (dongZhiIndex > 29) {
            solarShunBai = dongZhi.next(days: 60 - dongZhiIndex)
        } else {
            solarShunBai = dongZhi.next(days: -dongZhiIndex)
        }
        let solarShunBaiYmd: String = solarShunBai.toYmd()
        if (dongZhiIndex2 > 29) {
            solarShunBai2 = dongZhi2.next(days: 60 - dongZhiIndex2)
        } else {
            solarShunBai2 = dongZhi2.next(days: -dongZhiIndex2)
        }
        let solarShunBaiYmd2: String = solarShunBai2.toYmd()
        if (xiaZhiIndex > 29) {
            solarNiZi = xiaZhi.next(days: 60 - xiaZhiIndex)
        } else {
            solarNiZi = xiaZhi.next(days: -xiaZhiIndex)
        }
        let solarNiZiYmd: String = solarNiZi.toYmd()
        var offset: Int = 0
        if (solarYmd.compare(solarShunBaiYmd).rawValue >= 0 &&
            solarYmd.compare(solarNiZiYmd).rawValue < 0) {
            offset = ExactDate.getDaysBetweenDate(
                startDate: solarShunBai.calendar, endDate: self.getSolar().calendar) %
            9
        } else if (solarYmd.compare(solarNiZiYmd).rawValue >= 0 &&
                   solarYmd.compare(solarShunBaiYmd2).rawValue < 0) {
            offset = 8 -
            (ExactDate.getDaysBetweenDate(
                startDate: solarNiZi.calendar, endDate: self.getSolar().calendar) %
             9)
        } else if (solarYmd.compare(solarShunBaiYmd2).rawValue >= 0) {
            offset = ExactDate.getDaysBetweenDate(
                startDate: solarShunBai2.calendar, endDate: self.getSolar().calendar) %
            9
        } else if (solarYmd.compare(solarShunBaiYmd).rawValue < 0) {
            offset = (8 +
                      ExactDate.getDaysBetweenDate(
                        startDate: self.getSolar().calendar, endDate: solarShunBai.calendar)) %
            9
        }
        return NineStar(index: offset)
    }
    
    func getTimeNineStar() -> NineStar {
        //顺逆
        let solarYmd: String = solar!.toYmd()
        var asc: Bool = false
        if (solarYmd.compare(jieQi["冬至"]!.toYmd()).rawValue >= 0 &&
            solarYmd.compare(jieQi["夏至"]!.toYmd()).rawValue < 0) {
            asc = true
        } else if (solarYmd.compare(jieQi["DONG_ZHI"]!.toYmd()).rawValue >= 0) {
            asc = true
        }
        var start: Int = asc ? 6 : 2
        let dayZhi: String = getDayZhi()
        if ("子午卯酉".contains(dayZhi)) {
            start = asc ? 0 : 8
        } else if ("辰戌丑未".contains(dayZhi)) {
            start = asc ? 3 : 5
        }
        let index: Int = asc ? (start + timeZhiIndex) : (start + 9 - timeZhiIndex)
        return NineStar(index: index % 9)
    }
    
    func getJieQiTable() -> [String: Solar] {
        return jieQi
    }
    
    func getNextJie(wholeDay: Bool = false) -> JieQi {
        let l: Int = (Lunar.JIE_QI_IN_USE.count / 2)
        var conditions: [String] = []
        for i in 0..<l {
            conditions.append(Lunar.JIE_QI_IN_USE[i * 2])
        }
        return getNearJieQi(isGoWith: true, conditions: conditions, wholeDay: wholeDay)!
    }
    
    func getPrevJie(wholeDay: Bool = false) -> JieQi {
        let l: Int = Int(Lunar.JIE_QI_IN_USE.count / 2)
        var conditions: [String] = []
        for i in 0..<l {
            conditions.append(Lunar.JIE_QI_IN_USE[i * 2])
        }
        return getNearJieQi(isGoWith: false, conditions: conditions, wholeDay: wholeDay)!
    }
    
    func getNextQi(wholeDay: Bool = false) -> JieQi {
        let l: Int = Int(floor(Double(Lunar.JIE_QI_IN_USE.count) / 2))
        var conditions: [String] = []
        for i in 0..<l {
            conditions.append(Lunar.JIE_QI_IN_USE[i * 2 + 1])
        }
        return getNearJieQi(isGoWith: true, conditions: conditions, wholeDay: wholeDay)!
    }
    
    func getPrevQi(wholeDay: Bool = false) -> JieQi {
        let l: Int = Int(floor(Double(Lunar.JIE_QI_IN_USE.count) / 2))
        var conditions: [String] = []
        for i in 0..<l {
            conditions.append(Lunar.JIE_QI_IN_USE[i * 2 + 1])
        }
        return getNearJieQi(isGoWith: false, conditions: conditions, wholeDay: wholeDay)!
    }
    
    func getNextJieQi(bool wholeDay: Bool = false) -> JieQi {
        return getNearJieQi(isGoWith: true, conditions: nil, wholeDay: wholeDay)!
    }
    
    func getPrevJieQi(wholeDay: Bool = false) -> JieQi {
        return getNearJieQi(isGoWith: false, conditions: nil, wholeDay: wholeDay)!
    }
    
    func getNearJieQi(isGoWith: Bool, conditions: [String]?, wholeDay: Bool) -> JieQi? {
        var name: String?
        var near: Solar?
        var filters: [String] = []
        if (nil != conditions) {
            filters.append(contentsOf: conditions!)
        }
        let filter: Bool = !filters.isEmpty
        let today: String = wholeDay ? solar!.toYmd() : solar!.toYmdHms()
        for entry in jieQi {
            let jq: String = convertJieQi(SolarTerm: entry.key)
            if (filter) {
                if (!filters.contains(jq)) {
                    continue
                }
            }
            let solar: Solar = entry.value
            let day: String = wholeDay ? solar.toYmd() : solar.toYmdHms()
            if (isGoWith) {
                if (day.compare(today).rawValue < 0) {
                    continue
                }
                if (nil == near) {
                    name = jq
                    near = solar
                } else {
                    let nearDay: String = wholeDay ? near!.toYmd() : near!.toYmdHms()
                    if (day.compare(nearDay).rawValue < 0) {
                        name = jq
                        near = solar
                    }
                }
            } else {
                if (day.compare(today).rawValue > 0) {
                    continue
                }
                if (nil == near) {
                    name = jq
                    near = solar
                } else {
                    let nearDay: String = wholeDay ? near!.toYmd() : near!.toYmdHms()
                    if (day.compare(nearDay).rawValue > 0) {
                        name = jq
                        near = solar
                    }
                }
            }
        }
        if (nil == near) {
            return nil
        }
        return JieQi(name: name!, solar: near!)
    }
    
    func getJieQi() -> String {
        for  jq in jieQi {
            let d: Solar = jq.value
            if (d.year == solar!.year &&
                d.month == solar!.month &&
                d.day == solar!.day) {
                return convertJieQi(SolarTerm: jq.key)
            }
        }
        return ""
    }
    
    var currentJieQi: JieQi? {
        get {
            for jq in jieQi {
                let d: Solar = jq.value
                if (d.year == solar!.year &&
                    d.month == solar!.month &&
                    d.day == solar!.day) {
                    return JieQi(name: convertJieQi(SolarTerm: jq.key), solar: d)
                }
            }
            return nil
        }
    }
    
    var currentJie: JieQi? {
        get {
            for i in stride(from: 0, to: Lunar.JIE_QI_IN_USE.count, by: 2) {
                let key: String = Lunar.JIE_QI_IN_USE[i]
                let d: Solar? = jieQi[key]
                if (d!.year == solar!.year &&
                    d!.month == solar!.month &&
                    d!.day == solar!.day) {
                    return JieQi(name: convertJieQi(SolarTerm: key), solar: d!)
                }
            }
            return nil
        }
    }
    
    var currentQi: JieQi? {
        for i in stride(from: 1, to: Lunar.JIE_QI_IN_USE.count, by: 2) {
            let key: String = Lunar.JIE_QI_IN_USE[i]
            let d: Solar? = jieQi[key]
            if (d!.year == solar!.year &&
                d!.month == solar!.month &&
                d!.day == solar!.day) {
                return JieQi(name: convertJieQi(SolarTerm: key), solar: d!)
            }
        }
        return nil
    }
    
    func toFullString() -> String {
        var s: String = ""
        s += toString()
        s += " "
        s += getYearInGanZhi()
        s += "("
        s += getYearShengXiao()
        s += ")年 "
        s += getMonthInGanZhi()
        s += "("
        s += getMonthShengXiao()
        s += ")月 "
        s += getDayInGanZhi()
        s += "("
        s += getDayShengXiao()
        s += ")日 "
        s += getTimeZhi()
        s += "("
        s += getTimeShengXiao()
        s += ")时 纳音["
        s += getYearNaYin()
        s += " "
        s += getMonthNaYin()
        s += " "
        s += getDayNaYin()
        s += " "
        s += getTimeNaYin()
        s += "] 星期"
        s += getWeekInChinese()
        for f in getFestivals() {
            s += " ("
            s += f
            s += ")"
        }
        for f in getOtherFestivals() {
            s += " ("
            s += f
            s += ")"
        }
        let jq: String = getJieQi()
        if (jq.count > 0) {
            s += " ["
            s += jq
            s += "]"
        }
        s += " "
        s += getGong()
        s += "方"
        s += getShou()
        s += " 星宿["
        s += getXiu()
        s += getZheng()
        s += getAnimal()
        s += "]("
        s += getXiuLuck()
        s += ") 彭祖百忌["
        s += getPengZuGan()
        s += " "
        s += getPengZuZhi()
        s += "] 喜神方位["
        s += getDayPositionXi()
        s += "]("
        s += getDayPositionXiDesc()
        s += ") 阳贵神方位["
        s += getDayPositionYangGui()
        s += "]("
        s += getDayPositionYangGuiDesc()
        s += ") 阴贵神方位["
        s += getDayPositionYinGui()
        s += "]("
        s += getDayPositionYinGuiDesc()
        s += ") 福神方位["
        s += getDayPositionFu(genre: 2)
        s += "]("
        s += getDayPositionFuDesc(genre: 2)
        s += ") 财神方位["
        s += getDayPositionCai()
        s += "]("
        s += getDayPositionCaiDesc()
        s += ") 冲["
        s += getDayChongDesc()
        s += "] 煞["
        s += getDaySha()
        s += "]"
        return s
    }
    
    func toString() -> String {
        return "\(getYearInChinese())年\(getMonthInChinese())月\(getDayInChinese())"
    }
    
    func getTimeGanIndex() -> Int {
        return timeGanIndex
    }
    
    func getTimeZhiIndex() -> Int {
        return timeZhiIndex
    }
    
    func getDayGanIndex() -> Int {
        return dayGanIndex
    }
    
    func getDayZhiIndex() -> Int {
        return dayZhiIndex
    }
    
    func getMonthGanIndex() -> Int {
        return monthGanIndex
    }
    
    func getMonthZhiIndex() -> Int {
        return monthZhiIndex
    }
    
    func getYearGanIndex() -> Int {
        return yearGanIndex
    }
    
    func getYearZhiIndex() -> Int {
        return yearZhiIndex
    }
    
    func getYearGanIndexByLiChun() -> Int {
        return yearGanIndexByLiChun
    }
    
    func getYearZhiIndexByLiChun() -> Int {
        return yearZhiIndexByLiChun
    }
    
    func getDayGanIndexExact() -> Int {
        return dayGanIndexExact
    }
    
    func getDayGanIndexExact2() -> Int {
        return dayGanIndexExact2
    }
    
    func getDayZhiIndexExact() -> Int {
        return dayZhiIndexExact
    }
    
    func getDayZhiIndexExact2() -> Int {
        return dayZhiIndexExact2
    }
    
    func getMonthGanIndexExact() -> Int {
        return monthGanIndexExact
    }
    
    func getMonthZhiIndexExact() -> Int {
        return monthZhiIndexExact
    }
    
    func getYearGanIndexExact() -> Int {
        return yearGanIndexExact
    }
    
    func getYearZhiIndexExact() -> Int {
        return yearZhiIndexExact
    }
    
    public func getSolar() -> Solar {
        return solar!
    }
    
    public func getTimeset() -> Timeset{
        return Timeset(lunar: self)
    }
    
    public func next(days: Int) -> Lunar {
        return solar!.next(days: days).getLunar()
    }
    
    public func getYearXun() -> String {
        return LunarUtil.getXun(ganZhi: getYearInGanZhi())
    }
    
    public func getYearXunByLiChun() -> String {
        return LunarUtil.getXun(ganZhi: getYearInGanZhiByLiChun())
    }
    
    func getYearXunExact() -> String {
        return LunarUtil.getXun(ganZhi: getYearInGanZhiExact())
    }
    
    public func getYearXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getYearInGanZhi())
    }
    
    public func getYearXunKongByLiChun() -> String {
        return LunarUtil.getXunKong(ganZhi: getYearInGanZhiByLiChun())
    }
    
    func getYearXunKongExact() -> String {
        return LunarUtil.getXunKong(ganZhi: getYearInGanZhiExact())
    }
    
    public func getMonthXun() -> String {
        return LunarUtil.getXun(ganZhi: getMonthInGanZhi())
    }
    
    func getMonthXunExact() -> String {
        return LunarUtil.getXun(ganZhi: getMonthInGanZhiExact())
    }
    
    public func getMonthXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getMonthInGanZhi())
    }
    
    func getMonthXunKongExact() -> String {
        return LunarUtil.getXunKong(ganZhi: getMonthInGanZhiExact())
    }
    
    public func getDayXun() -> String {
        return LunarUtil.getXun(ganZhi: getDayInGanZhi())
    }
    
    func getDayXunExact() -> String {
        return LunarUtil.getXun(ganZhi: getDayInGanZhiExact())
    }
    
    func getDayXunExact2() -> String {
        return LunarUtil.getXun(ganZhi: getDayInGanZhiExact2())
    }
    
    public func getDayXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getDayInGanZhi())
    }
    
    func getDayXunKongExact() -> String {
        return LunarUtil.getXunKong(ganZhi: getDayInGanZhiExact())
    }
    
    func getDayXunKongExact2() -> String {
        return LunarUtil.getXunKong(ganZhi: getDayInGanZhiExact2())
    }
    
    public func getTimeXun() -> String {
        return LunarUtil.getXun(ganZhi: getTimeInGanZhi())
    }
    
    public func getTimeXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getTimeInGanZhi())
    }
    
    public func getBrassMonkeys() -> BrassMonkeys? {
        let currentCalendar: Date = ExactDate.fromYmd(year: solar!.year, month: solar!.month, day: solar!.day)
        var start: Solar = jieQi["DONG_ZHI"]!
        var startCalendar: Date = ExactDate.fromYmd(year: start.year, month: start.month, day: start.day)
        
        if (currentCalendar.compare(startCalendar).rawValue < 0) {
            start = jieQi["冬至"]!
            startCalendar = ExactDate.fromYmd(year: start.year, month: start.month, day: start.day)
        }
        
        var endCalendar: Date = ExactDate.fromYmd(year: start.year, month: start.month, day: start.day)
        endCalendar = endCalendar.addingTimeInterval(TimeInterval(81 * 86400))
        
        if (currentCalendar.compare(startCalendar).rawValue < 0 ||
            currentCalendar.compare(endCalendar).rawValue >= 0) {
            return nil
        }
        
        let days: Int = ExactDate.getDaysBetweenDate(startDate: startCalendar, endDate: currentCalendar)
        return BrassMonkeys(name: LunarUtil.NUMBER[Int(floor(Double(days) / 9)) + 1] + "九", index: days % 9 + 1)
    }
    
    public func getDogDays() -> DogDays? {
        let currentCalendar: Date = ExactDate.fromYmd(
            year: solar!.year, month: solar!.month, day: solar!.day)
        //        let currentCalendar: Date = solar!.calendar
        let summerSolstice: Solar = jieQi["夏至"]!
        let startOfAutumn: Solar = jieQi["立秋"]!
        var startCalendar: Date = ExactDate.fromYmd(year: summerSolstice.year, month: summerSolstice.month, day: summerSolstice.day)
        // 第1个庚日
        var add: Int = 6 - summerSolstice.getLunar().getDayGanIndex()
        if (add < 0) {
            add += 10
        }
        // 第3个庚日，即初伏第1天
        add += 20
        startCalendar = startCalendar.addingTimeInterval(TimeInterval(add * 86400))
        
        // 初伏以前
        if (currentCalendar.compare(startCalendar).rawValue < 0) {
            return nil;
        }
        
        var days: Int = ExactDate.getDaysBetweenDate(startDate: startCalendar, endDate: currentCalendar)
        if (days < 10) {
            return DogDays(name: "初伏", index: days + 1)
        }
        
        // 第4个庚日，中伏第1天
        startCalendar = startCalendar.addingTimeInterval(TimeInterval(10 * 86400))
        
        days = ExactDate.getDaysBetweenDate(startDate: startCalendar, endDate: currentCalendar)
        if (days < 10) {
            return DogDays(name: "中伏", index: days + 1)
        }
        
        // 第5个庚日，中伏第11天或末伏第1天
        startCalendar = startCalendar.addingTimeInterval(TimeInterval(10 * 86400))
        
        let liQiuCalendar: Date = ExactDate.fromYmd(year: startOfAutumn.year, month: startOfAutumn.month, day: startOfAutumn.day)
        days = ExactDate.getDaysBetweenDate(startDate: startCalendar, endDate: currentCalendar)
        // 末伏
        if (liQiuCalendar.compare(startCalendar).rawValue <= 0) {
            if (days < 10) {
                return DogDays(name: "末伏", index: days + 1)
            }
        } else {
            // 中伏
            if (days < 10) {
                return DogDays(name: "中伏", index: days + 11)
            }
            // 末伏第1天
            startCalendar = startCalendar.addingTimeInterval(TimeInterval(10 * 86400))
            days = ExactDate.getDaysBetweenDate(startDate: startCalendar, endDate: currentCalendar);
            if (days < 10) {
                return DogDays(name: "末伏", index: days + 1)
            }
        }
        return nil;
    }
    
    func getLiuYao() -> String {
        return LunarUtil.LIU_YAO[(abs(month) - 1 + day - 1) % 6]
    }
    
    func getPhenology() -> String {
        let jieQi: JieQi = getPrevJieQi(wholeDay: true)
        let name: String? = jieQi.name
        var offset: Int = 0
        for i in 0..<JieQi.JIE_QI.count {
            if (name == JieQi.JIE_QI[i]) {
                offset = i
                break
            }
        }
        let currentCalendar: Date = ExactDate.fromYmd(year: solar!.year, month: solar!.month, day: solar!.day)
        
        let startSolar: Solar = jieQi.solar!
        let startCalendar: Date = ExactDate.fromYmd(year: startSolar.year, month: startSolar.month, day: startSolar.day)
        
        let days: Int = ExactDate.getDaysBetweenDate(startDate: startCalendar, endDate: currentCalendar)
        return LunarUtil.WU_HOU[(offset * 3 + Int(floor(Double(days) / 5))) % LunarUtil.WU_HOU.count]
    }
    
    func getSeasonality() -> String {
        let jieQi: JieQi = getPrevJieQi(wholeDay: true)
        let name: String = jieQi.name!
        let startSolar: Solar = jieQi.solar!
        let days: Int = ExactDate.getDaysBetween(
            ay: startSolar.year,
            am: startSolar.month,
            ad: startSolar.day,
            by: solar!.year,
            bm: solar!.month,
            bd: solar!.day)
        let max: Int = LunarUtil.HOU.count - 1
        var offset: Int = Int(floor(Double(days) / 5))
        if (offset > max) {
            offset = max
        }
        let seasonality: String = LunarUtil.HOU[offset]
        return "\(name) \(seasonality)"
    }
    
    func getDayLu() -> String {
        let gan: String = LunarUtil.LU[getDayGan()]!
        let zhi: String? = LunarUtil.LU[getDayZhi()]
        var lu: String = gan + "命互禄"
        if (nil != zhi) {
            lu += " " + zhi! + "命进禄"
        }
        return lu
    }
    
    func getTime() -> LunarTime {
        return LunarTime(fromYmdHmd: year, lunarMonth: month, lunarDay: day, hour: hour, minute: minute, second: second)
    }
    
    func getTimes() -> [LunarTime] {
        var l: [LunarTime] = []
        l.append(LunarTime(fromYmdHmd: year,lunarMonth: month, lunarDay: day, hour: 0, minute: 0, second: 0))
        for i in 0..<12 {
            l.append(LunarTime(fromYmdHmd: year, lunarMonth: month, lunarDay: day, hour: (i + 1) * 2 - 1, minute: 0, second: 0))
        }
        return l
    }
    
    var buddhis: Buddhis {
        get {
            return Buddhis(lunar: self)
        }
    }
    
    func getTaoist() -> Taoist {
        return Taoist.fromLunar(lunar: self)
    }
}
