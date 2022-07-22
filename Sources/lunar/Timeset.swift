//
//  Timeset.swift
//  
//
//  Created by 睿宁 on 2022/7/14.
//

import Foundation

/// 八字
/// @author 6tail
@available(macOS 12.0, *)
struct Timeset {
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
    var genre: Int = 1

  /// 阴历
    var lunar: Lunar;

    init(lunar: Lunar) {
        self.lunar = lunar
    }
    
    init(lunar: Lunar, genre: Int) {
        self.lunar = lunar
        self.genre = genre
    }

//  int getSect() => _sect;

//  void setSect(int sect) {
//    _sect = (1 == sect) ? 1 : 2;
//  }

    func getLunar() -> Lunar {
        return lunar
    }

    func getYear() -> String {
        return lunar.getYearInGanZhiExact()
    }

    func getYearGan() -> String {
        return lunar.getYearGanExact()
    }

    func getYearZhi() -> String {
        return lunar.getYearZhiExact()
    }

    func getYearHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getYearZhi()]!
    }

    func getYearWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getYearGan()]!)\(LunarUtil.WU_XING_ZHI[getYearZhi()]!)"
    }

    func getYearNaYin() -> String {
        return LunarUtil.NAYIN[getYear()]!
    }

    func getYearShiShenGan() -> String {
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(getYearGan())"]!
    }

    func getShiShenZhi(zhi: String) -> [String] {
        let hideGan: [String] = LunarUtil.ZHI_HIDE_GAN[zhi]!;
        var l: [String] = [];
        for gan in hideGan {
            l.append(LunarUtil.SHI_SHEN_ZHI["\(getDayGan())\(zhi)\(gan)"]!)
        }
        return l;
    }

    func getYearShiShenZhi() -> [String] {
        return getShiShenZhi(zhi: getYearZhi())
    }

    func getDayGanIndex() -> Int {
        return genre == 2 ? lunar.getDayGanIndexExact2() : lunar.getDayGanIndexExact()
    }

    func getDayZhiIndex() -> Int {
        return genre == 2 ? lunar.getDayZhiIndexExact2() : lunar.getDayZhiIndexExact()
    }

    func getDiShi(zhiIndex: Int) -> String {
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

    func getYearDiShi() -> String {
        return getDiShi(zhiIndex: lunar.getYearZhiIndexExact())
    }

    func getMonth() -> String {
        return lunar.getMonthInGanZhiExact()
    }

    func getMonthGan() -> String {
        return lunar.getMonthGanExact()
    }

    func getMonthZhi() -> String {
        return lunar.getMonthZhiExact()
    }

    func getMonthHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getMonthZhi()]!
    }

    func getMonthWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getMonthGan()]!)\(LunarUtil.WU_XING_ZHI[getMonthZhi()]!)"
    }

    func getMonthNaYin() -> String {
        return LunarUtil.NAYIN[getMonth()]!
    }

    func getMonthShiShenGan() -> String {
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(getMonthGan())"]!
    }

    func  getMonthShiShenZhi() -> [String] {
        return getShiShenZhi(zhi: getMonthZhi())
    }

    func getMonthDiShi() -> String {
        return getDiShi(zhiIndex: lunar.getMonthZhiIndexExact())
    }

    func getDay() -> String {
        return genre == 2 ? lunar.getDayInGanZhiExact2() : lunar.getDayInGanZhiExact()
    }

    func getDayGan() -> String {
        return genre == 2 ? lunar.getDayGanExact2() : lunar.getDayGanExact()
    }

    func getDayZhi() -> String {
        return genre == 2 ? lunar.getDayZhiExact2() : lunar.getDayZhiExact()
    }

    func getDayHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getDayZhi()]!
    }

    func getDayWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getDayGan()]!)\(LunarUtil.WU_XING_ZHI[getDayZhi()]!)"
    }

    func getDayNaYin() -> String {
        return LunarUtil.NAYIN[getDay()]!
    }

    func getDayShiShenGan() -> String {
        return "日元"
    }

    func getDayShiShenZhi() -> [String] {
        return getShiShenZhi(zhi: getDayZhi())
    }

    func getDayDiShi() -> String {
        return getDiShi(zhiIndex: getDayZhiIndex())
    }

    func getTime() -> String {
        return lunar.getTimeInGanZhi()
    }

    func getTimeGan() -> String {
        return lunar.getTimeGan()
    }

    func getTimeZhi() -> String {
        return lunar.getTimeZhi()
    }

    func getTimeHideGan() -> [String] {
        return LunarUtil.ZHI_HIDE_GAN[getTimeZhi()]!
    }

    func getTimeWuXing() -> String {
        return "\(LunarUtil.WU_XING_GAN[getTimeGan()]!)\(LunarUtil.WU_XING_ZHI[getTimeZhi()]!)"
    }

    func getTimeNaYin() -> String {
        return LunarUtil.NAYIN[getTime()]!
    }

    func getTimeShiShenGan() -> String {
        return LunarUtil.SHI_SHEN_GAN["\(getDayGan())\(getTimeGan())"]!
    }

    func getTimeShiShenZhi() -> [String] {
        getShiShenZhi(zhi: getTimeZhi())
    }

    func getTimeDiShi() -> String {
        getDiShi(zhiIndex: lunar.getTimeZhiIndex())
    }

    func getTaiYuan() -> String {
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

  func getTaiXi() -> String {
      let ganIndex: Int = (genre == 2) ? lunar.getDayGanIndexExact2() : lunar.getDayGanIndexExact();
      let zhiIndex: Int = (genre == 2) ? lunar.getDayZhiIndexExact2() : lunar.getDayZhiIndexExact();
      
    return "\(LunarUtil.HE_GAN_5[ganIndex])\(LunarUtil.HE_ZHI_6[zhiIndex])"
  }

    func getTaiXiNaYin() -> String {
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

    func getMingGongNaYin() -> String {
        return LunarUtil.NAYIN[getMingGong()]!
    }

    func getShenGong() -> String {
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

    func getShenGongNaYin() -> String {
        return LunarUtil.NAYIN[getShenGong()]!
    }

    func getYun(gender: Int, genre: Int = 1) -> Yun {
        return Yun(lunar: lunar, gender: gender, genre: genre)
    }

    func getYearXun() -> String {
        return lunar.getYearXunExact()
    }

    func getYearXunKong() -> String {
        return lunar.getYearXunKongExact()
    }

    func getMonthXun() -> String {
        return lunar.getMonthXunExact()
    }

    func getMonthXunKong() -> String {
        return lunar.getMonthXunKongExact()
    }

    func getDayXun() -> String {
        return genre == 2 ? lunar.getDayXunExact2() : lunar.getDayXunExact()
    }

    func getDayXunKong() -> String {
        return genre == 2 ? lunar.getDayXunKongExact2() : lunar.getDayXunKongExact()
    }

    func getTimeXun() -> String {
        return lunar.getTimeXun()
    }

    func getTimeXunKong() -> String {
        return lunar.getTimeXunKong()
    }

    func toString() -> String {
        return "\(getYear()) \(getMonth()) \(getDay()) \(getTime())"
    }
}
