//
//  TaoistUtil.swift
//  
//
//  Created by 睿宁 on 2022/7/23.
//
// Taoist tools
struct TaoistUtil {
    /// 八会日
    static let BA_HUI: [String: String] = [
        "丙午": "天会",
        "壬午": "地会",
        "壬子": "人会",
        "庚午": "日会",
        "庚申": "月会",
        "辛酉": "星辰会",
        "甲辰": "五行会",
        "甲戌": "四时会"
    ]
    
    /// 八节日
    static let BA_JIE: [String: String] = [
        "立春": "东北方度仙上圣天尊同梵炁始青天君下降",
        "春分": "东方玉宝星上天尊同青帝九炁天君下降",
        "立夏": "东南方好生度命天尊同梵炁始丹天君下降",
        "夏至": "南方玄真万福天尊同赤帝三炁天君下降",
        "立秋": "西南方太灵虚皇天尊同梵炁始素天君下降",
        "秋分": "西方太妙至极天尊同白帝七炁天君下降",
        "立冬": "西北方无量太华天尊同梵炁始玄天君下降",
        "冬至": "北方玄上玉宸天尊同黑帝五炁天君下降"
    ]
    
    /// 三会日
    static let SAN_HUI: [String] = ["1-7", "7-7", "10-15"];
    
    /// 三元日
    static let SAN_YUAN: [String] = ["1-15", "7-15", "10-15"];
    
    /// 五腊日
    static let WU_LA: [String] = ["1-1", "5-5", "7-7", "10-1", "12-8"];
    
    /// 暗戊
    static let AN_WU: [String] = [
        "未",
        "戌",
        "辰",
        "寅",
        "午",
        "子",
        "酉",
        "申",
        "巳",
        "亥",
        "卯",
        "丑"
    ]
    
    // The festivals of Taoist
    static let FESTIVAL: [String: [TaoistFestival]] = [
        "1-1": [TaoistFestival(name: "天腊之辰", remark: "天腊，此日五帝会于东方九炁青天")],
        "1-3": [TaoistFestival(name: "郝真人圣诞"), TaoistFestival(name: "孙真人圣诞")],
        "1-5": [TaoistFestival(name: "孙祖清静元君诞")],
        "1-7": [TaoistFestival(name: "举迁赏会", remark: "此日上元赐福，天官同地水二官考校罪福")],
        "1-9": [TaoistFestival(name: "玉皇上帝圣诞")],
        "1-13": [TaoistFestival(name: "关圣帝君飞升")],
        "1-15": [TaoistFestival(name: "上元天官圣诞"), TaoistFestival(name: "老祖天师圣诞")],
        "1-19": [TaoistFestival(name: "长春邱真人(邱处机)圣诞")],
        "1-28": [TaoistFestival(name: "许真君(许逊天师)圣诞")],
        "2-1": [TaoistFestival(name: "勾陈天皇大帝圣诞"), TaoistFestival(name: "长春刘真人(刘渊然)圣诞")],
        "2-2": [TaoistFestival(name: "土地正神诞"), TaoistFestival(name: "姜太公圣诞")],
        "2-3": [TaoistFestival(name: "文昌梓潼帝君圣诞")],
        "2-6": [TaoistFestival(name: "东华帝君圣诞")],
        "2-13": [TaoistFestival(name: "度人无量葛真君圣诞")],
        "2-15": [TaoistFestival(name: "太清道德天尊(太上老君)圣诞")],
        "2-19": [TaoistFestival(name: "慈航真人圣诞")],
        "3-1": [TaoistFestival(name: "谭祖(谭处端)长真真人圣诞")],
        "3-3": [TaoistFestival(name: "玄天上帝圣诞")],
        "3-6": [TaoistFestival(name: "眼光娘娘圣诞")],
        "3-15": [TaoistFestival(name: "天师张大真人圣诞"), TaoistFestival(name: "财神赵公元帅圣诞")],
        "3-16": [TaoistFestival(name: "三茅真君得道之辰"), TaoistFestival(name: "中岳大帝圣诞")],
        "3-18": [TaoistFestival(name: "王祖(王处一)玉阳真人圣诞"), TaoistFestival(name: "后土娘娘圣诞")],
        "3-19": [TaoistFestival(name: "太阳星君圣诞")],
        "3-20": [TaoistFestival(name: "子孙娘娘圣诞")],
        "3-23": [TaoistFestival(name: "天后妈祖圣诞")],
        "3-26": [TaoistFestival(name: "鬼谷先师诞")],
        "3-28": [TaoistFestival(name: "东岳大帝圣诞")],
        "4-1": [TaoistFestival(name: "长生谭真君成道之辰")],
        "4-10": [TaoistFestival(name: "何仙姑圣诞")],
        "4-14": [TaoistFestival(name: "吕祖纯阳祖师圣诞")],
        "4-15": [TaoistFestival(name: "钟离祖师圣诞")],
        "4-18": [
            TaoistFestival(name: "北极紫微大帝圣诞"),
            TaoistFestival(name: "泰山圣母碧霞元君诞"),
            TaoistFestival(name: "华佗神医先师诞")
        ],
        "4-20": [TaoistFestival(name: "眼光圣母娘娘诞")],
        "4-28": [TaoistFestival(name: "神农先帝诞")],
        "5-1": [TaoistFestival(name: "南极长生大帝圣诞")],
        "5-5": [
            TaoistFestival(name: "地腊之辰", remark: "地腊，此日五帝会于南方三炁丹天"),
            TaoistFestival(name: "南方雷祖圣诞"),
            TaoistFestival(name: "地祗温元帅圣诞"),
            TaoistFestival(name: "雷霆邓天君圣诞")
        ],
        "5-11": [TaoistFestival(name: "城隍爷圣诞")],
        "5-13": [TaoistFestival(name: "关圣帝君降神"), TaoistFestival(name: "关平太子圣诞")],
        "5-18": [TaoistFestival(name: "张天师圣诞")],
        "5-20": [TaoistFestival(name: "马祖丹阳真人圣诞")],
        "5-29": [TaoistFestival(name: "紫青白祖师圣诞")],
        "6-1": [TaoistFestival(name: "南斗星君下降")],
        "6-2": [TaoistFestival(name: "南斗星君下降")],
        "6-3": [TaoistFestival(name: "南斗星君下降")],
        "6-4": [TaoistFestival(name: "南斗星君下降")],
        "6-5": [TaoistFestival(name: "南斗星君下降")],
        "6-6": [TaoistFestival(name: "南斗星君下降")],
        "6-10": [TaoistFestival(name: "刘海蟾祖师圣诞")],
        "6-15": [TaoistFestival(name: "灵官王天君圣诞")],
        "6-19": [TaoistFestival(name: "慈航(观音)成道日")],
        "6-23": [TaoistFestival(name: "火神圣诞")],
        "6-24": [TaoistFestival(name: "南极大帝中方雷祖圣诞"), TaoistFestival(name: "关圣帝君圣诞")],
        "6-26": [TaoistFestival(name: "二郎真君圣诞")],
        "7-7": [
            TaoistFestival(name: "道德腊之辰", remark: "道德腊，此日五帝会于西方七炁素天"),
            TaoistFestival(name: "庆生中会", remark: "此日中元赦罪，地官同天水二官考校罪福")
        ],
        "7-12": [TaoistFestival(name: "西方雷祖圣诞")],
        "7-15": [TaoistFestival(name: "中元地官大帝圣诞")],
        "7-18": [TaoistFestival(name: "王母娘娘圣诞")],
        "7-20": [TaoistFestival(name: "刘祖(刘处玄)长生真人圣诞")],
        "7-22": [TaoistFestival(name: "财帛星君文财神增福相公李诡祖圣诞")],
        "7-26": [TaoistFestival(name: "张三丰祖师圣诞")],
        "8-1": [TaoistFestival(name: "许真君飞升日")],
        "8-3": [TaoistFestival(name: "九天司命灶君诞")],
        "8-5": [TaoistFestival(name: "北方雷祖圣诞")],
        "8-10": [TaoistFestival(name: "北岳大帝诞辰")],
        "8-15": [TaoistFestival(name: "太阴星君诞")],
        "9-1": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-2": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-3": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-4": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-5": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-6": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-7": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-8": [TaoistFestival(name: "北斗九皇降世之辰")],
        "9-9": [
            TaoistFestival(name: "北斗九皇降世之辰"),
            TaoistFestival(name: "斗姥元君圣诞"),
            TaoistFestival(name: "重阳帝君圣诞"),
            TaoistFestival(name: "玄天上帝飞升"),
            TaoistFestival(name: "酆都大帝圣诞")
        ],
        "9-22": [TaoistFestival(name: "增福财神诞")],
        "9-23": [TaoistFestival(name: "萨翁真君圣诞")],
        "9-28": [TaoistFestival(name: "五显灵官马元帅圣诞")],
        "10-1": [
            TaoistFestival(name: "民岁腊之辰", remark: "民岁腊，此日五帝会于北方五炁黑天"),
            TaoistFestival(name: "东皇大帝圣诞")
        ],
        "10-3": [TaoistFestival(name: "三茅应化真君圣诞")],
        "10-6": [TaoistFestival(name: "天曹诸司五岳五帝圣诞")],
        "10-15": [
            TaoistFestival(name: "下元水官大帝圣诞"),
            TaoistFestival(name: "建生大会", remark: "此日下元解厄，水官同天地二官考校罪福")
        ],
        "10-18": [TaoistFestival(name: "地母娘娘圣诞")],
        "10-19": [TaoistFestival(name: "长春邱真君飞升")],
        "10-20": [TaoistFestival(name: "虚靖天师(即三十代天师弘悟张真人)诞")],
        "11-6": [TaoistFestival(name: "西岳大帝圣诞")],
        "11-9": [TaoistFestival(name: "湘子韩祖圣诞")],
        "11-11": [TaoistFestival(name: "太乙救苦天尊圣诞")],
        "11-26": [TaoistFestival(name: "北方五道圣诞")],
        "12-8": [TaoistFestival(name: "王侯腊之辰", remark: "王侯腊，此日五帝会于上方玄都玉京")],
        "12-16": [TaoistFestival(name: "南岳大帝圣诞"), TaoistFestival(name: "福德正神诞")],
        "12-20": [TaoistFestival(name: "鲁班先师圣诞")],
        "12-21": [TaoistFestival(name: "天猷上帝圣诞")],
        "12-22": [TaoistFestival(name: "重阳祖师圣诞")],
        "12-23": [TaoistFestival(name: "祭灶王", remark: "最适宜谢旧年太岁，开启拜新年太岁")],
        "12-25": [TaoistFestival(name: "玉帝巡天"), TaoistFestival(name: "天神下降")],
        "12-29": [TaoistFestival(name: "清静孙真君(孙不二)成道")]
    ]
}
