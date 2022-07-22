//
//  BuddhistFestival.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
/// 佛历因果犯忌
/// @author 6tail
struct BuddhistFestival {
  /// 是日何日，如：雷斋日
    var name: String?

  /// 犯之因果，如：犯者夺纪
    var result: String?

  /// 是否每月同
    var everyMonth: Bool?

  /// 备注，如：宜先一日即戒
    var remark: String?

    init(name: String, result: String = "", everyMonth: Bool = false, remark: String = "") {
        self.name = name;
        self.result = result
        self.everyMonth = everyMonth
        self.remark = remark
  }

    func isEveryMonth() -> Bool {
        return everyMonth!
    }

    func toString() -> String {
        return "\(name!)"
    }
    
    func toFullString() -> String {
        var s: String = "\(name!)"
        if (nil != result && result!.count > 0) {
            s += " ";
            s += result!
        }
        if (nil != remark && remark!.count > 0) {
            s += " "
            s += remark!
        }
        return s
    }
}
