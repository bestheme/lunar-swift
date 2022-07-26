//
//  SolarMonth.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
import Foundation

// 阳历月

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct SolarMonth {
    /// 年
    public var year: Int = 0;
    
    /// 月
    public var month: Int = 0;
    
    public var days: [Solar] {
        get {
            var l: [Solar] = [];
            let d: Solar = Solar(fromYmd: year, month: month, day: 1)
            l.append(d)
            let days: Int = SolarUtil.getDaysOfMonth(year: year, month: month);
            for i in 1..<days {
                l.append(d.next(days: i))
            }
            return l
        }
    }
    
    public init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    public init(date: Date = Date()) {
        year = date.get(.year)
        month = date.get(.month)
    }
    
    //  SolarMonth() : this.fromDate(DateTime.now());
    
    //  SolarMonth.fromYm(int year, int month) {
    //    _year = year;
    //    _month = month;
    //  }
    
    //  SolarMonth.fromDate(DateTime date) {
    //    DateTime c = ExactDate.fromDate(date);
    //    _year = c.year;
    //    _month = c.month;
    //  }
    
    //  int getYear() => _year;
    
    //  int getMonth() => _month;
    
    //  List<Solar> getDays() {
    //    List<Solar> l = <Solar>[];
    //    Solar d = new Solar.fromYmd(_year, _month, 1);
    //    l.add(d);
    //    int days = SolarUtil.getDaysOfMonth(_year, _month);
    //    for (int i = 1; i < days; i++) {
    //      l.add(d.next(i));
    //    }
    //    return l;
    //  }
    
    public func next(quantity: Int) -> SolarMonth {
        if (0 == quantity) {
            return SolarMonth(year: year, month: month);
        } else {
            var rest: Int = quantity
            var y: Int = year;
            y += Int(rest / 12);
            rest = rest % 12;
            var m: Int = month + rest;
            if (m > 12) {
                y += 1;
                m -= 12;
            } else if (m < 1) {
                y -= 1;
                m += 12;
            }
            return SolarMonth(year: y, month: m);
        }
    }
    
    
    public func toString() -> String {
        return "\(year)-\(month)"
    }
    
    public func toFullString() -> String {
        return "\(year)年\(month)月"
    }
}
