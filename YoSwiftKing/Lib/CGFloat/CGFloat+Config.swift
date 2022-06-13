//
//  CGFloat+Config.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
extension CGFloat {
    
    public static var sale: CGFloat { UIScreen.main.bounds.size.width/375 }
    /// 屏幕宽度
    public static var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    /// 屏幕高度
    public static var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /// 状态栏高度
    public static var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window: UIWindow? = UIApplication.shared.windows.first
            return (window?.windowScene?.statusBarManager?.statusBarFrame.height)!
        }else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    /// 安全区域导航栏高度
    public static var safeAreaNavBarHeight: CGFloat { statusBarHeight + 44.0 }
    
    /// 是否为刘海屏 true: 刘海屏 false: 非刘海屏
    public static   var isBangScreen: Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else { return false }
            
            if unwrapedWindow.safeAreaInsets.bottom > 0 {  return true }
        }
        return false
    }
    /// 底部高度 刘海屏: 34.0  非刘海屏: 0.0
    public static   var bottomHeight:CGFloat {
        return isBangScreen ? 34.0 : 0.0
    }
}
