//
//  YoUITabBarController.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//

import UIKit
// MARK: 类
open class YoBaseUITabBarController: UITabBarController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {}
}
// MARK:  扩展 - 生命周期
extension YoBaseUITabBarController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        //设置背景色 默认白色
        view.backgroundColor = .white
//        UITabBar.appearance().isTranslucent = false
//        UITabBar.appearance().backgroundColor = .white
//        UITabBar.appearance().backgroundImage=UIImage()
        self.view.backgroundColor = UIColor.white
    }
}
// MARK:  扩展 - 旋转问题
extension YoBaseUITabBarController {
    // 是否支持自动转屏
    open override var shouldAutorotate: Bool {
        guard let navCtl = selectedViewController as? UINavigationController else {
            return selectedViewController?.shouldAutorotate ?? false
        }
        return navCtl.topViewController?.shouldAutorotate ?? false
    }
    //支持哪些旋转方向
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard let navCtl = selectedViewController as? UINavigationController else {
            return selectedViewController?.supportedInterfaceOrientations ?? .portrait
        }
        return navCtl.topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    //默认的旋转方向
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        guard let navCtl = selectedViewController as? UINavigationController else {
            return selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
        }
        return navCtl.topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    //状态栏样式
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let navCtl = selectedViewController as? UINavigationController else {
            return selectedViewController?.preferredStatusBarStyle ?? .default
        }
        return navCtl.topViewController?.preferredStatusBarStyle ?? .default
    }
    //是否影藏状态栏
    open override var prefersStatusBarHidden: Bool {
        guard let navCtl = selectedViewController as? UINavigationController else {
            return selectedViewController?.prefersStatusBarHidden ?? false
        }
        return navCtl.topViewController?.prefersStatusBarHidden ?? false
    }
}

// MARK:  快速添加 子ctl 方法
extension YoBaseUITabBarController {
    func addChildViewCtl(childViewCtl: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) {
        childViewCtl.title = title
        childViewCtl.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 11)], for: .normal)
        childViewCtl.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 11)], for: .selected)
        childViewCtl.tabBarItem.image = image?.withRenderingMode(.alwaysOriginal)
        childViewCtl.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        let navCtl = YoBaseUINavigationController(rootViewController: childViewCtl)
        addChild(navCtl)
    }
}
