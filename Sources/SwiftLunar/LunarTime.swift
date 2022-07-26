//
//  LunarTime.swift
//  
//
//  Created by 睿宁 on 2022/7/12.
//

import Foundation

// 阴历时辰

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct LunarTime {
    /// 天干下标，0-9
    public var ganIndex: Int = 0
    
    /// 地支下标，0-11
    public var zhiIndex: Int = 0
    
    /// 阴历
    public var lunar: Lunar?
    
    public init(fromYmdHmd lunarYear: Int, lunarMonth: Int, lunarDay: Int, hour: Int, minute: Int, second: Int) {
        self.lunar = Lunar(fromYmdHms: lunarYear, lunarMonth: lunarMonth, lunarDay: lunarDay, hour: hour, minute: minute, second: second)
        self.zhiIndex = LunarUtil.getTimeZhiIndex(hm: "\(hour < 10 ? "0" : "")\(hour):\(minute < 10 ? "0" : "")\(minute)")
        self.ganIndex = (lunar!.getDayGanIndexExact() % 5 * 2 + zhiIndex) % 10
        
    }
    
    public func getGanIndex() -> Int {
        return ganIndex
    }
    
    public func getZhiIndex() -> Int {
        return zhiIndex
    }
    
    public func getShengXiao() -> String {
        return LunarUtil.SHENGXIAO[zhiIndex + 1]
    }
    
    public func getGan() -> String {
        return LunarUtil.GAN[ganIndex + 1]
    }
    
    public func getZhi() -> String {
        return LunarUtil.ZHI[zhiIndex + 1]
    }
    
    public func getGanZhi() -> String {
        return "\(getGan())\(getZhi())"
    }
    
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
    
    func getPositionFuDesc(geren: Int = 1 ) -> String {
        return LunarUtil.POSITION_DESC[getPositionFu(geren: geren)]!
    }
    
    func getPositionCai() -> String {
        return LunarUtil.POSITION_CAI[ganIndex + 1]
    }
    
    func getPositionCaiDesc() -> String {
        return LunarUtil.POSITION_DESC[getPositionCai()]!
    }
    
    func getNaYin() -> String {
        return LunarUtil.NAYIN[getGanZhi()]!
    }
    
    func getTianShen() -> String {
        let dayZhi: String = lunar!.getDayZhiExact()
        let offset: Int = LunarUtil.ZHI_TIAN_SHEN_OFFSET[dayZhi]!
        return LunarUtil.TIAN_SHEN[(zhiIndex + offset) % 12 + 1]
    }
    
    func getTianShenType() -> String {
        return LunarUtil.TIAN_SHEN_TYPE[getTianShen()]!
    }
    
    func getTianShenLuck() -> String {
        return LunarUtil.TIAN_SHEN_TYPE_LUCK[getTianShenType()]!
    }
    
    public func getChong() -> String {
        return LunarUtil.CHONG[zhiIndex]
    }
    
    func getSha() -> String {
        return LunarUtil.SHA[getZhi()]!
    }
    
    func getChongShengXiao() -> String {
        let chong: String = getChong()
        for i in 0..<LunarUtil.ZHI.count {
            if (LunarUtil.ZHI[i] == chong) {
                return LunarUtil.SHENGXIAO[i]
            }
        }
        return ""
    }
    
    func getChongDesc() -> String {
        "(\(getChongGan())\(getChong()))\(getChongShengXiao())"
    }
    
    public func getChongGan() -> String {
        return LunarUtil.CHONG_GAN[ganIndex]
    }
    
    func getChongGanTie() -> String {
        return LunarUtil.CHONG_GAN_TIE[ganIndex]
    }
    
    func getYi() -> [String] {
        return LunarUtil.getTimeYi(dayGanZhi: lunar!.getDayInGanZhiExact(), timeGanZhi: getGanZhi())
    }
    
    func getJi() -> [String] {
        return LunarUtil.getTimeJi(dayGanZhi: lunar!.getDayInGanZhiExact(), timeGanZhi: getGanZhi())
    }
    
    //  func getNineStar() -> NineStar {
    //    //顺逆
    //    String solarYmd = _lunar!.getSolar().toYmd()
    //    Map<String, Solar> jieQi = _lunar!.getJieQiTable()
    //    bool asc = false
    //    if (solarYmd.compareTo(jieQi["冬至"]!.toYmd()) >= 0 &&
    //        solarYmd.compareTo(jieQi["夏至"]!.toYmd()) < 0) {
    //      asc = true
    //    }
    //    int start = asc ? 7 : 3
    //    String dayZhi = _lunar!.getDayZhi()
    //    if ("子午卯酉".contains(dayZhi)) {
    //      start = asc ? 1 : 9
    //    } else if ("辰戌丑未".contains(dayZhi)) {
    //      start = asc ? 4 : 6
    //    }
    //    int index = asc ? start + _zhiIndex - 1 : start - _zhiIndex - 1
    //    if (index > 8) {
    //      index -= 9
    //    }
    //    if (index < 0) {
    //      index += 9
    //    }
    //    return NineStar(index)
    //  }
    
    
    func toString() -> String {
        return getGanZhi()
    }
    
    public func getXun() -> String {
        return LunarUtil.getXun(ganZhi: getGanZhi())
    }
    
    public func getXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getGanZhi())
    }
    
    func getMinHm() -> String {
        var hour: Int = lunar!.hour
        if (hour < 1) {
            return "00:00"
        } else if (hour > 22) {
            return "23:00"
        }
        if (hour % 2 == 0) {
            hour -= 1
        }
        return "\(hour < 10 ? "0" : "")\(hour):00"
    }
    
    func getMaxHm() -> String {
        var hour: Int = lunar!.hour
        if (hour < 1) {
            return "00:59"
        } else if (hour > 22) {
            return "23:59"
        }
        if (hour % 2 != 0) {
            hour += 1
        }
        return "\(hour < 10 ? "0" : "")\(hour):59"
    }
}
