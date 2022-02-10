//
//  UIColor+Expand.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/21.
//
import UIKit

extension UIColor {
    // 16进制颜色
    class func hex(_ string: String, alpha: CGFloat = 1.0) -> UIColor {
        let hexString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        } else if hexString.hasPrefix("0x") {
            scanner.scanLocation = 2
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x0000_00FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0

        return self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// 颜色16进制字符串
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        if a == 1.0 {
            return String(format: "%0.2X%0.2X%0.2X", UInt(r * 255), UInt(g * 255), UInt(b * 255))
        } else {
            return String(format: "%0.2X%0.2X%0.2X%0.2X", UInt(r * 255), UInt(g * 255), UInt(b * 255), UInt(a * 255))
        }
    }
}
