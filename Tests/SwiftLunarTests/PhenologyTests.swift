//
//  PhenologyTests.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class PhenologyTests: XCTestCase {
    func testPhenology1() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 4, day: 23);
        let lunar: Lunar = solar.getLunar();
        XCTAssertEqual(lunar.getPhenology(), "萍始生")
    }
    
    func testPhenology2() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 1, day: 15);
        let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "雉始雊");
     }

     func testPhenology3() throws {
         let solar: Solar = Solar(fromYmd: 2017, month: 1, day: 5);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "雁北乡");
     }

     func testPhenology4() throws {
         let solar: Solar = Solar(fromYmd: 2020, month: 4, day: 10);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "田鼠化为鴽");
     }

     func testPhenology5() throws {
         let solar: Solar = Solar(fromYmd: 2020, month: 6, day: 11);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "鵙始鸣");
     }

     func testPhenology6() throws {
         let solar: Solar = Solar(fromYmd: 2020, month: 6, day: 1);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "麦秋至");
     }

     func testPhenology7() throws {
         let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 8);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "鹖鴠不鸣");
     }

     func testPhenology8() throws {
         let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 11);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "鹖鴠不鸣");
     }

     func testPhenology9() throws {
         let solar: Solar = Solar(fromYmd: 1982, month: 12, day: 22);
         let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getPhenology(), "蚯蚓结");
     }

    func testPhenology10() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 12, day: 21);
        let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getSeasonality(), "冬至 初候");
     }

    func testPhenology11() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 12, day: 26);
        let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getSeasonality(), "冬至 二候");
     }

    func testPhenology12() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 12, day: 31);
        let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getSeasonality(), "冬至 三候");
     }

    func testPhenology() throws {
        let solar: Solar = Solar(fromYmd: 2022, month: 1, day: 5);
        let lunar: Lunar = solar.getLunar();
       XCTAssertEqual(lunar.getSeasonality(), "小寒 初候");
     }
}
