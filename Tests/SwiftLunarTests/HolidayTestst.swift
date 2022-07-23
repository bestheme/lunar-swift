//
//  Holiday_test.swift
//  
//
//  Created by 睿宁 on 2022/7/18.
//

import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class HolidayTests: XCTestCase {
    @available(macOS 13.0, *)
    func testHoliday() throws {
        let holiday: Holiday? = HolidayUtil.getHoliday(ymd: "2010-01-01")
//        let solar1: Solar = Solar(fromYmd: 2020, month: 11, day: 26)
        XCTAssertEqual(holiday!.name, "元旦节")
        
//        HolidayUtil.fix
    }
}
