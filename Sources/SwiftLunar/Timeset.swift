//
//  Timeset.swift
//  
//
//  Created by 睿宁 on 2022/7/14.
//
// Timeset
import Foundation

@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct Timeset {
    /// 月支，按正月起寅排列
    static let MONTH_ZHI: [String] = [
        "",
        "寅",
        "卯",
        "辰",
        "巳",
        "午",
        "未",
        "申",
        "酉",
        "戌",
        "亥",
        "子",
        "丑"
    ]
    
    /// 长生十二神
    static let CHANG_SHENG: [String] = [
        "长生",
        "沐浴",
        "冠带",
        "临官",
        "帝旺",
        "衰",
        "病",
        "死",
        "墓",
        "绝",
        "胎",
        "养"
    ]
    
    /// 长生十二神日干偏移值，五阳干顺推，五阴干逆推
    static let CHANG_SHENG_OFFSET: [String: Int] = [
        "甲": 1,
        "丙": 10,
        "戊": 10,
        "庚": 7,
        "壬": 4,
        "乙": 6,
        "丁": 9,
        "己": 9,
        "辛": 0,
        "癸": 3
    ]
    
    /// 流派，2晚子时日柱按当天，1晚子时日柱按明天
    public var genre: Int = 1
    
    /// 阴历
    public var lunar: Lunar;
    
    public init(lunar: Lunar) {
        self.lunar = lunar
    }
    
    public init(lunar: Lunar, genre: Int) {
        self.lunar = lunar
        self.genre = genre
    }
    
    //  int getSect() => _sect;
    
    //  void setSect(int sect) {
    //    _sect = (1 == sect) ? 1 : 2;
    //  }
    
    public func getLunar() -> Lunar {
        return lunar
    }
    
    public func getYear() -> String {
        return lunar.getYearInGanZhiExact()
    }
    
    public func getYearGan() -> String {
        return lunar.getYearGanExact()
    }
    
    public func getYearZhi() -> String {
        return lunar.getYearZhiExact()
    }
    
    public func getYearHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getYearZhi()]!
    }
    
    public func getYearWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getYearGan()]!)\(LunarUtil.WU_XING_ZHI[getYearZhi()]!)"
    }
    
    public func getYearNaYin() -> String {
        return LunarUtil.NAYIN[getYear()]!
    }
    
    public func getYearShiShenGan(isShort: Bool = false) -> String {
        if (isShort) {
            return LunarUtil.SHI_SHEN_GAN_SHORT["\(getDayGan())\(getYearGan())"]!
        }
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(getYearGan())"]!
    }
    
    public func getShiShenZhi(zhi: String, isShort: Bool) -> [String] {
        let hideGan: [String] = LunarUtil.ZHI_HIDE_GAN[zhi]!;
        var l: [String] = [];
        for gan in hideGan {
            if (isShort) {
                l.append(LunarUtil.SHI_SHEN_ZHI_SHORT["\(getDayGan())\(zhi)\(gan)"]!)
            } else {
                l.append(LunarUtil.SHI_SHEN_ZHI["\(getDayGan())\(zhi)\(gan)"]!)
            }
        }
        return l;
    }
    
    public func getShiShenGan(stem: String, isShort: Bool) -> String {
        if (isShort) {
            return LunarUtil.SHI_SHEN_GAN_SHORT["\(getDayGan())\(stem)"]!
        }
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(stem)"]!
    }
    
    public func getYearShiShenZhi(isShort: Bool = false) -> [String] {
        return getShiShenZhi(zhi: getYearZhi(), isShort: isShort)
    }
    
    func getDayGanIndex() -> Int {
        return genre == 2 ? lunar.getDayGanIndexExact2() : lunar.getDayGanIndexExact()
    }
    
    func getDayZhiIndex() -> Int {
        return genre == 2 ? lunar.getDayZhiIndexExact2() : lunar.getDayZhiIndexExact()
    }
    
    public func getDiShi(zhiIndex: Int) -> String {
        let offset: Int? = Timeset.CHANG_SHENG_OFFSET[getDayGan()]
        var index: Int = offset! + (getDayGanIndex() % 2 == 0 ? zhiIndex : -zhiIndex)
        if (index >= 12) {
            index -= 12
        }
        if (index < 0) {
            index += 12
        }
        return Timeset.CHANG_SHENG[index];
    }
    
    public func getYearDiShi() -> String {
        return getDiShi(zhiIndex: lunar.getYearZhiIndexExact())
    }
    
    public func getMonth() -> String {
        return lunar.getMonthInGanZhiExact()
    }
    
    public func getMonthGan() -> String {
        return lunar.getMonthGanExact()
    }
    
    public func getMonthZhi() -> String {
        return lunar.getMonthZhiExact()
    }
    
    public func getMonthHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getMonthZhi()]!
    }
    
    public func getMonthWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getMonthGan()]!)\(LunarUtil.WU_XING_ZHI[getMonthZhi()]!)"
    }
    
    public func getMonthNaYin() -> String {
        return LunarUtil.NAYIN[getMonth()]!
    }
    
    public func getMonthShiShenGan(isShort: Bool = false) -> String {
        if (isShort) {
            return LunarUtil.SHI_SHEN_GAN_SHORT["\(getDayGan())\(getMonthGan())"]!
        }
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(getMonthGan())"]!
    }
    
    public func  getMonthShiShenZhi(isShort: Bool = false) -> [String] {
        return getShiShenZhi(zhi: getMonthZhi(), isShort: isShort)
    }
    
    public func getMonthDiShi() -> String {
        return getDiShi(zhiIndex: lunar.getMonthZhiIndexExact())
    }
    
    public func getDay() -> String {
        return genre == 2 ? lunar.getDayInGanZhiExact2() : lunar.getDayInGanZhiExact()
    }
    
    public func getDayGan() -> String {
        return genre == 2 ? lunar.getDayGanExact2() : lunar.getDayGanExact()
    }
    
    public func getDayZhi() -> String {
        return genre == 2 ? lunar.getDayZhiExact2() : lunar.getDayZhiExact()
    }
    
    public func getDayHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getDayZhi()]!
    }
    
    public func getDayWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getDayGan()]!)\(LunarUtil.WU_XING_ZHI[getDayZhi()]!)"
    }
    
    public func getDayNaYin() -> String {
        return LunarUtil.NAYIN[getDay()]!
    }
    
    public func getDayShiShenGan() -> String {
        return "日元"
    }
    
    public func getDayShiShenZhi(isShort: Bool = false) -> [String] {
        return getShiShenZhi(zhi: getDayZhi(), isShort: isShort)
    }
    
    public func getDayDiShi() -> String {
        return getDiShi(zhiIndex: getDayZhiIndex())
    }
    
    public func getTime() -> String {
        return lunar.getTimeInGanZhi()
    }
    
    public func getTimeGan() -> String {
        return lunar.getTimeGan()
    }
    
    public func getTimeZhi() -> String {
        return lunar.getTimeZhi()
    }
    
    public func getTimeHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getTimeZhi()]!
    }
    
    public func getTimeWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getTimeGan()]!)\(LunarUtil.WU_XING_ZHI[getTimeZhi()]!)"
    }
    
    public func getTimeNaYin() -> String {
        return LunarUtil.NAYIN[getTime()]!
    }
    
    public func getTimeShiShenGan(isShort: Bool = false) -> String {
        if (isShort) {
            return LunarUtil.SHI_SHEN_GAN_SHORT["\(getDayGan())\(getTimeGan())"]!
        }
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(getTimeGan())"]!
    }
    
    public func getTimeShiShenZhi(isShort: Bool = false) -> [String] {
        getShiShenZhi(zhi: getTimeZhi(), isShort: isShort)
    }
    
    public func getTimeDiShi() -> String {
        getDiShi(zhiIndex: lunar.getTimeZhiIndex())
    }
    
    public func getTaiYuan() -> String {
        var ganIndex: Int = lunar.getMonthGanIndexExact() + 1;
        if (ganIndex >= 10) {
            ganIndex -= 10;
        }
        var zhiIndex: Int = lunar.getMonthZhiIndexExact() + 3;
        if (zhiIndex >= 12) {
            zhiIndex -= 12;
        }
        return "\(LunarUtil.GAN[ganIndex + 1])\(LunarUtil.ZHI[zhiIndex + 1])"
    }
    
    func getTaiYuanNaYin() -> String {
        return LunarUtil.NAYIN[getTaiYuan()]!
    }
    
    public func getTaiXi() -> String {
        let ganIndex: Int = (genre == 2) ? lunar.getDayGanIndexExact2() : lunar.getDayGanIndexExact();
        let zhiIndex: Int = (genre == 2) ? lunar.getDayZhiIndexExact2() : lunar.getDayZhiIndexExact();
        
        return "\(LunarUtil.HE_GAN_5[ganIndex])\(LunarUtil.HE_ZHI_6[zhiIndex])"
    }
    
    public func getTaiXiNaYin() -> String {
        return LunarUtil.NAYIN[getTaiXi()]!
    }
    
    func getMingGong() -> String {
        var monthZhiIndex: Int = 0
        var timeZhiIndex: Int = 0
        for i in 0..<Timeset.MONTH_ZHI.count {
            let zhi: String = Timeset.MONTH_ZHI[i];
            if (lunar.getMonthZhiExact() == zhi) {
                monthZhiIndex = i;
            }
            if (lunar.getTimeZhi() == zhi) {
                timeZhiIndex = i;
            }
        }
        var zhiIndex: Int = 26 - (monthZhiIndex + timeZhiIndex);
        if (zhiIndex > 12) {
            zhiIndex -= 12;
        }
        
        var jiaZiIndex: Int = LunarUtil.getJiaZiIndex(ganZhi: lunar.getMonthInGanZhiExact()) - (monthZhiIndex - zhiIndex);
        if (jiaZiIndex >= 60) {
            jiaZiIndex -= 60;
        }
        if (jiaZiIndex < 0) {
            jiaZiIndex += 60;
        }
        return LunarUtil.JIA_ZI[jiaZiIndex];
    }
    
    public func getMingGongNaYin() -> String {
        return LunarUtil.NAYIN[getMingGong()]!
    }
    
    public func getShenGong() -> String {
        var monthZhiIndex: Int = 0;
        var timeZhiIndex: Int = 0;
        for i in 0..<Timeset.MONTH_ZHI.count {
            let zhi: String = Timeset.MONTH_ZHI[i];
            if (lunar.getMonthZhiExact() == zhi) {
                monthZhiIndex = i;
            }
            if (lunar.getTimeZhi() == zhi) {
                timeZhiIndex = i;
            }
        }
        var zhiIndex: Int = 2 + monthZhiIndex + timeZhiIndex;
        if (zhiIndex > 12) {
            zhiIndex -= 12;
        }
        var jiaZiIndex: Int = LunarUtil.getJiaZiIndex(ganZhi: lunar.getMonthInGanZhiExact()) - (monthZhiIndex - zhiIndex)
        if (jiaZiIndex >= 60) {
            jiaZiIndex -= 60;
        }
        if (jiaZiIndex < 0) {
            jiaZiIndex += 60;
        }
        return LunarUtil.JIA_ZI[jiaZiIndex];
    }
    
    public func getShenGongNaYin() -> String {
        return LunarUtil.NAYIN[getShenGong()]!
    }
    
    public func getYun(gender: Int, genre: Int = 1) -> Yun {
        return Yun(lunar: lunar, gender: gender, genre: genre)
    }
    
    public func getYearXun() -> String {
        return lunar.getYearXunExact()
    }
    
    public func getYearXunKong() -> String {
        return lunar.getYearXunKongExact()
    }
    
    public func getMonthXun() -> String {
        return lunar.getMonthXunExact()
    }
    
    public func getMonthXunKong() -> String {
        return lunar.getMonthXunKongExact()
    }
    
    public func getDayXun() -> String {
        return genre == 2 ? lunar.getDayXunExact2() : lunar.getDayXunExact()
    }
    
    public func getDayXunKong() -> String {
        return genre == 2 ? lunar.getDayXunKongExact2() : lunar.getDayXunKongExact()
    }
    
    public func getTimeXun() -> String {
        return lunar.getTimeXun()
    }
    
    public func getTimeXunKong() -> String {
        return lunar.getTimeXunKong()
    }
    
    func toString() -> String {
        return "\(getYear()) \(getMonth()) \(getDay()) \(getTime())"
    }
}
