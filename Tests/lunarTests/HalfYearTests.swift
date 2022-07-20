//
//  HalfYearTests.swift
//
//
//  Created by 睿宁 on 2022/7/19.
//

import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class HalfYearTests: XCTestCase {
    func testHalfYearForFirst() throws {

        let halfYear: SolarHalfYear = SolarHalfYear(year: 2019, month: 5)
        XCTAssertEqual(halfYear.toString(), "2019.1")
        XCTAssertEqual(halfYear.toFullString(), "2019年上半年")
    }
    
    func testHalfYearForSecond() throws {

        let halfYear: SolarHalfYear = SolarHalfYear(year: 2019, month: 5).next(halfYears: 1)
        XCTAssertEqual(halfYear.toString(), "2019.2")
        XCTAssertEqual(halfYear.toFullString(), "2019年下半年")
    }
    
    func testHalfYearForThird() throws {

        let halfYear: SolarHalfYear = SolarHalfYear(year: 2019, month: 5).next(halfYears: -1)
        XCTAssertEqual(halfYear.toString(), "2018.2")
        XCTAssertEqual(halfYear.toFullString(), "2018年下半年")
    }
}
