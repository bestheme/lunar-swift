//
//  NineStar.swift
//  
//
//  Created by 睿宁 on 2022/7/21.
//
/// 九星
/// <p>玄空九星、奇门九星都来源于北斗九星，九数、七色、五行、后天八卦方位都是相通的。</p>
/// @author 6tail
struct NineStar {
    /// 九数
    static let NUMBER: [String] = [
        "一",
        "二",
        "三",
        "四",
        "五",
        "六",
        "七",
        "八",
        "九"
    ];
    
    /// 七色
    static let COLOR: [String] = [
        "白",
        "黒",
        "碧",
        "绿",
        "黄",
        "白",
        "赤",
        "白",
        "紫"
    ];
    
    /// 五行
    static let WU_XING: [String] = [
        "水",
        "土",
        "木",
        "木",
        "土",
        "金",
        "金",
        "土",
        "火"
    ];
    
    /// 后天八卦方位
    static let POSITION: [String] = [
        "坎",
        "坤",
        "震",
        "巽",
        "中",
        "乾",
        "兑",
        "艮",
        "离"
    ];
    
    /// 北斗九星
    static let NAME_BEI_DOU: [String] = [
        "天枢",
        "天璇",
        "天玑",
        "天权",
        "玉衡",
        "开阳",
        "摇光",
        "洞明",
        "隐元"
    ];
    
    /// 玄空九星（玄空风水）
    static let NAME_XUAN_KONG: [String] = [
        "贪狼",
        "巨门",
        "禄存",
        "文曲",
        "廉贞",
        "武曲",
        "破军",
        "左辅",
        "右弼"
    ];
    
    /// 奇门九星（奇门遁甲，也称天盘九星）
    static let NAME_QI_MEN: [String] = [
        "天蓬",
        "天芮",
        "天冲",
        "天辅",
        "天禽",
        "天心",
        "天柱",
        "天任",
        "天英"
    ];
    
    /// 八门（奇门遁甲）
    static let BA_MEN_QI_MEN: [String] = [
        "休",
        "死",
        "伤",
        "杜",
        "",
        "开",
        "惊",
        "生",
        "景"
    ];
    
    /// 太乙九神（太乙神数）
    static let NAME_TAI_YI: [String] = [
        "太乙",
        "摄提",
        "轩辕",
        "招摇",
        "天符",
        "青龙",
        "咸池",
        "太阴",
        "天乙"
    ];
    
    /// 太乙九神对应类型
    static let TYPE_TAI_YI: [String] = [
        "吉神",
        "凶神",
        "安神",
        "安神",
        "凶神",
        "吉神",
        "凶神",
        "吉神",
        "吉神"
    ];
    
    /// 太乙九神歌诀（太乙神数）
    static let SONG_TAI_YI: [String] = [
        "门中太乙明，星官号贪狼，赌彩财喜旺，婚姻大吉昌，出入无阻挡，参谒见贤良，此行三五里，黑衣别阴阳。",
        "门前见摄提，百事必忧疑，相生犹自可，相克祸必临，死门并相会，老妇哭悲啼，求谋并吉事，尽皆不相宜，只可藏隐遁，若动伤身疾。",
        "出入会轩辕，凡事必缠牵，相生全不美，相克更忧煎，远行多不利，博彩尽输钱，九天玄女法，句句不虚言。",
        "招摇号木星，当之事莫行，相克行人阻，阴人口舌迎，梦寐多惊惧，屋响斧自鸣，阴阳消息理，万法弗违情。",
        "五鬼为天符，当门阴女谋，相克无好事，行路阻中途，走失难寻觅，道逢有尼姑，此星当门值，万事有灾除。",
        "神光跃青龙，财气喜重重，投入有酒食，赌彩最兴隆，更逢相生旺，休言克破凶，见贵安营寨，万事总吉同。",
        "吾将为咸池，当之尽不宜，出入多不利，相克有灾情，赌彩全输尽，求财空手回，仙人真妙语，愚人莫与知，动用虚惊退，反复逆风吹。",
        "坐临太阴星，百祸不相侵，求谋悉成就，知交有觅寻，回风归来路，恐有殃伏起，密语中记取，慎乎莫轻行。",
        "迎来天乙星，相逢百事兴，运用和合庆，茶酒喜相迎，求谋并嫁娶，好合有天成，祸福如神验，吉凶甚分明。"
    ];
    
    /// 吉凶（玄空风水）
    static let LUCK_XUAN_KONG: [String] = [
        "吉",
        "凶",
        "凶",
        "吉",
        "凶",
        "吉",
        "凶",
        "吉",
        "吉"
    ];
    
    /// 吉凶（奇门遁甲）
    static let LUCK_QI_MEN: [String] = [
        "大凶",
        "大凶",
        "小吉",
        "大吉",
        "大吉",
        "大吉",
        "小凶",
        "小吉",
        "小凶"
    ];
    
    /// 阴阳（奇门遁甲）
    static let YIN_YANG_QI_MEN: [String] = [
        "阳",
        "阴",
        "阳",
        "阳",
        "阳",
        "阴",
        "阴",
        "阳",
        "阴"
    ];
    
    /// 序号，0到8
    var index: Int = 0;
    
    var number: String {
        get {
            return NineStar.NUMBER[index]
        }
    }
    
    var color: String {
        get {
            return NineStar.COLOR[index]
        }
    }
    
    var wuXing: String {
        get {
            return NineStar.WU_XING[index]
        }
    }
    
    var position: String {
        get {
            return NineStar.POSITION[index]
        }
    }
    
    var positionDesc: String? {
        get {
            return LunarUtil.POSITION_DESC[position]
        }
    }
    
    var nameInXuanKong: String {
        get {
            return NineStar.NAME_XUAN_KONG[index]
        }
    }
    
    var nameInBeiDou: String {
        get {
            return NineStar.NAME_BEI_DOU[index]
        }
    }
    
    var nameInQiMen: String {
        get {
            return NineStar.NAME_QI_MEN[index]
        }
    }
    
    var nameInTaiYi: String {
        get {
            return NineStar.NAME_TAI_YI[index]
        }
    }
    
    var luckInQiMen: String {
        get {
            return NineStar.LUCK_QI_MEN[index]
        }
    }
    
    var luckInXuanKong: String {
        get {
            return NineStar.LUCK_XUAN_KONG[index]
        }
    }
    
    var yinYangInQiMen: String {
        get {
            return NineStar.YIN_YANG_QI_MEN[index]
        }
    }
    
    var typeInTaiYi: String {
        get {
            return NineStar.TYPE_TAI_YI[index]
        }
    }
    
    var baMenInQiMen: String {
        get {
            NineStar.BA_MEN_QI_MEN[index]
        }
    }
    
    var songInTaiYi: String {
        get {
            NineStar.SONG_TAI_YI[index]
        }
    }
    
    
    
    func toString() -> String {
        return "\(number)\(color)\(wuXing)\(nameInBeiDou)"
    }
    
    func toFullString() -> String {
        var s: String =
        "\(number)\(color)\(wuXing) \(position)(\(positionDesc ?? ""))\(nameInBeiDou) 玄空[\(nameInXuanKong) \(luckInXuanKong)] 奇门[\(nameInQiMen) \(luckInQiMen)"
        if (baMenInQiMen.count > 0) {
            s += " \(baMenInQiMen)门"
        }
        s += " \(yinYangInQiMen)] 太乙[\(nameInTaiYi) \(typeInTaiYi)]"
        return s;
    }
}

