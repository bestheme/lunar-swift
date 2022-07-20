import Foundation


/// 阴历日期
/// @author 6tail
@available(macOS 12.0, *)
struct Lunar {
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
    
    var year: Int = 0 
    
    var month: Int = 0
    
    var day: Int = 0
    
    var hour: Int = 0
    
    var minute: Int = 0
    
    var second: Int = 0
    
    var timeGanIndex: Int = 0
    var timeZhiIndex: Int = 0
    var dayGanIndex: Int = 0
    var dayZhiIndex: Int = 0
    var dayGanIndexExact: Int = 0
    var dayZhiIndexExact: Int = 0
    var dayGanIndexExact2: Int = 0
    var dayZhiIndexExact2: Int = 0
    var monthGanIndex: Int = 0
    var monthZhiIndex: Int = 0
    var monthGanIndexExact: Int = 0
    var monthZhiIndexExact: Int = 0
    var yearGanIndex: Int = 0
    var yearZhiIndex: Int = 0
    var yearGanIndexByLiChun: Int = 0
    var yearZhiIndexByLiChun: Int = 0
    var yearGanIndexExact: Int = 0
    var yearZhiIndexExact: Int = 0
    var weekIndex: Int = 0
    
    var solar: Solar? {
        didSet {
            self.weekIndex = solar!.week
        }
    }
    
//    var timeset: Timeset?
    
    var jieQi: [String: Solar] = [:]
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
    
    init(fromYmdHms lunarYear: Int, lunarMonth: Int, lunarDay: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
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
    
    init(fromDate date: Date) {
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
            if (!(solarYmd == liChunYmd)) {
                g -= 1
                z -= 1
            }
            ///立春交接时刻判断
            if (!(solarYmdHms == liChunYmdHms)) {
                gExact -= 1
                zExact -= 1
            }
        } else if (year < solarYear) {
            if (solarYmd == liChunYmd) {
                g += 1
                z += 1
            }
            if (solarYmdHms == liChunYmdHms) {
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
        var offset: Int =
        (((yearGanIndexByLiChun + (index < 0 ? 1 : 0)) % 5 + 1) * 2) % 10
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
        let offset: Double = noon.julianDay - 11
        dayGanIndex = Int(offset.truncatingRemainder(dividingBy: 10))
        dayZhiIndex = Int(offset.truncatingRemainder(dividingBy: 12))
        
        var dayGanExact: Int = dayGanIndex
        var dayZhiExact: Int = dayZhiIndex
        
        // 八字流派2，晚子时（夜子/子夜）日柱算当天
        dayGanIndexExact2 = dayGanExact
        dayZhiIndexExact2 = dayZhiExact
        
        // 八字流派1，晚子时（夜子/子夜）日柱算明天
        //              var hm: String = "\(hour < 10 ? "0" : "")\(hour.toString()):\(_minute < 10 ? "0" : "")\(minute.toString())"
        let hm: String = (DateComponents(calendar: Calendar(identifier: .gregorian), hour: hour, minute: minute).date?.formatted(.dateTime.hour(.twoDigits(amPM: .narrow)).month(.twoDigits)))!
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
        //                String hm = (_hour < 10 ? "0" : "") + _hour.toString() + ":" + (_minute < 10 ? "0" : "") + _minute.toString()
        let hm: String = DateComponents(calendar: Calendar(identifier: .gregorian), hour: hour, minute: minute).date!.formatted(.dateTime.hour(.twoDigits(amPM: .narrow)).month(.twoDigits))
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
                
    func getGan() -> String {
        return getYearGan()
    }
                
    func getYearGan() -> String {
        return LunarUtil.GAN[yearGanIndex + 1]
    }
                
    func getYearGanByLiChun() -> String {
        return LunarUtil.GAN[yearGanIndexByLiChun + 1]
    }
                
    func  getYearGanExact() -> String {
        return LunarUtil.GAN[yearGanIndexExact + 1]
    }
                
    func getZhi() -> String {
        return getYearZhi()
    }
                
    func getYearZhi() -> String {
        return  LunarUtil.ZHI[yearZhiIndex + 1]
    }
                
    func getYearZhiByLiChun() -> String {
        return LunarUtil.ZHI[yearZhiIndexByLiChun + 1]
    }
                
    func getYearZhiExact() -> String {
        return LunarUtil.ZHI[yearZhiIndexExact + 1]
    }
                
    func getYearInGanZhi() -> String {
        return "\(getYearGan())\(getYearZhi())"
    }
                
    func getYearInGanZhiByLiChun() -> String {
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
                
    func getMonthGan() -> String {
        return LunarUtil.GAN[monthGanIndex + 1]
    }
                
    func getMonthGanExact() -> String {
        return LunarUtil.GAN[monthGanIndexExact + 1]
    }
                
    func getMonthZhi() -> String {
        return LunarUtil.ZHI[monthZhiIndex + 1]
    }
                
    func getMonthZhiExact() -> String {
        return LunarUtil.ZHI[monthZhiIndexExact + 1]
    }
                
    func getDayInGanZhi() -> String {
        return "\(getDayGan())\(getDayZhi())"
    }
                
    func getDayInGanZhiExact() -> String {
        return "\(getDayGanExact())\(getDayZhiExact())"
    }
                
    func getDayInGanZhiExact2() -> String {
        return "\(getDayGanExact2())\(getDayZhiExact2())"
    }
                
    func getDayGan() -> String {
        return LunarUtil.GAN[dayGanIndex + 1]
    }
                
    func getDayGanExact() -> String {
        return LunarUtil.GAN[dayGanIndexExact + 1]
    }
                
    func getDayGanExact2() -> String {
        return LunarUtil.GAN[dayGanIndexExact2 + 1]
    }
                
    func getDayZhi() -> String {
        return LunarUtil.ZHI[dayZhiIndex + 1]
    }
                
    func getDayZhiExact() -> String {
        return LunarUtil.ZHI[dayZhiIndexExact + 1]
    }
                
    func getDayZhiExact2() -> String { return LunarUtil.ZHI[dayZhiIndexExact2 + 1]
    }
                
    @available(*, deprecated, message: "Use getYearShengXiao() instead")
    func getShengxiao() -> String {
        return getYearShengXiao()
    }
                
    func getYearShengXiao() -> String {
        return LunarUtil.SHENGXIAO[yearZhiIndex + 1]
    }
                
    func getYearShengXiaoByLiChun() -> String {
        return LunarUtil.SHENGXIAO[yearZhiIndexByLiChun + 1]
    }
                
    func getYearShengXiaoExact() -> String {
        return LunarUtil.SHENGXIAO[yearZhiIndexExact + 1]
    }
                
    func getMonthShengXiao() -> String { return LunarUtil.SHENGXIAO[monthZhiIndex + 1]
    }
                
    func getDayShengXiao() -> String { return LunarUtil.SHENGXIAO[dayZhiIndex + 1]
    }
                
    func getTimeShengXiao() -> String { return LunarUtil.SHENGXIAO[timeZhiIndex + 1]
    }
                
    func getYearInChinese() -> String {
        let y: String = String(year)
        var s: String = ""
        for v in y.utf16  {
            s += LunarUtil.NUMBER[Int(v) - 48]
        }
        return s
    }
                
    func getMonthInChinese() -> String {
        return (month < 0 ? "闰" : "") + LunarUtil.MONTH[abs(month)]
    }
                
    func getDayInChinese() -> String {
        return LunarUtil.DAY[day]
    }
                
    func getTimeZhi() -> String {
        return LunarUtil.ZHI[timeZhiIndex + 1]
    }
                
    func  getTimeGan() -> String {
        LunarUtil.GAN[timeGanIndex + 1]
    }
                
    func getTimeInGanZhi() -> String {
        return "\(getTimeGan())\(getTimeZhi())"
    }
                
    func getSeason() -> String {
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
                
    func getJie() -> String {
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
    
    func getQi() -> String {
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
                
    func getWeek() -> Int {
        return weekIndex
    }
                
    func getWeekInChinese() -> String {
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
                
    func getFestivals() -> [String] {
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
    
    func getOtherFestivals() -> [String] {
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
                
    func getDayPositionFu(sect: Int = 1) -> String {
        return (1 == sect
                ? LunarUtil.POSITION_FU
                : LunarUtil.POSITION_FU_2)[dayGanIndex + 1]
    }
                
    func getDayPositionFuDesc(sect: Int = 1) -> String {
        return LunarUtil.POSITION_DESC[getDayPositionFu(sect: sect)]!
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
                
//    private func getYearNineStar(yearInGanZhi: String) -> NineStar {
//        var index: Int = LunarUtil.getJiaZiIndex(ganZhi: yearInGanZhi) + 1
//        var yearOffset: Int = 0
//        if (index != LunarUtil.getJiaZiIndex(ganZhi: self.getYearInGanZhi()) + 1) {
//            yearOffset = -1
//        }
//        var yuan: Int = ((year + yearOffset + 2696) / 60) % 3
//        var offset: Int = (62 + yuan * 3 - index) % 9
//        if (0 == offset) {
//            offset = 9
//        }
//        return NineStar.fromIndex(offset - 1)
//    }
            
//    func getYearNineStar(geren: Int = 2) -> NineStar {
//        var yearInGanZhi: String
//        switch (geren) {
//        case 1:
//            yearInGanZhi = self.getYearInGanZhi()
//            break
//        case 3:
//            yearInGanZhi = self.getYearInGanZhiExact()
//            break
//        default:
//            yearInGanZhi = self.getYearInGanZhiByLiChun()
//        }
//        return getYearNineStar(yearInGanZhi)
//    }
//
//    private func getMonthNineStar(yearZhiIndex: Int, monthZhiIndex: Int) -> NineStar {
//        var index: Int = yearZhiIndex % 3
//        var n: Int = 27 - (index * 3)
//        if (monthZhiIndex < LunarUtil.BASE_MONTH_ZHI_INDEX) {
//            n -= 3
//        }
//        var offset: Int = (n - monthZhiIndex) % 9
//        return NineStar.fromIndex(offset)
//    }
                
//    func getMonthNineStar(geren: <#T##Int#> = 1) -> NineStart {
//        var yearZhiIndexSelector: Int
//        var monthZhiIndexSelector: Int
//        switch (geren) {
//        case 1:
//            yearZhiIndexSelector = yearZhiIndex
//            monthZhiIndexSelector = monthZhiIndex
//            break
//        case 3:
//            yearZhiIndexSelector = yearZhiIndexExact
//            monthZhiIndexSelector = monthZhiIndexExact
//            break
//        default:
//            yearZhiIndexSelector = yearZhiIndexByLiChun
//            monthZhiIndexSelector = monthZhiIndex
//        }
//        return getMonthNineStar(yearZhiIndex: yearZhiIndex, monthZhiIndex: monthZhiIndex)
//    }
                
//    func getDayNineStar() -> NineStar {
//        String solarYmd = _solar!.toYmd()
//        Solar dongZhi = _jieQi["冬至"]!
//        Solar dongZhi2 = _jieQi["DONG_ZHI"]!
//        Solar xiaZhi = _jieQi["夏至"]!
//        int dongZhiIndex =
//        LunarUtil.getJiaZiIndex(dongZhi.getLunar().getDayInGanZhi())
//        int dongZhiIndex2 =
//        LunarUtil.getJiaZiIndex(dongZhi2.getLunar().getDayInGanZhi())
//        int xiaZhiIndex =
//        LunarUtil.getJiaZiIndex(xiaZhi.getLunar().getDayInGanZhi())
//        Solar solarShunBai
//        Solar solarShunBai2
//        Solar solarNiZi
//        if (dongZhiIndex > 29) {
//            solarShunBai = dongZhi.next(60 - dongZhiIndex)
//        } else {
//            solarShunBai = dongZhi.next(-dongZhiIndex)
//        }
//        String solarShunBaiYmd = solarShunBai.toYmd()
//        if (dongZhiIndex2 > 29) {
//            solarShunBai2 = dongZhi2.next(60 - dongZhiIndex2)
//        } else {
//            solarShunBai2 = dongZhi2.next(-dongZhiIndex2)
//        }
//        String solarShunBaiYmd2 = solarShunBai2.toYmd()
//        if (xiaZhiIndex > 29) {
//            solarNiZi = xiaZhi.next(60 - xiaZhiIndex)
//        } else {
//            solarNiZi = xiaZhi.next(-xiaZhiIndex)
//        }
//        String solarNiZiYmd = solarNiZi.toYmd()
//        int offset = 0
//        if (solarYmd.compareTo(solarShunBaiYmd) >= 0 &&
//            solarYmd.compareTo(solarNiZiYmd) < 0) {
//            offset = ExactDate.getDaysBetweenDate(
//                solarShunBai.getCalendar(), this.getSolar().getCalendar()) %
//            9
//        } else if (solarYmd.compareTo(solarNiZiYmd) >= 0 &&
//                   solarYmd.compareTo(solarShunBaiYmd2) < 0) {
//            offset = 8 -
//            (ExactDate.getDaysBetweenDate(
//                solarNiZi.getCalendar(), this.getSolar().getCalendar()) %
//             9)
//        } else if (solarYmd.compareTo(solarShunBaiYmd2) >= 0) {
//            offset = ExactDate.getDaysBetweenDate(
//                solarShunBai2.getCalendar(), this.getSolar().getCalendar()) %
//            9
//        } else if (solarYmd.compareTo(solarShunBaiYmd) < 0) {
//            offset = (8 +
//                      ExactDate.getDaysBetweenDate(
//                        this.getSolar().getCalendar(), solarShunBai.getCalendar())) %
//            9
//        }
//        return NineStar.fromIndex(offset)
//    }
                
//    func getTimeNineStar() -> NineStar {
//        //顺逆
//        String solarYmd = _solar!.toYmd()
//        bool asc = false
//        if (solarYmd.compareTo(_jieQi["冬至"]!.toYmd()) >= 0 &&
//            solarYmd.compareTo(_jieQi["夏至"]!.toYmd()) < 0) {
//            asc = true
//        } else if (solarYmd.compareTo(_jieQi["DONG_ZHI"]!.toYmd()) >= 0) {
//            asc = true
//        }
//        int start = asc ? 6 : 2
//        String dayZhi = getDayZhi()
//        if ("子午卯酉".contains(dayZhi)) {
//            start = asc ? 0 : 8
//        } else if ("辰戌丑未".contains(dayZhi)) {
//            start = asc ? 3 : 5
//        }
//        int index = asc ? (start + _timeZhiIndex) : (start + 9 - _timeZhiIndex)
//        return new NineStar(index % 9)
//    }

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
//
//                JieQi getNextQi([bool wholeDay = false]) -> JieQi{
//                int l = (JIE_QI_IN_USE.length / 2).floor()
//                List<String> conditions = <String>[]
//                for (int i = 0 i < l i++) {
//                    conditions.add(JIE_QI_IN_USE[i * 2 + 1])
//                }
//                return _getNearJieQi(true, conditions, wholeDay)!
//            }
//
//                JieQi getPrevQi([bool wholeDay = false]) -> JieQi{
//                int l = (JIE_QI_IN_USE.length / 2).floor()
//                List<String> conditions = <String>[]
//                for (int i = 0 i < l i++) {
//                    conditions.add(JIE_QI_IN_USE[i * 2 + 1])
//                }
//                return _getNearJieQi(false, conditions, wholeDay)!
//            }
//
//                JieQi getNextJieQi([bool wholeDay = false]) =>
//                _getNearJieQi(true, null, wholeDay)!
//
//                JieQi getPrevJieQi([bool wholeDay = false]) =>
//                _getNearJieQi(false, null, wholeDay)!

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
    //
//                JieQi? getCurrentJieQi() {
//                for (MapEntry<String, Solar> jq in _jieQi.entries) {
//                    Solar d = jq.value
//                    if (d.getYear() == _solar!.getYear() &&
//                        d.getMonth() == _solar!.getMonth() &&
//                        d.getDay() == _solar!.getDay()) {
//                        return new JieQi(_convertJieQi(jq.key), d)
//                    }
//                }
//                return null
//            }
//
//                JieQi? getCurrentJie() {
//                for (int i = 0, j = JIE_QI_IN_USE.length i < j i += 2) {
//                    String key = JIE_QI_IN_USE[i]
//                    Solar? d = _jieQi[key]
//                    if (d!.getYear() == _solar!.getYear() &&
//                        d.getMonth() == _solar!.getMonth() &&
//                        d.getDay() == _solar!.getDay()) {
//                        return new JieQi(_convertJieQi(key), d)
//                    }
//                }
//                return null
//            }
//
//                JieQi? getCurrentQi() {
//                for (int i = 1, j = JIE_QI_IN_USE.length i < j i += 2) {
//                    String key = JIE_QI_IN_USE[i]
//                    Solar? d = _jieQi[key]
//                    if (d!.getYear() == _solar!.getYear() &&
//                        d.getMonth() == _solar!.getMonth() &&
//                        d.getDay() == _solar!.getDay()) {
//                        return new JieQi(_convertJieQi(key), d)
//                    }
//                }
//                return null
//            }
                
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
        s += getDayPositionFu()
        s += "]("
        s += getDayPositionFuDesc()
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
                
    func getSolar() -> Solar {
        return solar!
    }
                
    func getTimeset() -> Timeset{
        return Timeset(lunar: self)
    }
                
    func next(days: Int) -> Lunar {
        return solar!.next(days: days).getLunar()
    }
                
//                String getYearXun() => LunarUtil.getXun(getYearInGanZhi())
//
//                String getYearXunByLiChun() => LunarUtil.getXun(getYearInGanZhiByLiChun())
//
    func getYearXunExact() -> String {
        return LunarUtil.getXun(ganZhi: getYearInGanZhiExact())
    }
//
//                String getYearXunKong() => LunarUtil.getXunKong(getYearInGanZhi())
//
//                String getYearXunKongByLiChun() =>
//                LunarUtil.getXunKong(getYearInGanZhiByLiChun())
//
    func getYearXunKongExact() -> String {
        return LunarUtil.getXunKong(ganZhi: getYearInGanZhiExact())
    }
//
//                String getMonthXun() => LunarUtil.getXun(getMonthInGanZhi())
//
    func getMonthXunExact() -> String {
        return LunarUtil.getXun(ganZhi: getMonthInGanZhiExact())
    }
//
//                String getMonthXunKong() => LunarUtil.getXunKong(getMonthInGanZhi())
//
    func getMonthXunKongExact() -> String {
        return LunarUtil.getXunKong(ganZhi: getMonthInGanZhiExact())
    }

    func getDayXun() -> String {
        return LunarUtil.getXun(ganZhi: getDayInGanZhi())
    }

    func getDayXunExact() -> String {
        return LunarUtil.getXun(ganZhi: getDayInGanZhiExact())
    }

    func getDayXunExact2() -> String {
        return LunarUtil.getXun(ganZhi: getDayInGanZhiExact2())
    }

    func getDayXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getDayInGanZhi())
    }

    func getDayXunKongExact() -> String {
        return LunarUtil.getXunKong(ganZhi: getDayInGanZhiExact())
    }

    func getDayXunKongExact2() -> String {
        return LunarUtil.getXunKong(ganZhi: getDayInGanZhiExact2())
    }

    func getTimeXun() -> String {
        return LunarUtil.getXun(ganZhi: getTimeInGanZhi())
    }

    func getTimeXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getTimeInGanZhi())
    }

//                ShuJiu? getShuJiu() {
//                DateTime currentCalendar = ExactDate.fromYmd(
//                    _solar!.getYear(), _solar!.getMonth(), _solar!.getDay())
//                Solar start = _jieQi["DONG_ZHI"]!
//                DateTime startCalendar =
//                ExactDate.fromYmd(start.getYear(), start.getMonth(), start.getDay())
//
//                if (currentCalendar.compareTo(startCalendar) < 0) {
//                    start = _jieQi["冬至"]!
//                    startCalendar =
//                    ExactDate.fromYmd(start.getYear(), start.getMonth(), start.getDay())
//                }
//
//                DateTime endCalendar =
//                ExactDate.fromYmd(start.getYear(), start.getMonth(), start.getDay())
//                endCalendar = endCalendar.add(Duration(days: 81))
//
//                if (currentCalendar.compareTo(startCalendar) < 0 ||
//                    currentCalendar.compareTo(endCalendar) >= 0) {
//                    return null
//                }
//
//                int days = ExactDate.getDaysBetweenDate(startCalendar, currentCalendar)
//                return ShuJiu(LunarUtil.NUMBER[(days / 9).floor() + 1] + "九", days % 9 + 1)
//            }
//
//                Fu? getFu() {
//                DateTime currentCalendar = ExactDate.fromYmd(
//                    _solar!.getYear(), _solar!.getMonth(), _solar!.getDay())
//                Solar xiaZhi = _jieQi["夏至"]!
//                Solar liQiu = _jieQi["立秋"]!
//                DateTime startCalendar =
//                ExactDate.fromYmd(xiaZhi.getYear(), xiaZhi.getMonth(), xiaZhi.getDay())
//                // 第1个庚日
//                int add = 6 - xiaZhi.getLunar().getDayGanIndex()
//                if (add < 0) {
//                    add += 10
//                }
//                // 第3个庚日，即初伏第1天
//                add += 20
//                startCalendar = startCalendar.add(Duration(days: add))
//
//                // 初伏以前
//                if (currentCalendar.compareTo(startCalendar) < 0) {
//                    return null
//                }
//
//                int days = ExactDate.getDaysBetweenDate(startCalendar, currentCalendar)
//                if (days < 10) {
//                    return new Fu("初伏", days + 1)
//                }
//
//                // 第4个庚日，中伏第1天
//                startCalendar = startCalendar.add(Duration(days: 10))
//
//                days = ExactDate.getDaysBetweenDate(startCalendar, currentCalendar)
//                if (days < 10) {
//                    return new Fu("中伏", days + 1)
//                }
//
//                // 第5个庚日，中伏第11天或末伏第1天
//                startCalendar = startCalendar.add(Duration(days: 10))
//
//                DateTime liQiuCalendar =
//                ExactDate.fromYmd(liQiu.getYear(), liQiu.getMonth(), liQiu.getDay())
//                days = ExactDate.getDaysBetweenDate(startCalendar, currentCalendar)
//                // 末伏
//                if (liQiuCalendar.compareTo(startCalendar) <= 0) {
//                    if (days < 10) {
//                        return Fu("末伏", days + 1)
//                    }
//                } else {
//                    // 中伏
//                    if (days < 10) {
//                        return Fu("中伏", days + 11)
//                    }
//                    // 末伏第1天
//                    startCalendar = startCalendar.add(Duration(days: 10))
//                    days = ExactDate.getDaysBetweenDate(startCalendar, currentCalendar)
//                    if (days < 10) {
//                        return Fu("末伏", days + 1)
//                    }
//                }
//                return null
//            }
//
//                String getLiuYao() => LunarUtil.LIU_YAO[(_month.abs() - 1 + _day - 1) % 6]
//
//                String getWuHou() {
//                JieQi jieQi = getPrevJieQi(true)
//                String? name = jieQi.getName()
//                int offset = 0
//                for (int i = 0, j = JieQi.JIE_QI.length i < j i++) {
//                    if (name == JieQi.JIE_QI[i]) {
//                        offset = i
//                        break
//                    }
//                }
//                DateTime currentCalendar = ExactDate.fromYmd(
//                    _solar!.getYear(), _solar!.getMonth(), _solar!.getDay())
//
//                Solar startSolar = jieQi.getSolar()
//                DateTime startCalendar = ExactDate.fromYmd(
//                    startSolar.getYear(), startSolar.getMonth(), startSolar.getDay())
//
//                int days = ExactDate.getDaysBetweenDate(startCalendar, currentCalendar)
//                return LunarUtil
//                    .WU_HOU[(offset * 3 + (days / 5).floor()) % LunarUtil.WU_HOU.length]
//            }
//
//                String getHou() {
//                JieQi jieQi = getPrevJieQi(true)
//                String name = jieQi.getName()
//                Solar startSolar = jieQi.getSolar()
//                int days = ExactDate.getDaysBetween(
//                    startSolar.getYear(),
//                    startSolar.getMonth(),
//                    startSolar.getDay(),
//                    _solar!.getYear(),
//                    _solar!.getMonth(),
//                    _solar!.getDay())
//                int max = LunarUtil.HOU.length - 1
//                int offset = (days / 5).floor()
//                if (offset > max) {
//                    offset = max
//                }
//                String hou = LunarUtil.HOU[offset]
//                return "$name $hou"
//            }
//
//                String getDayLu() {
//                String gan = LunarUtil.LU[getDayGan()]!
//                String? zhi = LunarUtil.LU[getDayZhi()]
//                String lu = gan + "命互禄"
//                if (null != zhi) {
//                    lu += " " + zhi + "命进禄"
//                }
//                return lu
//            }
//
//                LunarTime getTime() {
//                return LunarTime.fromYmdHms(_year, _month, _day, _hour, _minute, _second)
//            }
//
//                List<LunarTime> getTimes() {
//                List<LunarTime> l = <LunarTime>[]
//                l.add(LunarTime.fromYmdHms(_year, _month, _day, 0, 0, 0))
//                for (int i = 0 i < 12 i++) {
//                    l.add(LunarTime.fromYmdHms(_year, _month, _day, (i + 1) * 2 - 1, 0, 0))
//                }
//                return l
//            }
//
//                Foto getFoto() {
//                return Foto.fromLunar(this)
//            }
//
//                Tao getTao() {
//                return Tao.fromLunar(this)
//            }
}
