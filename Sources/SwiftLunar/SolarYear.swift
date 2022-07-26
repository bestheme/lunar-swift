//
//  SolarYear.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//
import Foundation
// 阳历年

@available(iOS 15.0, *)
@available(macOS 12.0, *)
struct SolarYear {
  /// 一年的月数
    static let MONTH_COUNT: Int = 12;

  /// 年
    var year: Int = 0;

    init(year: Int) {
        self.year = year
    }
    
    init(date: Date = Date()) {
        self.year = ExactDate.fromDate(date: date).get(.year)
    }
    
//  SolarYear() : this.fromDate(DateTime.now());
//
//  SolarYear.fromYear(int year) {
//    _year = year;
//  }
//
//  SolarYear.fromDate(DateTime date) {
//    _year = ExactDate.fromDate(date).year;
//  }

//  int getYear() => _year;

  func getMonths() -> [SolarMonth] {
      var l: [SolarMonth] = []
      let m: SolarMonth = SolarMonth(year: year, month: 1)
      l.append(m);
      for i in 1..<SolarYear.MONTH_COUNT {
          l.append(m.next(quantity: i))
    }
    return l
  }

    func next(quantity: Int) -> SolarYear {
        return SolarYear(year: year + quantity)
    }

  
    func toString() -> String {
        return "\(year)"
    }

    func toFullString() -> String {
        return "\(year)年"
    }
}
