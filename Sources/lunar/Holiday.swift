//
//  Holiday.swift
//  
//
//  Created by 睿宁 on 2022/7/12.
//

import Foundation

//节假日
//@author 6tail
struct Holiday {
//  日期，YYYY/MM/DD格式
    var day: String?

//  名称，如：国庆
    var name: String?

//  是否调休，即是否要上班
    var isWork: Bool = false

//  关联的节日，YYYY/MM/DD格式
    var target: String?

    init(day: String, name: String, work: Bool, target: String) {
//    if (!day.contains('-')) {
//      day = day.substring(0, 4) +
//          '-' +
//          day.substring(4, 6) +
//          '-' +
//          day.substring(6);
//    } else {
        self.day = day
//    }
        self.name = name
        self.isWork = work
//    if (!target.contains('-')) {
//      _target = target.substring(0, 4) +
//          '-' +
//          target.substring(4, 6) +
//          '-' +
//          target.substring(6);
//    } else {
        self.target = target
//    }
  }

//  String getDay() => _day!;

//  void setDay(String day) {
//    _day = day;
//  }

//  String getName() => _name!;
//
//  void setName(String name) {
//    _name = name;
//  }

//  bool isWork() => _work;
//
//  void setWork(bool work) {
//    _work = work;
//  }

//  String getTarget() => _target!;
//
//  void setTarget(String target) {
//    _target = target;
//  }

  
  func toString() -> String {
      return "\(String(describing: day)) \(String(describing: name))\((isWork) ? "调休" : "") \(String(describing: target))"
  }
}
