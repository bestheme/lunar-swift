//
//  JieQI.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
/// 节气
/// @author 6tail
@available(macOS 12.0, *)
struct JieQi {
    static let JIE_QI: [String] = [
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
        "大雪"
    ];
    
    /// 名称
    var name: String? {
        didSet {
            for i in 0..<JieQi.JIE_QI.count {
                if name == JieQi.JIE_QI[i] {
                    if (i % 2 == 0) {
                        isQi = true;
                    } else {
                        isJie = true;
                    }
                }
            }
        }
    }
    
    /// 阳历日期
    var solar: Solar?;
    
    /// 是否节令
    var isJie: Bool = false
    
    /// 是否气令
    var isQi: Bool = false;
    
    init(name: String, solar: Solar) {
        self.name = name
        self.solar = solar
    }

//  String getName() => _name!;

//  void setName(String name) {
//    _name = name;
//    for (int i = 0, j = JIE_QI.length; i < j; i++) {
//      if (name == JIE_QI[i]) {
//        if (i % 2 == 0) {
//          _qi = true;
//        } else {
//          _jie = true;
//        }
//        return;
//      }
//    }
//  }

//  Solar getSolar() => _solar!;

//  void setSolar(Solar solar) {
//    _solar = solar;
//  }

//  bool isJie() => _jie;
//
//  bool isQi() => _qi;

    func toString() -> String {
        return "\(String(describing: name))";
    }
}

