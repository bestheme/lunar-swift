//
//  ConstellationTests.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class ConstellationTests: XCTestCase {
    
    func testConstellation1() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 3, day: 21)
        XCTAssertEqual(solar.constellation, "白羊")
    }
    
    func testConstellation2() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 4, day: 19)
        XCTAssertEqual(solar.constellation, "白羊")
    }
    
    func testConstellation3() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 4, day: 20)
        XCTAssertEqual(solar.constellation, "金牛")
    }
    
    func testConstellation4() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 5, day: 20)
        XCTAssertEqual(solar.constellation, "金牛")
    }
    
    func testConstellation5() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 5, day: 21)
        XCTAssertEqual(solar.constellation, "双子")
    }
    
    func testConstellation6() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 6, day: 21)
        XCTAssertEqual(solar.constellation, "双子")
    }
    
    func testConstellation7() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 6, day: 22)
        XCTAssertEqual(solar.constellation, "巨蟹")
    }
    
    func testConstellation8() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 7, day: 22)
        XCTAssertEqual(solar.constellation, "巨蟹")
    }
    
    func testConstellation9() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 7, day: 23)
        XCTAssertEqual(solar.constellation, "狮子")
    }
    
    func testConstellation10() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 8, day: 22)
        XCTAssertEqual(solar.constellation, "狮子")
    }
    
    func testConstellation11() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 8, day: 23)
        XCTAssertEqual(solar.constellation, "处女")
    }
    
    func testConstellation12() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 9, day: 22)
        XCTAssertEqual(solar.constellation, "处女")
    }
    
    func testConstellation13() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 9, day: 23)
        XCTAssertEqual(solar.constellation, "天秤")
    }
    
    func testConstellation14() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 10, day: 23)
        XCTAssertEqual(solar.constellation, "天秤")
    }
    
    func testConstellation15() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 10, day: 24)
        XCTAssertEqual(solar.constellation, "天蝎")
    }
    
    func testConstellation16() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 11, day: 22)
        XCTAssertEqual(solar.constellation, "天蝎")
    }
    
    func testConstellation17() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 11, day: 23)
        XCTAssertEqual(solar.constellation, "射手")
    }
    
    func testConstellation18() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 21)
        XCTAssertEqual(solar.constellation, "射手")
    }
    
    func testConstellation19() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 12, day: 22)
        XCTAssertEqual(solar.constellation, "摩羯")
    }
    
    func testConstellation20() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 1, day: 19)
        XCTAssertEqual(solar.constellation, "摩羯")
    }
    
    func testConstellation21() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 1, day: 20)
        XCTAssertEqual(solar.constellation, "水瓶")
    }
    
    func testConstellation22() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 2, day: 18)
        XCTAssertEqual(solar.constellation, "水瓶")
    }
    
    func testConstellation23() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 2, day: 19)
        XCTAssertEqual(solar.constellation, "双鱼")
    }
    
    func testConstellation24() throws {
        let solar: Solar = Solar(fromYmd: 2021, month: 3, day: 20)
        XCTAssertEqual(solar.constellation, "双鱼")
    }
}
