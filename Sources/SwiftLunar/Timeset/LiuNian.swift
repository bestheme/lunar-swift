//
//  LiuNian.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
// Running years
@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct LiuNian {
    /// 序数，0-9
    public var index: Int = 0 {
        didSet {
            year = daYun!.startYear + index
            age = daYun!.startAge + index
        }
    }
    
    /// 年
    public var year: Int = 0;
    
    /// 年龄
    public var age: Int = 0;
    
    /// 大运
    public var daYun: DaYun? {
        didSet {
            lunar = daYun!.lunar!
            year = daYun!.startYear + index
            age = daYun!.startAge + index
        }
    }
    
    /// 阴历
    public var lunar: Lunar?

    public init(daYun: DaYun, index: Int) {
      self.daYun = daYun
      self.index = index
  }

    public func getMonthInChinese() -> String {
        return LunarUtil.MONTH[index + 1]
    }

//  int getIndex() => _index;
//
//  int getYear() => _year;
//
//  int getAge() => _age;

    public func getGanZhi() -> String {
        // 干支与出生日期和起运日期都没关系
        var offset: Int = LunarUtil.getJiaZiIndex(ganZhi: lunar!.getJieQiTable()["立春"]!.getLunar().getYearInGanZhiExact()) + index;
        if (daYun!.index > 0) {
            offset += daYun!.startAge - 1;
        }
        offset %= LunarUtil.JIA_ZI.count;
        return LunarUtil.JIA_ZI[offset];
    }

    public func getXun() -> String {
        return LunarUtil.getXun(ganZhi: getGanZhi())
    }

    public func getXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getGanZhi())
    }

    public func getLiuYue() -> [LiuYue] {
        let n: Int = 12
        var l: [LiuYue] = []
        for i in 0..<n {
            l.append(LiuYue(index: i, liuNian: self))
        }
        return l;
    }
}
