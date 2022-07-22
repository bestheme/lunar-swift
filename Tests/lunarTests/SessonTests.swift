//
//  SessonTests.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//

import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class SessonTests: XCTestCase {
    func testSession1() throws {
        let sesson: SolarSeason = SolarSeason(year: 2019, month: 5)
        XCTAssertEqual(sesson.toString(), "2019.2")
        XCTAssertEqual(sesson.toFullString(), "2019年2季度")
    }
    
    func testSession2() throws {
        let sesson: SolarSeason = SolarSeason(year: 2019, month: 5).next(seasons: 1)
        XCTAssertEqual(sesson.toString(), "2019.3")
        XCTAssertEqual(sesson.toFullString(), "2019年3季度")
    }
    
    func testSession3() throws {
        let sesson: SolarSeason = SolarSeason(year: 2019, month: 5).next(seasons: -2)
        XCTAssertEqual(sesson.toString(), "2018.4")
        XCTAssertEqual(sesson.toFullString(), "2018年4季度")
    }
}
