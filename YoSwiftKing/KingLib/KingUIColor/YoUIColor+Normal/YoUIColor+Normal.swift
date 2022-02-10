//
//  UIColor+Expand.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/21.
//
import UIKit
//  //返回随机颜色
extension UIColor {
    //返回随机颜色
     class var randomColor:UIColor{
        get{
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
extension UIColor {
    //https://www.xueui.cn/design-theory/dark-dark-adaptation.html
    //主标题
    public static var titleColor: UIColor {
        return .hex("#666666")
    }
    //正常文本
    public static var textColor: UIColor {
        return .hex("#999999")
    }
    //浅色 文本
    public static var lightTextColor: UIColor {
        return .hex("#CCCCCC")
    }
    public static var lightBackgroundColor: UIColor {
        return .hex("#000000").withAlphaComponent(0.04)
    }
    //白色透明8 字体浅色
    public static var white8Color: UIColor {
        return .hex( "#FFFFFF").withAlphaComponent(0.8)
    }
}
extension UIColor {
    
    /// 改变透明度 不会影响子视图透明度
    /// - Parameter alpha: 透明度
    /// - Returns: 对应的 Color
    public func toColor(of alpha: CGFloat) -> UIColor {
        return withAlphaComponent(alpha)
    }
}
