# lunar [![License](https://img.shields.io/badge/license-MIT-4EB1BA.svg?style=flat-square)](https://github.com/bestheme/lunar-swift/blob/main/LICENSE)


lunar是一款无第三方依赖的日历工具，支持公历(阳历)、农历(阴历、老黄历)、道历、佛历，支持星座、儒略日、干支、生肖、节气、节日、时间局、五行、法定节假日及调休等。

<!-- [English](https://github.com/6tail/lunar-flutter/blob/master/README_EN.md) -->

## 示例

    import SwiftLunar


    //今天
    //let date: Lunar = Lunar(fromDate: Date());

    //指定阴历的某一天
    let date: Lunar  = Lunar(fromYmd: 1986, month: 4, day: 21)
    print(date.toFullString())
    print(date.getSolar().toFullString())


输出结果：

    一九八六年四月廿一 丙寅(虎)年 癸巳(蛇)月 癸酉(鸡)日 子(鼠)时 纳音[炉中火 长流水 剑锋金 桑柘木] 星期四 北方玄武 星宿[斗木獬](吉) 彭祖百忌[癸不词讼理弱敌强 酉不会客醉坐颠狂] 喜神方位[巽](东南) 阳贵神方位[巽](东南) 阴贵神方位[震](正东) 福神方位[兑](正西) 财神方位[离](正南) 冲[(丁卯)兔] 煞[东]
    1986-05-29 00:00:00 星期四 双子座


感谢 [6tail](https://github.com/6tail)

<!-- ## 文档 -->

<!-- 请移步至参考 [http://6tail.cn/calendar/api.html](http://6tail.cn/calendar/api.html "http://6tail.cn/calendar/api.html") -->
