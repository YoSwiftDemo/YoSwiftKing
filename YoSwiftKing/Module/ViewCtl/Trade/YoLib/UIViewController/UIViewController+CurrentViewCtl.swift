//
//  UIViewController+CurrentViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/1.
//


import Foundation
import UIKit

public extension UIViewController {
    //MARK：
    func currentViewController() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return currentViewController(vc)
    }
    //MARK：
    func currentViewController(_ vc :UIViewController?) -> UIViewController? {
        if vc == nil {
            return nil
        }
        if let presentVC = vc?.presentedViewController {
            return currentViewController(presentVC)
        }
        else if let tabVC = vc as? UITabBarController {
            if let selectVC = tabVC.selectedViewController {
                return currentViewController(selectVC)
            }
            return nil
        }
        else if let naiVC = vc as? UINavigationController {
            return currentViewController(naiVC.visibleViewController)
        }
        else {
            return vc
        }
    }
    
}
