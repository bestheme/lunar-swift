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
    
    static func fromYmd(year: Int, month: Int, day: Int) -> DateComponents {
        return fromYmdHms(year: year, month: month, day: day, hour: 0, minute: 0, second: 0);
    }
    
    static func fromYmdHms(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> DateComponents {
        let dc = DateComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        return dc
    }
    
    static func fromDate(date: DateComponents) -> DateComponents {
        return fromYmdHms(year:
                            date.year!, month: date.month!, day: date.day!, hour: date.hour!, minute: date.minute!, second: date.second!)
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
