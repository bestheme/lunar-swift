//
//  File.swift
//  
//
//  Created by 睿宁 on 2022/7/19.
//
// running months

@available(iOS 15.0, *)
@available(macOS 12.0, *)
public struct LiuYue {
    /// 序数，0-9
    public var index: Int;
    
    /// 流年
    public var liuNian: LiuNian;
    
    public func getMonthInChinese() -> String {
        return LunarUtil.MONTH[index + 1]
    }
    
    public func getGanZhi() -> String {
        var offset: Int = 0;
        let yearGan: String = String(liuNian.getGanZhi().prefix(1));
        if ("甲" == yearGan || "己" == yearGan) {
            offset = 2
        } else if ("乙" == yearGan || "庚" == yearGan) {
            offset = 4
        } else if ("丙" == yearGan || "辛" == yearGan) {
            offset = 6
        } else if ("丁" == yearGan || "壬" == yearGan) {
            offset = 8
        }
        let gan: String = LunarUtil.GAN[(index + offset) % 10 + 1];
        let zhi: String = LunarUtil.ZHI[(index + LunarUtil.BASE_MONTH_ZHI_INDEX) % 12 + 1];
        return gan + zhi;
    }
    
    public func getXun() -> String {
        return LunarUtil.getXun(ganZhi: getGanZhi())
    }
    
    public func getXunKong() -> String {
        return LunarUtil.getXunKong(ganZhi: getGanZhi())
    }
}
