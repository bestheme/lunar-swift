//
//  XiaoYun.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
// 小运
@available(watchOS 8.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct XiaoYun {
    /// 序数，0-9
    public var index: Int = 0 {
        didSet {
            year = daYun!.startYear + index
            age = daYun!.startAge + index
        }
    }
    
    /// 年
    public var year: Int = 0
    
    /// 年龄
    public var age: Int = 0
    
    /// 是否顺推
    var isGoWith: Bool = false
    
    /// 大运
    public var daYun: DaYun? {
        didSet {
            lunar = daYun!.lunar
            year = daYun!.startYear + index
            age = daYun!.startAge + index
        }
    }
    
    /// 阴历
    public var lunar: Lunar?
    
    public init(daYun: DaYun, index: Int, isGoWith: Bool) {
        self.daYun = daYun
        self.index = index
        self.isGoWith = isGoWith
        self.year = daYun.startYear + index
        self.age = daYun.startAge + index
        self.lunar = daYun.lunar
    }
    
    //  XiaoYun(DaYun daYun, int index, bool forward) {
    //    _daYun = daYun;
    //    _lunar = daYun.getLunar();
    //    _index = index;
    //    _year = daYun.getStartYear() + index;
    //    _age = daYun.getStartAge() + index;
    //    _forward = forward;
    //  }
    //
    //  int getIndex() => _index;
    //
    //  int getYear() => _year;
    //
    //  int getAge() => _age;
    
    public func getGanZhi() -> String {
        var offset: Int = LunarUtil.getJiaZiIndex(ganZhi: lunar!.getTimeInGanZhi());
        var add: Int  = index + 1;
        if (daYun!.index > 0) {
            add += daYun!.startAge - 1;
        }
        offset += isGoWith ? add : -add;
        let size: Int = LunarUtil.JIA_ZI.count;
        while (offset < 0) {
            offset += size;
        }
        offset %= size;
        return LunarUtil.JIA_ZI[offset];
    }
    
    public func getXun() -> String {
        return  LunarUtil.getXun(ganZhi: getGanZhi())
    }
    
    public func getXunKong() -> String {
        return  LunarUtil.getXunKong(ganZhi: getGanZhi())
    }
}
