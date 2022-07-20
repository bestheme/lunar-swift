//
//  DaYun.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
/// 大运
/// @author 6tail
@available(macOS 12.0, *)
struct DaYun {
    /// 开始年(含)
    var startYear: Int = 0
    
    /// 结束年(含)
    var endYear: Int = 0
    
    /// 开始年龄(含)
    var startAge: Int = 0
    
    /// 结束年龄(含)
    var endAge: Int = 0
    
    /// 序数，0-9
    var index: Int = 0 {
        didSet {
            calcProperties(yun: yun!, index: index)
        }
    }
    
    /// 运
    var yun: Yun? {
        didSet {
            calcProperties(yun: yun!, index: index)
        }
    }
    
    /// 阴历
    var lunar: Lunar?
    
    init(yun: Yun, index: Int) {
        self.yun = yun
        self.index = index
    }
    
    mutating func calcProperties(yun: Yun, index: Int) {
        //    _yun = yun;
        self.lunar = yun.lunar
        //    _index = index;
        let birthYear: Int = lunar!.getSolar().year;
        let year: Int = yun.getStartSolar().year;
        if (index < 1) {
            startYear = birthYear;
            startAge = 1;
            endYear = year - 1;
            endAge = year - birthYear;
        } else {
            let add: Int = (index - 1) * 10;
            startYear = year + add;
            startAge = startYear - birthYear + 1;
            endYear = startYear + 9;
            endAge = startAge + 9;
        }
    }
    
    //  int getStartYear() => _startYear;
    //
    //  int getEndYear() => _endYear;
    //
    //  int getStartAge() => _startAge;
    //
    //  int getEndAge() => _endAge;
    //
    //  int getIndex() => _index;
    //
    //  Lunar getLunar() => _lunar!;
    
    func getGanZhi() -> String {
        if (index < 1) {
            return ""
        }
        var offset: Int = LunarUtil.getJiaZiIndex(ganZhi: lunar!.getMonthInGanZhiExact());
        offset += yun!.isGoWith ? index : -index;
        let size: Int = LunarUtil.JIA_ZI.count;
        if (offset >= size) {
            offset -= size
        }
        if (offset < 0) {
            offset += size
        }
        return LunarUtil.JIA_ZI[offset];
    }
    
    func getXun() -> String {
        return LunarUtil.getXun(ganZhi: getGanZhi())
    }
    
    func getXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getGanZhi())
    }

  /// 获取10轮流年
  func getLiuNian() -> [LiuNian] {
      return getLiuNianBy(n: 10)
  }

  /// 获取流年
  /// [n] 轮数
func getLiuNianBy(n: Int) -> [LiuNian] {
    var num: Int = n
    if (index < 1) {
      num = endYear - startYear + 1
    }
        var l: [LiuNian] = [];
        for i in 0..<num  {
            l.append(LiuNian(daYun: self, index: i))
    }
    return l;
  }

  /// 获取10轮小运
  func getXiaoYun() -> [XiaoYun] {
      return getXiaoYunBy(n: 10);
  }

  /// 获取小运
  /// [n] 轮数
    func getXiaoYunBy(n: Int) -> [XiaoYun]  {
        var num: Int = n
    if (index < 1) {
      num = endYear - startYear + 1;
    }
        var l: [XiaoYun] = [];
        for i in 0..<num {
            l.append(XiaoYun(daYun: self, index: i, isGoWith: yun!.isGoWith));
    }
    return l;
  }
}
