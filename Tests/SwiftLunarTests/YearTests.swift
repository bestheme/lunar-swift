//
//  YearTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//

//
//  SolarWeekTests.swift
//
//
//  Created by 睿宁 on 2022/7/20.
//

import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class YearTests: XCTestCase {
    func testYearForFirst() throws {
        let year: SolarYear = SolarYear(year: 2019)
        XCTAssertEqual(year.toString(), "2019")
        XCTAssertEqual(year.toFullString(), "2019年")
    }
    
    func testYearForSecond() throws {
        let year: SolarYear = SolarYear(year: 2019).next(quantity: 1)
        XCTAssertEqual(year.toString(), "2020")
        XCTAssertEqual(year.toFullString(), "2020年")
    }
}



