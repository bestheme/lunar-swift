//
//  BrassMonkeysTests.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class SBrassMonkeysTests: XCTestCase {
    func testBrassMonkeys1() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 21)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "一九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "一九第1天")
    }
}
