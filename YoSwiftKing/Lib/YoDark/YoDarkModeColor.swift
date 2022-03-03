//
//  YoDarkModeColor.swift
//  YoDark_Example
//
//  Created by admin on 2022/1/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

//https://www.jianshu.com/p/a2d0a243f290
import UIKit
class YoDarkModeColor {
    //深色模式适配 开关
    static let isOpenYoDarkModeColor: Bool = true
    //文字颜色配置
    //文字颜色  如果有多种文字颜色可以设置多个 eg: labelTextColor
    public class var labelTextColor: UIColor {
        return darkModeColor(dark:UIColor.white,light:UIColor.black)
    }
    
    //MARK:检测当前是否是深色模式
    class func isCheckDarkModeSyle() -> Bool {
        if isOpenYoDarkModeColor {
            if #available(iOS 13.0, *){
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return true
                }
            }
        }
        return false
    }
    //MARK: 适配 动态颜色
    class func darkModeColor(dark: UIColor , light: UIColor) -> UIColor {
        if isOpenYoDarkModeColor {
            if #available(iOS 13.0, *){
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return dark
                }
            }
        }
        return light
    }
}

