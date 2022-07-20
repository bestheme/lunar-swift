//
//  JulianDay_test.swift
//
//
//  Created by 睿宁 on 2022/7/18.
//

import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class JulianDayTests: XCTestCase {
    func testJulianDay() throws {
        let solar1: Solar = Solar(fromYmd: 2020, month: 7, day: 15)
        XCTAssertEqual(solar1.julianDay, 2459045.5)

        let solar2: Solar = Solar(fromJulianDay: 2459045.5)
        XCTAssertEqual(solar2.toYmdHms(), "2020/07/15 00:00:00")
      
    }
    
}
