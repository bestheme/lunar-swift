//
//  SolarHalfYear.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
import Foundation

// 阳历半年

@available(macOS 12.0, *)
struct SolarHalfYear {
    /// 半年的月数
    static let MONTH_COUNT: Int = 6;
    
    /// 年
    var year: Int = 0;
    
    /// 月
    var month: Int = 0;
    
    var index: Int {
        get {
            Int(ceil(Double(month) * 1.0 / Double(SolarHalfYear.MONTH_COUNT)))
        }
    }
    
    var months: [SolarMonth] {
        get {
            var l: [SolarMonth] = []
            let newIndex = self.index - 1
            for i in 0..<SolarHalfYear.MONTH_COUNT {
                l.append(SolarMonth(year: year, month: SolarHalfYear.MONTH_COUNT * newIndex + i + 1))
            }
            return l
        }
    }
    
//    var next: SolarHalfYear {
//        get(halfYears: Int) {
//            if ha
//        }
//    }

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    init(date: Date = Date()) {
        year = date.get(.year)
        month = date.get(.day)
    }
    

//  List<SolarMonth> getMonths() {
//    List<SolarMonth> l = <SolarMonth>[];
//    int index = getIndex() - 1;
//    for (int i = 0; i < MONTH_COUNT; i++) {
//      l.add(SolarMonth.fromYm(_year, MONTH_COUNT * index + i + 1));
//    }
//    return l;
//  }

    func next(halfYears: Int) -> SolarHalfYear {
        if (0 == halfYears) {
            return SolarHalfYear(year: year, month: month);
        } else {
            var rest: Int = halfYears * SolarHalfYear.MONTH_COUNT;
            var y: Int = year;
            y += Int(rest / 12)
            rest = rest % 12;
            var m: Int = month + rest;
            if (m > 12) {
                y += 1;
                m -= 12;
            } else if (m < 1) {
                y -= 1;
                m += 12;
            }
            return SolarHalfYear(year: y, month: m);
        }
    }

  func toString() -> String {
    return "\(year).\(index)"
  }

  func toFullString() -> String {
    return "\(year)年\(index == 1 ? "上" : "下")半年"
  }
}

