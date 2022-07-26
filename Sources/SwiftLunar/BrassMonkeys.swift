//
//  BrassMonkeys.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
// 数九
// Brass Monkeys

public struct BrassMonkeys {
    /// 名称，如一九、二九
    public var name: String;
    
    /// 当前数九第几天，1-9
    public var index: Int = 1;
    
    public func toString() -> String{
        return "\(name)"
    }
    
    public func toFullString() -> String {
        return "\(name)第\(index)天"
    }
}
