//
//  YoBaseUIViewController.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/10.
//

import SnapKit
import UIKit
// MARK: 类
open class YoBaseUIViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {}
}
// MARK: 生命周期
extension YoBaseUIViewController {
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: 选择相关
extension YoBaseUIViewController {
    // 是否支持自动转屏
    open override var shouldAutorotate: Bool {
        return false
    }
    // 支持哪些屏幕方向
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    // 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    /// 状态栏样式
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    /// 是否隐藏状态栏
    open override var prefersStatusBarHidden: Bool {
        return false
    }
}
