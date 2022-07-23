//
//  LiuYaoTests.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class LiuYaoTests: XCTestCase {
    func testLiuYao1() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 4, day: 23)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "佛灭")
      }

    func testLiuYao2() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 1, day: 15)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "友引")
      }

    func testLiuYao3() throws {
        let solar: Solar = Solar(fromYmd: 2017, month: 1, day: 5)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "先胜")
      }

    func testLiuYao4() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 4, day: 10)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "友引")
      }

    func testLiuYao5() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 6, day: 11)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "大安")
      }

    func testLiuYao6() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 6, day: 1)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "先胜")
      }

    func testLiuYao7() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 8)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "先负")
      }

    func testLiuYao8() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 11)
        let lunar: Lunar = solar.getLunar()
        XCTAssertEqual(lunar.getLiuYao(), "赤口")
      }
}
