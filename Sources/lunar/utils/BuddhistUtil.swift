//
//  BuddhistUtil.swift
//  
//
//  Created by 睿宁 on 2022/7/22.
//
/// 佛历工具
/// @author 6tail
struct BuddhistUtil {
    /// 27星宿，佛教从印度传入中国，印度把28星宿改为27星宿，把牛宿(牛金牛)纳入了女宿(女土蝠)。
    static let XIU_27: [String] = [
        "角",
        "亢",
        "氐",
        "房",
        "心",
        "尾",
        "箕",
        "斗",
        "女",
        "虚",
        "危",
        "室",
        "壁",
        "奎",
        "娄",
        "胃",
        "昴",
        "毕",
        "觜",
        "参",
        "井",
        "鬼",
        "柳",
        "星",
        "张",
        "翼",
        "轸"
    ]
    
    /// 每月初一的27星宿偏移
    static let XIU_OFFSET: [Int] = [
        11,
        13,
        15,
        17,
        19,
        21,
        24,
        0,
        2,
        4,
        7,
        9
    ]
    
    /// 观音斋日期
    static let DAY_ZHAI_GUAN_YIN: [String] = [
        "1-8",
        "2-7",
        "2-9",
        "2-19",
        "3-3",
        "3-6",
        "3-13",
        "4-22",
        "5-3",
        "5-17",
        "6-16",
        "6-18",
        "6-19",
        "6-23",
        "7-13",
        "8-16",
        "9-19",
        "9-23",
        "10-2",
        "11-19",
        "11-24",
        "12-25"
    ]
    
    static let DJ: String = "犯者夺纪"
    static let JS: String = "犯者减寿"
    static let SS: String = "犯者损寿"
    static let XL: String = "犯者削禄夺纪"
    static let JW: String = "犯者三年内夫妇俱亡"
    
    static let Y: BuddhistFestival = BuddhistFestival(name: "杨公忌")
    static let T: BuddhistFestival = BuddhistFestival(name: "四天王巡行", result: "", everyMonth: true)
    static let D: BuddhistFestival = BuddhistFestival(name: "斗降", result: DJ, everyMonth: true)
    static let S: BuddhistFestival = BuddhistFestival(name: "月朔", result: DJ, everyMonth: true)
    static let W: BuddhistFestival = BuddhistFestival(name: "月望", result: DJ, everyMonth: true)
    static let H: BuddhistFestival = BuddhistFestival(name: "月晦", result: JS, everyMonth: true)
    static let L: BuddhistFestival = BuddhistFestival(name: "雷斋日", result: JS, everyMonth: true)
    static let J: BuddhistFestival = BuddhistFestival(name: "九毒日", result: "犯者夭亡，奇祸不测")
    static let R: BuddhistFestival =
    BuddhistFestival(name: "人神在阴", result: "犯者得病", everyMonth: true, remark: "宜先一日即戒")
    static let M: BuddhistFestival =
    BuddhistFestival(name: "司命奏事", result: JS, everyMonth: true, remark: "如月小，即戒廿九")
    static let HH: BuddhistFestival = BuddhistFestival(name: "月晦", result: JS, everyMonth: true, remark: "如月小，即戒廿九")
    
    /// 因果犯忌
    static let FESTIVAL: [String: [BuddhistFestival]] = [
        "1-1": [BuddhistFestival(name: "天腊，玉帝校世人神气禄命", result: XL), S],
        "1-3": [BuddhistFestival(name: "万神都会", result: DJ), D],
        "1-5": [BuddhistFestival(name: "五虚忌")],
        "1-6": [BuddhistFestival(name: "六耗忌"), L],
        "1-7": [BuddhistFestival(name: "上会日", result: SS)],
        "1-8": [BuddhistFestival(name: "五殿阎罗天子诞", result: DJ), T],
        "1-9": [BuddhistFestival(name: "玉皇上帝诞", result: DJ)],
        "1-13": [Y],
        "1-14": [BuddhistFestival(name: "三元降", result: JS), T],
        "1-15": [
            BuddhistFestival(name: "三元降", result: JS),
            BuddhistFestival(name: "上元神会", result: DJ),
            W,
            T
        ],
        "1-16": [BuddhistFestival(name: "三元降", result: JS)],
        "1-19": [BuddhistFestival(name: "长春真人诞")],
        "1-23": [BuddhistFestival(name: "三尸神奏事"), T],
        "1-25": [H, BuddhistFestival(name: "天地仓开日", result: "犯者损寿，子带疾")],
        "1-27": [D],
        "1-28": [R],
        "1-29": [T],
        "1-30": [HH, M, T],
        "2-1": [BuddhistFestival(name: "一殿秦广王诞", result: DJ), S],
        "2-2": [BuddhistFestival(name: "万神都会", result: DJ), BuddhistFestival(name: "福德土地正神诞", result: "犯者得祸")],
        "2-3": [BuddhistFestival(name: "文昌帝君诞", result: XL), D],
        "2-6": [BuddhistFestival(name: "东华帝君诞"), L],
        "2-8": [
            BuddhistFestival(name: "释迦牟尼佛出家", result: DJ),
            BuddhistFestival(name: "三殿宋帝王诞", result: DJ),
            BuddhistFestival(name: "张大帝诞", result: DJ),
            T
        ],
        "2-11": [Y],
        "2-14": [T],
        "2-15": [
            BuddhistFestival(name: "释迦牟尼佛涅槃", result: XL),
            BuddhistFestival(name: "太上老君诞", result: XL),
            BuddhistFestival(name: "月望", result: XL, everyMonth: true),
            T
        ],
        "2-17": [BuddhistFestival(name: "东方杜将军诞")],
        "2-18": [
            BuddhistFestival(name: "四殿五官王诞", result: XL),
            BuddhistFestival(name: "至圣先师孔子讳辰", result: XL)
        ],
        "2-19": [BuddhistFestival(name: "观音大士诞", result: DJ)],
        "2-21": [BuddhistFestival(name: "普贤菩萨诞")],
        "2-23": [T],
        "2-25": [H],
        "2-27": [D],
        "2-28": [R],
        "2-29": [T],
        "2-30": [HH, M, T],
        "3-1": [BuddhistFestival(name: "二殿楚江王诞", result: DJ), S],
        "3-3": [BuddhistFestival(name: "玄天上帝诞", result: DJ), D],
        "3-6": [L],
        "3-8": [BuddhistFestival(name: "六殿卞城王诞", result: DJ), T],
        "3-9": [BuddhistFestival(name: "牛鬼神出", result: "犯者产恶胎"), Y],
        "3-12": [BuddhistFestival(name: "中央五道诞")],
        "3-14": [T],
        "3-15": [
            BuddhistFestival(name: "昊天上帝诞", result: DJ),
            BuddhistFestival(name: "玄坛诞", result: DJ),
            W,
            T
        ],
        "3-16": [BuddhistFestival(name: "准提菩萨诞", result: DJ)],
        "3-19": [
            BuddhistFestival(name: "中岳大帝诞"),
            BuddhistFestival(name: "后土娘娘诞"),
            BuddhistFestival(name: "三茅降")
        ],
        "3-20": [BuddhistFestival(name: "天地仓开日", result: SS), BuddhistFestival(name: "子孙娘娘诞")],
        "3-23": [T],
        "3-25": [H],
        "3-27": [BuddhistFestival(name: "七殿泰山王诞"), D],
        "3-28": [R, BuddhistFestival(name: "苍颉至圣先师诞", result: XL), BuddhistFestival(name: "东岳大帝诞")],
        "3-29": [T],
        "3-30": [HH, M, T],
        "4-1": [BuddhistFestival(name: "八殿都市王诞", result: DJ), S],
        "4-3": [D],
        "4-4": [BuddhistFestival(name: "万神善会", result: "犯者失瘼夭胎"), BuddhistFestival(name: "文殊菩萨诞")],
        "4-6": [L],
        "4-7": [BuddhistFestival(name: "南斗、北斗、西斗同降", result: JS), Y],
        "4-8": [
            BuddhistFestival(name: "释迦牟尼佛诞", result: DJ),
            BuddhistFestival(name: "万神善会", result: "犯者失瘼夭胎"),
            BuddhistFestival(name: "善恶童子降", result: "犯者血死"),
            BuddhistFestival(name: "九殿平等王诞"),
            T
        ],
        "4-14": [BuddhistFestival(name: "纯阳祖师诞", result: JS), T],
        "4-15": [W, BuddhistFestival(name: "钟离祖师诞"), T],
        "4-16": [BuddhistFestival(name: "天地仓开日", result: SS)],
        "4-17": [BuddhistFestival(name: "十殿转轮王诞", result: DJ)],
        "4-18": [BuddhistFestival(name: "天地仓开日", result: SS), BuddhistFestival(name: "紫徽大帝诞", result: SS)],
        "4-20": [BuddhistFestival(name: "眼光圣母诞")],
        "4-23": [T],
        "4-25": [H],
        "4-27": [D],
        "4-28": [R],
        "4-29": [T],
        "4-30": [HH, M, T],
        "5-1": [BuddhistFestival(name: "南极长生大帝诞", result: DJ), S],
        "5-3": [D],
        "5-5": [
            BuddhistFestival(name: "地腊", result: XL),
            BuddhistFestival(name: "五帝校定生人官爵", result: XL),
            J,
            Y
        ],
        "5-6": [J, L],
        "5-7": [J],
        "5-8": [BuddhistFestival(name: "南方五道诞"), T],
        "5-11": [BuddhistFestival(name: "天地仓开日", result: SS), BuddhistFestival(name: "天下都城隍诞")],
        "5-12": [BuddhistFestival(name: "炳灵公诞")],
        "5-13": [BuddhistFestival(name: "关圣降", result: XL)],
        "5-14": [BuddhistFestival(name: "夜子时为天地交泰", result: JW), T],
        "5-15": [W, J, T],
        "5-16": [BuddhistFestival(name: "九毒日", result: JW), BuddhistFestival(name: "天地元气造化万物之辰", result: JW)],
        "5-17": [J],
        "5-18": [BuddhistFestival(name: "张天师诞")],
        "5-22": [BuddhistFestival(name: "孝娥神诞", result: DJ)],
        "5-23": [T],
        "5-25": [J, H],
        "5-26": [J],
        "5-27": [J, D],
        "5-28": [R],
        "5-29": [T],
        "5-30": [HH, M, T],
        "6-1": [S],
        "6-3": [BuddhistFestival(name: "韦驮菩萨圣诞"), D, Y],
        "6-5": [BuddhistFestival(name: "南赡部洲转大轮", result: SS)],
        "6-6": [BuddhistFestival(name: "天地仓开日", result: SS), L],
        "6-8": [T],
        "6-10": [BuddhistFestival(name: "金粟如来诞")],
        "6-14": [T],
        "6-15": [W, T],
        "6-19": [BuddhistFestival(name: "观世音菩萨成道", result: DJ)],
        "6-23": [BuddhistFestival(name: "南方火神诞", result: "犯者遭回禄"), T],
        "6-24": [BuddhistFestival(name: "雷祖诞", result: XL), BuddhistFestival(name: "关帝诞", result: XL)],
        "6-25": [H],
        "6-27": [D],
        "6-28": [R],
        "6-29": [T],
        "6-30": [HH, M, T],
        "7-1": [S, Y],
        "7-3": [D],
        "7-5": [BuddhistFestival(name: "中会日", result: SS, everyMonth: false, remark: "一作初七")],
        "7-6": [L],
        "7-7": [
            BuddhistFestival(name: "道德腊", result: XL),
            BuddhistFestival(name: "五帝校生人善恶", result: XL),
            BuddhistFestival(name: "魁星诞", result: XL)
        ],
        "7-8": [T],
        "7-10": [BuddhistFestival(name: "阴毒日", result: "", everyMonth: false, remark: "大忌")],
        "7-12": [BuddhistFestival(name: "长真谭真人诞")],
        "7-13": [BuddhistFestival(name: "大势至菩萨诞", result: JS)],
        "7-14": [BuddhistFestival(name: "三元降", result: JS), T],
        "7-15": [
            W,
            BuddhistFestival(name: "三元降", result: DJ),
            BuddhistFestival(name: "地官校籍", result: DJ),
            T
        ],
        "7-16": [BuddhistFestival(name: "三元降", result: JS)],
        "7-18": [BuddhistFestival(name: "西王母诞", result: DJ)],
        "7-19": [BuddhistFestival(name: "太岁诞", result: DJ)],
        "7-22": [BuddhistFestival(name: "增福财神诞", result: XL)],
        "7-23": [T],
        "7-25": [H],
        "7-27": [D],
        "7-28": [R],
        "7-29": [Y, T],
        "7-30": [BuddhistFestival(name: "地藏菩萨诞", result: DJ), HH, M, T],
        "8-1": [S, BuddhistFestival(name: "许真君诞")],
        "8-3": [
            D,
            BuddhistFestival(name: "北斗诞", result: XL),
            BuddhistFestival(name: "司命灶君诞", result: "犯者遭回禄")
        ],
        "8-5": [BuddhistFestival(name: "雷声大帝诞", result: DJ)],
        "8-6": [L],
        "8-8": [T],
        "8-10": [BuddhistFestival(name: "北斗大帝诞")],
        "8-12": [BuddhistFestival(name: "西方五道诞")],
        "8-14": [T],
        "8-15": [W, BuddhistFestival(name: "太明朝元", result: "犯者暴亡", everyMonth: false, remark: "宜焚香守夜"), T],
        "8-16": [BuddhistFestival(name: "天曹掠刷真君降", result: "犯者贫夭")],
        "8-18": [BuddhistFestival(name: "天人兴福之辰", result: "", everyMonth: false, remark: "宜斋戒，存想吉事")],
        "8-23": [BuddhistFestival(name: "汉恒候张显王诞"), T],
        "8-24": [BuddhistFestival(name: "灶君夫人诞")],
        "8-25": [H],
        "8-27": [D, BuddhistFestival(name: "至圣先师孔子诞", result: XL), Y],
        "8-28": [R, BuddhistFestival(name: "四天会事")],
        "8-29": [T],
        "8-30": [BuddhistFestival(name: "诸神考校", result: "犯者夺算"), HH, M, T],
        "9-1": [
            S,
            BuddhistFestival(name: "南斗诞", result: XL),
            BuddhistFestival(name: "北斗九星降世", result: DJ, everyMonth: false, remark: "此九日俱宜斋戒")
        ],
        "9-3": [D, BuddhistFestival(name: "五瘟神诞")],
        "9-6": [L],
        "9-8": [T],
        "9-9": [
            BuddhistFestival(name: "斗母诞", result: XL),
            BuddhistFestival(name: "酆都大帝诞"),
            BuddhistFestival(name: "玄天上帝飞升")
        ],
        "9-10": [BuddhistFestival(name: "斗母降", result: DJ)],
        "9-11": [BuddhistFestival(name: "宜戒")],
        "9-13": [BuddhistFestival(name: "孟婆尊神诞")],
        "9-14": [T],
        "9-15": [W, T],
        "9-17": [BuddhistFestival(name: "金龙四大王诞", result: "犯者遭水厄")],
        "9-19": [BuddhistFestival(name: "日宫月宫会合", result: JS), BuddhistFestival(name: "观世音菩萨诞", result: JS)],
        "9-23": [T],
        "9-25": [H, Y],
        "9-27": [D],
        "9-28": [R],
        "9-29": [T],
        "9-30": [BuddhistFestival(name: "药师琉璃光佛诞", result: "犯者危疾"), HH, M, T],
        "10-1": [
            S,
            BuddhistFestival(name: "民岁腊", result: DJ),
            BuddhistFestival(name: "四天王降", result: "犯者一年内死")
        ],
        "10-3": [D, BuddhistFestival(name: "三茅诞")],
        "10-5": [BuddhistFestival(name: "下会日", result: JS), BuddhistFestival(name: "达摩祖师诞", result: JS)],
        "10-6": [L, BuddhistFestival(name: "天曹考察", result: DJ)],
        "10-8": [BuddhistFestival(name: "佛涅槃日", result: "", everyMonth: false, remark: "大忌色欲"), T],
        "10-10": [BuddhistFestival(name: "四天王降", result: "犯者一年内死")],
        "10-11": [BuddhistFestival(name: "宜戒")],
        "10-14": [BuddhistFestival(name: "三元降", result: JS), T],
        "10-15": [
            W,
            BuddhistFestival(name: "三元降", result: DJ),
            BuddhistFestival(name: "下元水府校籍", result: DJ),
            T
        ],
        "10-16": [BuddhistFestival(name: "三元降", result: JS), T],
        "10-23": [Y, T],
        "10-25": [H],
        "10-27": [D, BuddhistFestival(name: "北极紫徽大帝降")],
        "10-28": [R],
        "10-29": [T],
        "10-30": [HH, M, T],
        "11-1": [S],
        "11-3": [D],
        "11-4": [BuddhistFestival(name: "至圣先师孔子诞", result: XL)],
        "11-6": [BuddhistFestival(name: "西岳大帝诞")],
        "11-8": [T],
        "11-11": [BuddhistFestival(name: "天地仓开日", result: DJ), BuddhistFestival(name: "太乙救苦天尊诞", result: DJ)],
        "11-14": [T],
        "11-15": [
            BuddhistFestival(name: "月望", result: "上半夜犯男死 下半夜犯女死"),
            BuddhistFestival(name: "四天王巡行", result: "上半夜犯男死 下半夜犯女死")
        ],
        "11-17": [BuddhistFestival(name: "阿弥陀佛诞")],
        "11-19": [BuddhistFestival(name: "太阳日宫诞", result: "犯者得奇祸")],
        "11-21": [Y],
        "11-23": [BuddhistFestival(name: "张仙诞", result: "犯者绝嗣"), T],
        "11-25": [BuddhistFestival(name: "掠刷大夫降", result: "犯者遭大凶"), H],
        "11-26": [BuddhistFestival(name: "北方五道诞")],
        "11-27": [D],
        "11-28": [R],
        "11-29": [T],
        "11-30": [HH, M, T],
        "12-1": [S],
        "12-3": [D],
        "12-6": [BuddhistFestival(name: "天地仓开日", result: JS), L],
        "12-7": [BuddhistFestival(name: "掠刷大夫降", result: "犯者得恶疾")],
        "12-8": [
            BuddhistFestival(name: "王侯腊", result: DJ),
            BuddhistFestival(name: "释迦如来成佛之辰"),
            T,
            BuddhistFestival(name: "初旬内戊日，亦名王侯腊", result: DJ)
        ],
        "12-12": [BuddhistFestival(name: "太素三元君朝真")],
        "12-14": [T],
        "12-15": [W, T],
        "12-16": [BuddhistFestival(name: "南岳大帝诞")],
        "12-19": [Y],
        "12-20": [BuddhistFestival(name: "天地交道", result: "犯者促寿")],
        "12-21": [BuddhistFestival(name: "天猷上帝诞")],
        "12-23": [BuddhistFestival(name: "五岳诞降"), T],
        "12-24": [BuddhistFestival(name: "司今朝天奏人善恶", result: "犯者得大祸")],
        "12-25": [BuddhistFestival(name: "三清玉帝同降，考察善恶", result: "犯者得奇祸"), H],
        "12-27": [D],
        "12-28": [R],
        "12-29": [BuddhistFestival(name: "华严菩萨诞"), T],
        "12-30": [BuddhistFestival(name: "诸神下降，察访善恶", result: "犯者男女俱亡")]
    ]
    
    /// 获取27星宿
    /// @param month 佛历月
    /// @param day 佛历日
    /// @return 星宿
    static func getXiu(month: Int, day: Int) -> String {
        return XIU_27[(XIU_OFFSET[abs(month) - 1] + day - 1) % XIU_27.count]
    }
}
