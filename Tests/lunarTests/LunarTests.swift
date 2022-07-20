import XCTest
@testable import lunar

@available(macOS 12.0, *)
final class LunarTests: XCTestCase {
    func testLunar() throws {
        let lunar: Lunar = Lunar(fromYmdHms: 2019, lunarMonth: 3, lunarDay: 27, hour: 0, minute: 0, second: 0)
        XCTAssertEqual(lunar.toString(), "二〇一九年三月廿七")
        //        XCTAssertEqual(lunar.toFullString(), "二〇一九年三月廿七 己亥(猪)年 戊辰(龙)月 戊戌(狗)日 子(鼠)时 纳音[平地木 大林木 平地木 桑柘木] 星期三 西方白虎 星宿[参水猿](吉) 彭祖百忌[戊不受田田主不祥 戌不吃犬作怪上床] 喜神方位[巽](东南) 阳贵神方位[艮](东北) 阴贵神方位[坤](西南) 福神方位[艮](东北) 财神方位[坎](正北) 冲[(壬辰)龙] 煞[北]")
        XCTAssertEqual(lunar.solar?.toString(), "2019-05-01")
        XCTAssertEqual(lunar.solar?.toFullString(), "2019-05-01 00:00:00 星期三 (劳动节) 金牛座")
    }
}
