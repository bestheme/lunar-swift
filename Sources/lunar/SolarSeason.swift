//
//  SolarSeason.swift
//  
//
//  Created by 睿宁 on 2022/7/21.
//
import Foundation

@available(macOS 12.0, *)
struct SolarSeason {
    /// 一季度的月数
    static let MONTH_COUNT: Int = 3;
    
    /// 年
    var year: Int = 0;
    
    /// 月
    var month: Int = 0;
    
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    init(fromDate date: Date) {
        self.year = date.get(.year);
        self.month = date.get(.month)
    }
    
    var index: Int {
        get {
            return Int(ceil(Double(month) * 1.0 / Double(SolarSeason.MONTH_COUNT)))
        }
    }
    
    var months: [SolarMonth] {
        get {
            var months: [SolarMonth] = []
            let index = index - 1
            for i in 0..<SolarSeason.MONTH_COUNT {
                months.append(SolarMonth(year: year, month: SolarSeason.MONTH_COUNT * index + i + 1))
            }
            return months
        }
    }
    
    func next(seasons: Int) -> SolarSeason {
        if (0 == seasons) {
            return self;
        } else {
            var rest: Int = seasons * SolarSeason.MONTH_COUNT
            var y: Int = year
            y += Int(floor(Double(rest) / 12))
            rest = abs(rest % 12);
            var m: Int = month + rest
            if (m > 12) {
                y += 1
                m -= 12
            } else if (m < 1) {
                y -= 1
                m += 12
            }
            return SolarSeason(year: y, month: m);
        }
    }
    
    func toString() -> String {
        return "\(year).\(index)"
    }
    
    func toFullString() -> String {
        return "\(year)年\(index)季度"
    }
}
