//
//  LiuNian.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
/// 流年
/// @author 6tail
@available(macOS 12.0, *)
struct LiuNian {
    /// 序数，0-9
    var index: Int = 0 {
        didSet {
            year = daYun!.startYear + index
            age = daYun!.startAge + index
        }
    }
    
    /// 年
    var year: Int = 0;
    
    /// 年龄
    var age: Int = 0;
    
    /// 大运
    var daYun: DaYun? {
        didSet {
            lunar = daYun!.lunar!
            year = daYun!.startYear + index
            age = daYun!.startAge + index
        }
    }
    
    /// 阴历
    var lunar: Lunar?

    init(daYun: DaYun, index: Int) {
      self.daYun = daYun
      self.index = index
  }

    func getMonthInChinese() -> String {
        return LunarUtil.MONTH[index + 1]
    }

//  int getIndex() => _index;
//
//  int getYear() => _year;
//
//  int getAge() => _age;

    func getGanZhi() -> String {
        // 干支与出生日期和起运日期都没关系
        var offset: Int = LunarUtil.getJiaZiIndex(ganZhi: lunar!.getJieQiTable()["立春"]!.getLunar().getYearInGanZhiExact()) + index;
        if (daYun!.index > 0) {
            offset += daYun!.startAge - 1;
        }
        offset %= LunarUtil.JIA_ZI.count;
        return LunarUtil.JIA_ZI[offset];
    }

    func getXun() -> String {
        return LunarUtil.getXun(ganZhi: getGanZhi())
    }

    func getXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getGanZhi())
    }

    func getLiuYue() -> [LiuYue] {
        let n: Int = 12
        var l: [LiuYue] = []
        for i in 0..<n {
            l.append(LiuYue(index: i, liuNian: self))
        }
        return l;
    }
}
