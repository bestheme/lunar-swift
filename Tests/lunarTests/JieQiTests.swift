//
//  JieQiTests.swift
//  
//
//  Created by 睿宁 on 2022/7/20.
//
import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class JieQiTests: XCTestCase {
    func testLunar() throws {
        let solar = Solar(fromYmd: 1986, month: 1, day: 5)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getJie(), "小寒")
    }
}
