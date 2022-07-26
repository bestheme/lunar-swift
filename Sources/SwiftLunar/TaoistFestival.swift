//
//  File.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
/// 道历节日
struct TaoistFestival {
    /// 名称
    var name: String
    
    /// 备注
    var remark: String
    
    init(name: String, remark: String = "") {
        self.name = name;
        self.remark = remark
    }
    
    func toString() -> String {
        return name
    }
    
    func toFullString() -> String {
        var s: String = name
        if (remark.count > 0) {
            s += "["
            s += remark
            s += "]"
        }
        return s
    }
}

