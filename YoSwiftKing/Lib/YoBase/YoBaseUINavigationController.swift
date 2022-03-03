//
//  YoBaseUINavigationController.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//
import SnapKit
import UIKit
// MARK: 类
open class YoBaseUINavigationController: UINavigationController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    @available(*, unavailable)
    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //自定义导航区
//    lazy var navView: YoBaseNavView = {
//        let view = YoBaseNavView()
//        view.delegate = self
//        return view
//    }()
//    open override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationBar.isHidden = true
//    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        
//        navigationBar.tintColor = .red;
//        //设置导航栏背景颜色
//        navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barTintColor = .red
//        //设置标题及其颜色
//        navigationBar.titleTextAttributes = [.foregroundColor : UIColor.purple, .font : UIFont.systemFont(ofSize: 18)]
        //修改页面背景颜色
        self.view.backgroundColor = UIColor.white
        //修改导航栏背景图片（使用代码动态生成的纯色图片）
        let image = createImageWithColor(.white,
                            frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
    }
    deinit {}
}
// MARK: 生命周期
/*
 
 
 导航栏的创建及常用方法
 let navgationController = UINavigationController(rootViewController: viewC);
 
 设置导航栏的统一的背景色
 UINavigationBar.appearance().barTintColor = UIColor.blueColor();
 
 设置导航栏的背景色
 navgationController.navigationBar.barTintColor = UIColor.yellowColor();
 
 设置导航栏的样式
 navgationController.navigationBar.barStyle = UIBarStyle.BlackTranslucent;
 
 设置导航栏的背景图
 navgationController.navigationBar.setBackgroundImage(UIImage(named: ""), forBarMetrics: UIBarMetrics.Default);
 
 获取控制器中最顶端的视图
 let topViewC = self.navigationController?.topViewController;
 
 获取控制器当前显示的视图
 let currentViewC = self.navigationController?.visibleViewController;
 
 //获取当前控制器所有的子视图
 let viewAarray = self.navigationController?.viewControllers;
 
 //设置prompt属性,主要是用来做一些提醒，比如网络请求，数据加载等等
self.navigationItem.prompt = "正在加载数据";
 
 //不用时，将prompt属性置为nil即可,自带动画效果哦
 self.navigationItem.prompt = nil;
 
 //自定义左侧一个按钮时使用
 self.navigationItem.leftBarButtonItem
 //自定义左侧多个按钮时使用
 self.navigationItem.leftBarButtonItems
 //自定义右侧一个按钮时使用
 self.navigationItem.rightBarButtonItem
 //自定义右侧多个按钮时使用
 self.navigationItem.rightBarButtonItems
 //中间显示的标题文字
 self.navigationItem.title
 //自定义中间部分标题视图时使用
 self.navigationItem.titleView
 
 
 let item = UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.Done, target: self, action: "done:");
 self.navigationItem.leftBarButtonItem = item;
 
 UIBarButtonItem有三种创建方式
 public convenience init(title: String?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector)
 public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector)
 public convenience init(customView: UIView)
 
 
 //appearance方法返回一个导航栏的外观对象
 //修改了这个外观对象，相当于修改了整个项目中的外观
 UINavigationBar *navigationBar = [UINavigationBar appearance];
 
 //设置导航栏背景颜色
 [navigationBar setBarTintColor:[UIColor whiteColor]];
 
 //设置标题栏颜色
 navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:18]};
 
 //设置NavigationBarItem文字的颜色
 //[navigationBar setTintColor:[UIColor blackColor]];


 */
extension YoBaseUINavigationController {
    //初始化 默认左侧返回按钮
  open func initViewCtlSubView(){
      let item = UIBarButtonItem(title: "done", style: .done, target: self, action:  #selector(doneAction));
        self.navigationItem.leftBarButtonItem = item;
    }
    @objc open  func doneAction() {
        if presentingViewController != nil, viewControllers.count == 1 {
            dismiss(animated: true)
        } else {
            popViewController(animated: true)
        }
    }
}
// MARK: 布局
extension YoBaseUINavigationController {
    //放一个view
    func layoutViewCtlSubView(){
        
    }
}
// MARK:
extension YoBaseUINavigationController {
    //生成一个指定颜色的图片
private  func createImageWithColor(_ color: UIColor, frame: CGRect) -> UIImage? {
         // 开始绘图
         UIGraphicsBeginImageContext(frame.size)
          
         // 获取绘图上下文
         let context = UIGraphicsGetCurrentContext()
         // 设置填充颜色
         context?.setFillColor(color.cgColor)
         // 使用填充颜色填充区域
         context?.fill(frame)
          
         // 获取绘制的图像
         let image = UIGraphicsGetImageFromCurrentImageContext()
          
         // 结束绘图
         UIGraphicsEndImageContext()
         return image
     }
}
// MARK: 旋转
extension YoBaseUINavigationController {
    // 是否支持自动转屏
    open override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }
    //支持哪些屏幕方向
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }
    // 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
    }
    //状态栏样式
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    //是否影藏状态栏
    open override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? false
    }
}
// MARK: 代理  自定义导航层
extension YoBaseUINavigationController: YoBaseUINavigationControllerDelegate {
    //选择左侧按钮
    func selectedLeftButtonAction(on leftBtn: UIButton) {
        if presentingViewController != nil, viewControllers.count == 1 {
            dismiss(animated: true)
        } else {
            popViewController(animated: true)
        }
    }
}
