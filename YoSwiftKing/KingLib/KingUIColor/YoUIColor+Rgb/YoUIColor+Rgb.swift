//
//  UIColor+Expand.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/21.
//

import UIKit



extension UIColor {
    

    
    /// 转 rgb 数据
    public func toRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0;
        getRed(&r, green: &g, blue: &b, alpha: nil)
        return (CGFloat(r * 255.0), CGFloat(g * 255.0), CGFloat(b * 255.0))
    }
    
    /// 由 rgb 转渐变的 rgb 数据
    /// - Parameters:
    ///   - lhs:  第一个 rgb
    ///   - rhs: 第二个 rgb
    /// - Returns: 渐变的 rgb
    public static func toGradientRGB(
        lhs: (CGFloat, CGFloat, CGFloat),
        rhs: (CGFloat, CGFloat, CGFloat)
    ) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        return (lhs.0 - rhs.0, lhs.1 - rhs.1, lhs.2 - rhs.2)
    }
    
    /// 由 RGBA 生成 Color 透明度默认 1.0
    /// - Parameters:
    ///   - r: 红色
    ///   - g: 绿色
    ///   - b: 蓝色
    ///   - a: 透明度
    /// - Returns: 对应的 Color
    public static func color(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
