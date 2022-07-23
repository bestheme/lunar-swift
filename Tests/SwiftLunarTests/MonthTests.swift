//
//  MonthTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class MonthTests: XCTestCase {
    func testMonthForFirst() throws {
        let month: SolarMonth = SolarMonth(year: 2019, month: 5)
        XCTAssertEqual(month.toString(), "2019-5")
        XCTAssertEqual(month.toFullString(), "2019年5月")
    }
    
    func testMonthForSecond() throws {
        let month: SolarMonth = SolarMonth(year: 2019, month: 5).next(quantity: 1)
        XCTAssertEqual(month.toString(), "2019-6")
        XCTAssertEqual(month.toFullString(), "2019年6月")
    }
    
    func testMonthForThird() throws {
        let month: SolarMonth = SolarMonth(year: 2022, month: 1).next(quantity: -14)
        XCTAssertEqual(month.toString(), "2020-11")
        XCTAssertEqual(month.toFullString(), "2020年11月")
    }
    
    func testMonthForfourth() throws {
        let month: SolarMonth = SolarMonth(year: 2020, month: 11).next(quantity: 14)
        XCTAssertEqual(month.toString(), "2022-1")
        XCTAssertEqual(month.toFullString(), "2022年1月")
    }
}
