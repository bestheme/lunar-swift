//
//  JulianDay_test.swift
//
//
//  Created by 睿宁 on 2022/7/18.
//

import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class testJulianDay: XCTestCase {
    func testJulianDay() throws {
        let solar11: Solar = Solar(fromYmd: 2020, month: 7, day: 15)
        XCTAssertEqual(solar11.julianDay, 2459045.5)

        let solar12: Solar = Solar(fromJulianDay: 2459045.5)
        XCTAssertEqual(solar12.toYmdHms(), "2020-07-15 00:00:00")
        
        let solar21: Solar = Solar(fromYmdHms: 9999, month: 12, day: 30, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar21.julianDay, 5373483.0)
        
        let solar22: Solar = Solar(fromJulianDay: 5373483.0)
        XCTAssertEqual(solar22.toYmdHms(), "9999-12-30 12:00:00")
        
        let solar31: Solar = Solar(fromYmdHms: 1905, month: 2, day: 4, hour: 12, minute: 0, second: 0)
        XCTAssertEqual(solar31.julianDay, 2416881.0)
        
        let solar32: Solar = Solar(fromJulianDay: 2416881.0)
        XCTAssertEqual(solar32.toYmdHms(), "1905-02-04 12:00:00")
    }
    
}
