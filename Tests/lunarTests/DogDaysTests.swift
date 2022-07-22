//
//  File.swift
//  
//
//  Created by 睿宁 on 2022/7/21.
//
import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class DogDaysTests: XCTestCase {
    func testDogDays1() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 7, day: 14)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "初伏")
        XCTAssertEqual(dogDays!.toFullString(), "初伏第1天")
    }
    
    func testDogDays2() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 7, day: 23)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "初伏")
        XCTAssertEqual(dogDays!.toFullString(), "初伏第10天")
    }
    
    func testDogDays3() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 7, day: 24)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "中伏")
        XCTAssertEqual(dogDays!.toFullString(), "中伏第1天")
    }
    
    func testDogDays4() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 8, day: 12)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "中伏")
        XCTAssertEqual(dogDays!.toFullString(), "中伏第20天")
    }
    
    func testDogDays5() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 8, day: 13)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "末伏")
        XCTAssertEqual(dogDays!.toFullString(), "末伏第1天")
    }
    
    func testDogDays6() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 8, day: 22)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "末伏")
        XCTAssertEqual(dogDays!.toFullString(), "末伏第10天")
    }
    
    func testDogDays7() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 7, day: 13)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertNil(dogDays)
    }
    
    func testDogDays8() throws {
        let solar: Solar = Solar(fromYmd: 2011, month: 8, day: 23)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertNil(dogDays)
    }
    
    func testDogDays9() throws {
        let solar: Solar = Solar(fromYmd: 2012, month: 7, day: 18)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "初伏")
        XCTAssertEqual(dogDays!.toFullString(), "初伏第1天")
    }
    
    func testDogDays10() throws {
        let solar: Solar = Solar(fromYmd: 2012, month: 8, day: 5)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "中伏")
        XCTAssertEqual(dogDays!.toFullString(), "中伏第9天")
    }
    
    func testDogDays11() throws {
        let solar: Solar = Solar(fromYmd: 2012, month: 8, day: 8)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "末伏")
        XCTAssertEqual(dogDays!.toFullString(), "末伏第2天")
    }
    
    func testDogDays12() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 7, day: 17)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "初伏")
        XCTAssertEqual(dogDays!.toFullString(), "初伏第2天")
    }
    
    func testDogDays13() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 7, day: 26)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "中伏")
        XCTAssertEqual(dogDays!.toFullString(), "中伏第1天")
    }
    
    func testDogDays14() throws {
        let solar: Solar = Solar(fromYmd: 2020, month: 8, day: 24)
        let lunar: Lunar = solar.getLunar()
        let dogDays: DogDays? = lunar.getDogDays()
        XCTAssertEqual(dogDays!.toString(), "末伏")
        XCTAssertEqual(dogDays!.toFullString(), "末伏第10天")
    }
}
