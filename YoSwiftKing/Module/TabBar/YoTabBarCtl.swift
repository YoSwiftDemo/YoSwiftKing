//
//  YoTabBarCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/10.
//

import UIKit

class YoTabBarCtl: YoBaseUITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().unselectedItemTintColor =  .hex("#999999")
        UITabBar.appearance().tintColor = .hex("#24C065")
        
//        addChildViewCtl(childViewCtl: TradeMainViewCtl(),
//                        title: "交易",
//                        image: UIImage(named: "tabar_discover_normal"),
//                        selectedImage: UIImage(named: "tabar_discover_selected"))
        
        addChildViewCtl(childViewCtl: YoSwiftViewController(),
                        title: "",
                        image: UIImage(named: "tabBar_swift_normal_icon"),
                        selectedImage: UIImage(named: "tabBar_swift_select_icon"))
        addChildViewCtl(childViewCtl: YoFoundationViewController(),
                        title: "",
                        image: UIImage(named: "tabBar_foundation_normal_icon"),
                        selectedImage: UIImage(named: "tabBar_foundation_select_icon"))
        //UI 控件
        addChildViewCtl(childViewCtl: YoUIKitMainViewCtl(),
                        title: "",
                        image: UIImage(named: "tabBar_ui_normal_icon"),
                        selectedImage: UIImage(named: "tabBar_ui_select_icon"))
        addChildViewCtl(childViewCtl: YoDemoMainViewCtl(),
                        title: "",
                        image: UIImage(named: "tabBar_demo_normal_icon"),
                        selectedImage: UIImage(named: "tabBar_demo_select_icon"))
        
        
    }
}
