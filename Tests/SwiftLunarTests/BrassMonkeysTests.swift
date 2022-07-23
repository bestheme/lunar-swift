//
//  BrassMonkeysTests.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class SBrassMonkeysTests: XCTestCase {
    func testBrassMonkeys1() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 21)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "一九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "一九第1天")
    }
    
    func testBrassMonkeys2() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 22)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "一九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "一九第2天")
    }
    
    func testBrassMonkeys3() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 1, day: 7)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "二九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "二九第8天")
    }
    
    func testBrassMonkeys4() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 1, day: 6)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "二九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "二九第8天")
    }
    
    func testBrassMonkeys5() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 1, day: 8)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "三九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "三九第1天")
    }
    
    func testBrassMonkeys6() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 3, day: 5)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertEqual(brassMonkeys!.toString(), "九九")
        XCTAssertEqual(brassMonkeys!.toFullString(), "九九第3天")
    }
    
    func testBrassMonkeys7() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 7, day: 5)
        let lunar: Lunar = solar.getLunar()
        let brassMonkeys: BrassMonkeys? = lunar.getBrassMonkeys()
        XCTAssertNil(brassMonkeys)
    }
}
