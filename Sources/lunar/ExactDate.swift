//
//  ExactDate.swift
//  
//
//  Created by 睿宁 on 2022/7/11.
//

import Foundation

//import "utils/SolarUtil.swift"

/// 精确日期
/// @author 6tail
struct ExactDate {
    
    static func fromYmd(year: Int, month: Int, day: Int) -> Date {
        return fromYmdHms(year: year, month: month, day: day, hour: 0, minute: 0, second: 0);
    }
    
    static func fromYmdHms(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date {
        let dc = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone.current, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        return dc.date!
    }
    
    static func fromDate(date: Date) -> Date {
        let dc = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return fromYmdHms(year:
                            dc.year!, month: dc.month!, day: dc.day!, hour: dc.hour!, minute: dc.minute!, second: dc.second!)
    }
    
    /// 获取两个日期之间相差的天数（如果日期a比日期b小，天数为正，如果日期a比日期b大，天数为负）
    ///
    /// @param ay 年a
    /// @param am 月a
    /// @param ad 日a
    /// @param by 年b
    /// @param bm 月b
    /// @param bd 日b
    /// @return 天数
    static func getDaysBetween(ay: Int, am: Int, ad: Int, by: Int, bm: Int, bd: Int) -> Int {
        let calendar = Calendar.current
        let startDate = fromYmd(year: ay, month: am, day: ad)
        let endDate = fromYmd(year: by, month: bm, day: bd)
        let diff:DateComponents = calendar.dateComponents([.day], from: startDate, to: endDate)
        return diff.day!
    }
    
    /// 获取两个日期之间相差的天数（如果日期a比日期b小，天数为正，如果日期a比日期b大，天数为负）
    ///
    /// @param calendar0 日期a
    /// @param calendar1 日期b
    /// @return 天数
    static func getDaysBetweenDate(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let diff:DateComponents = calendar.dateComponents([.day], from: startDate, to: endDate)
        return diff.day!
    }
}
