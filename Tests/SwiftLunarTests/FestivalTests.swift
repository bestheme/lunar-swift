//
//  Festival_test.swift
//  
//
//  Created by 睿宁 on 2022/7/18.
//

import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class FestivalTests: XCTestCase {
    func testFestival() throws {
        let solar1: Solar = Solar(fromYmd: 2020, month: 11, day: 26)
        XCTAssertEqual(solar1.festivals.description, "[\"感恩节\"]")

        let solar2: Solar = Solar(fromYmd: 2020, month: 6, day: 21)
        XCTAssertEqual(solar2.festivals.description, "[\"父亲节\"]")
        
        let solar3: Solar = Solar(fromYmd: 2021, month: 5, day: 9)
        XCTAssertEqual(solar3.festivals.description, "[\"母亲节\"]")
        
        let solar4: Solar = Solar(fromYmd: 1986, month: 11, day: 27)
        XCTAssertEqual(solar4.festivals.description, "[\"感恩节\"]")
        
        let solar5: Solar = Solar(fromYmd: 1985, month: 6, day: 16)
        XCTAssertEqual(solar5.festivals.description, "[\"父亲节\"]")
        
        let solar6: Solar = Solar(fromYmd: 1984, month: 5, day: 13)
        XCTAssertEqual(solar6.festivals.description, "[\"母亲节\"]")
      
    }
    
}
