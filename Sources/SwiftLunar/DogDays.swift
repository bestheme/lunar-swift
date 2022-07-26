//
//  File.swift
//  
//
//  Created by 睿宁 on 2022/7/21.
//
// Dog days
// <p>从夏至后第3个庚日算起，初伏为10天，中伏为10天或20天，末伏为10天。当夏至与立秋之间出现4个庚日时中伏为10天，出现5个庚日则为20天。</p>

public struct DogDays {
    /// 名称：初伏、中伏、末伏
    public var name: String?;
    
    /// 当前入伏第几天，1-20
    public var index: Int = 1;
    
    public func toString() -> String{
        return "\(name ?? "")"
    }
    
    public func toFullString() -> String {
        return "\(name ?? "")第\(index)天"
    }
}
