//
//  ShouXingUtilTests.swift
//  
//
//  Created by 睿宁 on 2022/7/21.
//
import XCTest
@testable import SwiftLunar

@available(macOS 12.0, *)
final class ShouXingUtilTests: XCTestCase {
    func testShouXingUtil() throws {
        let w: Double = -4778.5306 + 29.5306 * 0
        
        XCTAssertEqual(ShouXingUtil.calcShuo(jd: w), -4778)
        
//        let longitude: Double = w + Solar.J2000
//        let sw: Double = floor((longitude + 14 - 2451551) / 29.5306) * (Double.pi * 2)
        
//        XCTAssertEqual(ShouXingUtil.shuoHigh(w: sw), -4778.468923509471)
        
        let shuoHighparam: Double = -1017.8760197630929
        XCTAssertEqual(ShouXingUtil.msaLonT2(w: shuoHighparam), -0.13083645768655663)
        
        XCTAssertEqual(ShouXingUtil.mLon(t: -0.13003072702394278, n: 20), -1088.4037694835754)
    }
    
}
