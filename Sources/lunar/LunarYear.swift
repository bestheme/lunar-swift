//
//  LunarYear.swift
//  
//
//  Created by 睿宁 on 2022/7/12.
//

import Foundation

@available(macOS 12.0, *)
struct LunarYear {
    /// 元
    static let YUAN: [String] = ["下", "上", "中"]
    
    /// 运
    static let YUN: [String] = ["七", "八", "九", "一", "二", "三", "四", "五", "六"]
    
    /// 闰冬月年份
    static let LEAP_11: [Int] = [
        75,
        94,
        170,
        238,
        265,
        322,
        389,
        469,
        553,
        583,
        610,
        678,
        735,
        754,
        773,
        849,
        887,
        936,
        1050,
        1069,
        1126,
        1145,
        1164,
        1183,
        1259,
        1278,
        1308,
        1373,
        1403,
        1441,
        1460,
        1498,
        1555,
        1593,
        1612,
        1631,
        1642,
        2033,
        2128,
        2147,
        2242,
        2614,
        2728,
        2910,
        3062,
        3244,
        3339,
        3616,
        3711,
        3730,
        3825,
        4007,
        4159,
        4197,
        4322,
        4341,
        4379,
        4417,
        4531,
        4599,
        4694,
        4713,
        4789,
        4808,
        4971,
        5085,
        5104,
        5161,
        5180,
        5199,
        5294,
        5305,
        5476,
        5677,
        5696,
        5772,
        5791,
        5848,
        5886,
        6049,
        6068,
        6144,
        6163,
        6258,
        6402,
        6440,
        6497,
        6516,
        6630,
        6641,
        6660,
        6679,
        6736,
        6774,
        6850,
        6869,
        6899,
        6918,
        6994,
        7013,
        7032,
        7051,
        7070,
        7089,
        7108,
        7127,
        7146,
        7222,
        7271,
        7290,
        7309,
        7366,
        7385,
        7404,
        7442,
        7461,
        7480,
        7491,
        7499,
        7594,
        7624,
        7643,
        7662,
        7681,
        7719,
        7738,
        7814,
        7863,
        7882,
        7901,
        7939,
        7958,
        7977,
        7996,
        8034,
        8053,
        8072,
        8091,
        8121,
        8159,
        8186,
        8216,
        8235,
        8254,
        8273,
        8311,
        8330,
        8341,
        8349,
        8368,
        8444,
        8463,
        8474,
        8493,
        8531,
        8569,
        8588,
        8626,
        8664,
        8683,
        8694,
        8702,
        8713,
        8721,
        8751,
        8789,
        8808,
        8816,
        8827,
        8846,
        8884,
        8903,
        8922,
        8941,
        8971,
        9036,
        9066,
        9085,
        9104,
        9123,
        9142,
        9161,
        9180,
        9199,
        9218,
        9256,
        9294,
        9313,
        9324,
        9343,
        9362,
        9381,
        9419,
        9438,
        9476,
        9514,
        9533,
        9544,
        9552,
        9563,
        9571,
        9582,
        9601,
        9639,
        9658,
        9666,
        9677,
        9696,
        9734,
        9753,
        9772,
        9791,
        9802,
        9821,
        9886,
        9897,
        9916,
        9935,
        9954,
        9973,
        9992
    ]
    
    /// 闰腊月年份
    static let LEAP_12: [Int] = [
        37,
        56,
        113,
        132,
        151,
        189,
        208,
        227,
        246,
        284,
        303,
        341,
        360,
        379,
        417,
        436,
        458,
        477,
        496,
        515,
        534,
        572,
        591,
        629,
        648,
        667,
        697,
        716,
        792,
        811,
        830,
        868,
        906,
        925,
        944,
        963,
        982,
        1001,
        1020,
        1039,
        1058,
        1088,
        1153,
        1202,
        1221,
        1240,
        1297,
        1335,
        1392,
        1411,
        1422,
        1430,
        1517,
        1525,
        1536,
        1574,
        3358,
        3472,
        3806,
        3988,
        4751,
        4941,
        5066,
        5123,
        5275,
        5343,
        5438,
        5457,
        5495,
        5533,
        5552,
        5715,
        5810,
        5829,
        5905,
        5924,
        6421,
        6535,
        6793,
        6812,
        6888,
        6907,
        7002,
        7184,
        7260,
        7279,
        7374,
        7556,
        7746,
        7757,
        7776,
        7833,
        7852,
        7871,
        7966,
        8015,
        8110,
        8129,
        8148,
        8224,
        8243,
        8338,
        8406,
        8425,
        8482,
        8501,
        8520,
        8558,
        8596,
        8607,
        8615,
        8645,
        8740,
        8778,
        8835,
        8865,
        8930,
        8960,
        8979,
        8998,
        9017,
        9055,
        9074,
        9093,
        9112,
        9150,
        9188,
        9237,
        9275,
        9332,
        9351,
        9370,
        9408,
        9427,
        9446,
        9457,
        9465,
        9495,
        9560,
        9590,
        9628,
        9647,
        9685,
        9715,
        9742,
        9780,
        9810,
        9818,
        9829,
        9848,
        9867,
        9905,
        9924,
        9943,
        9962,
        10000
    ]
    
    static var leap: [Int: Int] = [:]
    
    static var cache: [Int: LunarYear] = [:]
    
    /// 农历年
    var year: Int = 0
    
    /// 天干下标
    var ganIndex: Int = 0
    
    /// 地支下标
    var zhiIndex: Int = 0
    
    /// 农历月们
    var months: [LunarMonth] = []
    
    /// 节气儒略日们
    var jieQiJulianDays: [Double] = []
//    {
//        get {
//            for i in 0..<Lunar.JIE_QI_IN_USE.count  {
//                var julianDayOfSolarTerms: [Double]
//                // 精确的节气
//                var t: Double = 36525 * ShouXingUtil.saLonT(w: (year + (17 + i) * 15.0 / 360) * ShouXingUtil.PI_2)
//                t += ShouXingUtil.ONE_THIRD - ShouXingUtil.dtT(t: t)
//                julianDayOfSolarTerms.append(t + Solar.J2000)
//                // 按中午12点算的节气
//                if (i > 0 && i < 28) {
//                    jq.append(Double(t.round()))
//                }
//            }
//            return
//        }
//    }
    
    init(lunarYear: Int) {
        if (LunarYear.leap.isEmpty) {
            for y in LunarYear.LEAP_11 {
                LunarYear.leap[y] = 13
            }
            for y in LunarYear.LEAP_12 {
                LunarYear.leap[y] = 14
            }
        }
        self.year = lunarYear
        let offset: Int = lunarYear - 4
        var yearGanIndex: Int = offset % 10
        var yearZhiIndex: Int = offset % 12
        if (yearGanIndex < 0) {
            yearGanIndex += 10
        }
        if (yearZhiIndex < 0) {
            yearZhiIndex += 12
        }
        self.ganIndex = yearGanIndex
        self.zhiIndex = yearZhiIndex
        compute()
    }
    
    static func fromYear(lunarYear: Int) -> LunarYear {
        var obj: LunarYear? = cache[lunarYear]
        if (nil == obj) {
            obj = LunarYear(lunarYear: lunarYear)
            cache[lunarYear] = obj
        }
        return obj!
    }
    
    mutating func compute() {
        // 节气(中午12点)，长度27
        var jq: [Double] = []
        // 合朔，即每月初一(中午12点)，长度16
        var hs: [Double] = []
        // 每月天数，长度15
        var dayCounts: [Int] = []
        
        let currentYear: Int = year
        let year: Int = currentYear - 2000
        
        // 从上年的大雪到下年的立春
        for i in 0..<Lunar.JIE_QI_IN_USE.count  {
//            let salonTarg: Double = (Double(currentYear - 2000) + (17 + Double(i)) * 15.0 / 360) * ShouXingUtil.PI_2
            // 精确的节气
            var t: Double = 36525 * ShouXingUtil.saLonT(w: (Double(year) + (17 + Double(i)) * 15.0 / 360) * ShouXingUtil.PI_2)
            t += ShouXingUtil.ONE_THIRD - ShouXingUtil.dtT(t: t)
            jieQiJulianDays.append(t + Solar.J2000)
            // 按中午12点算的节气
            if (i > 0 && i < 28) {
                
                jq.append(round(t))
            }
        }
        
        // 冬至前的初一
        var w: Double = ShouXingUtil.calcShuo(jd: jq[0])
        if (w > jq[0]) {
            w -= 29.5306
        }
        // 递推每月初一
        for i in 0..<16 {
            hs.append(ShouXingUtil.calcShuo(jd: w + 29.5306 * Double(i)))
        }
        // 每月天数
        for i in 0..<15 {
            dayCounts.append(Int(floor(hs[i + 1] - hs[i])))
        }
        
        var currentYearLeap: Int? = LunarYear.leap[currentYear]
        if (nil == currentYearLeap) {
            currentYearLeap = -1
            if (hs[13] <= jq[24]) {
                var i: Int = 1
                while (hs[i + 1] > jq[2 * i] && i < 13) {
                    i += 1
                }
                currentYearLeap = i
            }
        }
        
        let prevYear: Int = currentYear - 1
        var prevYearLeap: Int? = LunarYear.leap[prevYear]
        prevYearLeap = nil == prevYearLeap ? -1 : prevYearLeap! - 12
        
        var y: Int = prevYear
        var m: Int = 11
        
        for i in 0..<dayCounts.count {
            var cm: Int = m
            var isNextLeap: Bool = false
            if (y == currentYear && i == currentYearLeap) {
                cm = -cm
            } else if (y == prevYear && i == prevYearLeap) {
                cm = -cm
            }
            if (y == currentYear && i + 1 == currentYearLeap) {
                isNextLeap = true
            } else if (y == prevYear && i + 1 == prevYearLeap) {
                isNextLeap = true
            }
            let lunarMonth: LunarMonth? = LunarMonth(year: y, month: cm, dayCount: dayCounts[i], firstJulianDay: hs[i] + Solar.J2000)
            months.append(lunarMonth!)
            if (!isNextLeap) {
                m += 1
            }
            if (m == 13) {
                m = 1
                y += 1
            }
        }
    }
    
//    func getYear() -> Int {
//        return year
//    }
//
//    func getGanIndex() -> Int {
//        return ganIndex
//    }
//
//    func getZhiIndex() -> Int {
//        return zhiIndex
//    }
    
    func getGan() -> String {
        return LunarUtil.GAN[ganIndex + 1]
    }
    
    func getZhi() -> String {
        return LunarUtil.ZHI[zhiIndex + 1]
    }
    
    func getGanZhi() -> String {
        return "\(getGan())\(getZhi())"
    }
    
    func getMonths() -> [LunarMonth] {
        return months
    }
    
    func getJieQiJulianDays() -> [Double] {
        return jieQiJulianDays
    }
    
    func getMonth(lunarMonth: Int) -> LunarMonth? {
        for m in months {
            if (m.year == year && m.month == lunarMonth) {
                return m
            }
        }
        return nil
    }
    
    func getLeapMonth() -> Int {
        for m in months {
            if (m.getYear() == year && m.isLeap()) {
                return abs(m.getMonth())
            }
        }
        return 0
    }
    
    func toString() -> String {
        return "\(year)"
    }
    
    func toFullString() -> String{
        return "\(year)年"
    }
    
    func getZaoByGan(index: Int, name: String) -> String {
        let zao: String = name
        var offset: Int = index - Solar(fromJulianDay: getMonth(lunarMonth: 1)!.getFirstJulianDay()).getLunar().getDayGanIndex()
        if (offset < 0) {
            offset += 10
        }
        
        return zao.replacingOccurrences(of: "几", with: LunarUtil.NUMBER[offset + 1])
    }
    
    func getZaoByZhi(index: Int, name: String) -> String {
        var offset: Int = index - Solar(fromJulianDay: getMonth(lunarMonth: 1)!.getFirstJulianDay()).getLunar().getDayZhiIndex()
        if (offset < 0) {
            offset += 12
        }
        return name.replacingOccurrences(of: "几", with: LunarUtil.NUMBER[offset + 1])
    }
    
    func getTouLiang() -> String {
        return getZaoByZhi(index: 0, name: "几鼠偷粮")
    }
    
    func getCaoZi() -> String {
        return getZaoByZhi(index: 0, name: "草子几分")
    }
    
    func getGengTian() -> String {
        return getZaoByZhi(index: 1, name: "几牛耕田")
    }
    
    func getHuaShou() -> String {
        return getZaoByZhi(index: 3, name: "花收几分")
    }
    
    func getZhiShui() -> String {
        return getZaoByZhi(index: 4, name: "几龙治水")
    }
    
    func getTuoGu() -> String {
        return getZaoByZhi(index: 6, name: "几马驮谷")
    }
    
    func getQiangMi() -> String {
        return getZaoByZhi(index: 9, name: "几鸡抢米")
    }
    
    func getKanCan() -> String {
        return getZaoByZhi(index: 9, name: "几姑看蚕")
    }
    
    func getGongZhu() -> String {
        return getZaoByZhi(index: 11,name:  "几屠共猪")
    }
    
    func getJiaTian() -> String {
        return getZaoByGan(index: 0, name: "甲田几分")
    }
    
    func getFenBing() -> String {
        return getZaoByGan(index: 2, name: "几人分饼")
    }
    
    func getDeJin() -> String {
        return getZaoByGan(index: 7, name: "几日得金")
    }
    
    func getRenBing() -> String {
        return getZaoByGan(index: 2, name: getZaoByZhi(index: 2, name: "几人几丙"))
    }
    
    func getRenChu() -> String {
        return getZaoByGan(index: 3, name: getZaoByZhi(index: 2, name: "几人几锄"))
    }
    
    func getYuan() -> String {
        return LunarYear.YUAN[Int((year + 2696) / 60) % 3] + "元"
    }
    
    func getYun() -> String {
        return LunarYear.YUN[Int((year + 2696) / 20) % 9] + "运"
    }
    
//    func getNineStar() -> NineStar {
//        var index: Int = LunarUtil.getJiaZiIndex(ganZhi: getGanZhi()) + 1
//        var yuan: Int = Int((_year + 2696) / 60) % 3
//        var offset: Int = (62 + yuan * 3 - index) % 9
//        if (0 == offset) {
//            offset = 9
//        }
//        return NineStar.fromIndex(offset - 1)
//    }
    
    func getPositionXi() -> String {
        return LunarUtil.POSITION_XI[ganIndex + 1]
    }
    
    func getPositionXiDesc() -> String {
        return LunarUtil.POSITION_DESC[getPositionXi()]!
    }
    
    func getPositionYangGui() -> String {
        return LunarUtil.POSITION_YANG_GUI[ganIndex + 1]
    }
    
    func getPositionYangGuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getPositionYangGui()]!
    }
    
    
    func getPositionYinGui() -> String {
        return LunarUtil.POSITION_YIN_GUI[ganIndex + 1]
    }
    
    func getPositionYinGuiDesc() -> String {
        return LunarUtil.POSITION_DESC[getPositionYinGui()]!
    }
   
    
    func getPositionFu(geren: Int = 1) -> String {
        return (1 == geren
                ? LunarUtil.POSITION_FU
                : LunarUtil.POSITION_FU_2)[ganIndex + 1]
    }
    
    func getPositionFuDesc(geren: Int = 1) -> String {
        return LunarUtil.POSITION_DESC[getPositionFu(geren: geren)]!
    }
    
    
    func getPositionCai() -> String {
        return LunarUtil.POSITION_CAI[ganIndex + 1]
    }
    
    func getPositionCaiDesc() -> String {
        return lunar.LunarUtil.POSITION_DESC[getPositionCai()]!
    }
    
    func getPositionTaiSui() -> String {
        return lunar.LunarUtil.POSITION_TAI_SUI_YEAR[zhiIndex]
    }
    
    func getPositionTaiSuiDesc() -> String {
        return lunar.LunarUtil.POSITION_DESC[getPositionTaiSui()]!
    }
    
    
    func next(n: Int) -> LunarYear {
        return LunarYear.fromYear(lunarYear: year + n)
    }
}
