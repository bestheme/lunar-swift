//
//  BrassMonkeys.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
// 数九
// Brass Monkeys

struct BrassMonkeys {
  /// 名称，如一九、二九
    var name: String;

  /// 当前数九第几天，1-9
    var index: Int = 1;

  func toString() -> String{
    return "\(name)"
  }

  func toFullString() -> String {
    return "\(name)第\(index)天"
  }
}
