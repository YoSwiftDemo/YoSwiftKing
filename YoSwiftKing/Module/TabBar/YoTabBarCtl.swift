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
        addChildViewCtl(childViewCtl: YoLibViewController(),
                        title: "Lib",
                        image: UIImage(named: "tabar_discover_normal"),
                        selectedImage: UIImage(named: "tabar_discover_selected"))
        addChildViewCtl(childViewCtl: YoFoundationViewController(),
                        title: "Foundation",
                        image: UIImage(named: "tabar_discover_normal"),
                        selectedImage: UIImage(named: "tabar_discover_selected"))
        addChildViewCtl(childViewCtl: YoSwiftViewController(),
                        title: "基础",
                        image: UIImage(named: "tabbar_mine"),
                        selectedImage: UIImage(named: "tabbar_mine_selected"))
        addChildViewCtl(childViewCtl: YoRefreshListViewCtl(),
                        title: "基础",
                        image: UIImage(named: "tabbar_mine"),
                        selectedImage: UIImage(named: "tabbar_mine_selected"))
    }
}
