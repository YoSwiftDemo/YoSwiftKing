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
    //自定义导航区
    lazy var navView: YoBaseNavView = {
        let navView = YoBaseNavView()
        self.view.addSubview(navView)
        navView.delegate = self
        return navView
    }()
}
// MARK: 生命周期
extension YoBaseUIViewController {
 
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navView.backgroundColor = .navColor
        layoutViewCtlSubView()
        //修改导航栏背景图片（使用代码动态生成的纯色图片）
//        let image = createImageWithColor(.white,
//                            frame: CGRect(x: 0, y: 0, width: 1, height: 1))
//        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }
}
// MARK:
extension YoBaseUIViewController {
    //生成一个指定颜色的图片
//private  func createImageWithColor(_ color: UIColor, frame: CGRect) -> UIImage? {
//         // 开始绘图
//         UIGraphicsBeginImageContext(frame.size)
//
//         // 获取绘图上下文
//         let context = UIGraphicsGetCurrentContext()
//         // 设置填充颜色
//         context?.setFillColor(color.cgColor)
//         // 使用填充颜色填充区域
//         context?.fill(frame)
//
//         // 获取绘制的图像
//         let image = UIGraphicsGetImageFromCurrentImageContext()
//
//         // 结束绘图
//         UIGraphicsEndImageContext()
//         return image
//     }
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
// MARK: 布局
extension YoBaseUIViewController {
    //放一个view
    func layoutViewCtlSubView(){
        self.navView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(44)
        }
    }
}
// MARK: 代理  自定义导航层
extension YoBaseUIViewController: YoBaseUINavigationControllerDelegate {
    //选择左侧按钮
    func selectedLeftButtonAction(on leftBtn: UIButton) {
            self.navigationController?.popViewController(animated: true)
    }
}

