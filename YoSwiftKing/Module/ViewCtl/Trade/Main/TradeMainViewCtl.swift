//
//  TradeMainViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//
/*
 顶部 分页view
 中部  collectionView分类处理
 底部 tableView
 
 */
import UIKit
import SnapKit
//class TradeMainViewCtl: UIViewController {
//    //UI 背景层
//    private lazy var topBackgroundView: UIView = {
//        let topBg = UIView()
//        view.addSubview(topBg)
//        topBg.backgroundColor = UIColor.gradientColor(colors:[TradeConfig.instance.navStartColor,TradeConfig.instance.navEndColor],
//                                                          startPoint: CGPoint(x: 0, y: 1),
//                                                      width: self.view.frame.size.width)
//        return topBg
//    }()
//
//    //
//    private lazy var pageContentView: UIView = {
//        let page = pageViewManager.contentView
//        view.addSubview(page)
//        return page
//    }()
//    var changed = false
//    private lazy var pageViewManager: PageViewManager = {
//        // 创建 PageStyle，设置样式
//        let style = PageStyle()
//        style.isShowBottomLine = true
//        style.isTitleViewScrollEnabled = true
//        style.titleViewBackgroundColor = UIColor.clear
//        style.titleMargin = TradeConfig.instance.titleMargin
//        style.titleSelectedColor = TradeConfig.instance.mainTitleSelectColor
//        style.titleColor =  TradeConfig.instance.mainTitleColor
//        style.titleFont = TradeConfig.instance.mainTitleFont
//        style.bottomLineColor = .white
//        style.bottomLineWidth = 40
//        let titles = ["代缴费", "委托", "过户"]
//        for i in 0..<titles.count {
//            let controller = TradeListTableViewCtl()
//            controller.view.backgroundColor = UIColor.white
//            addChild(controller)
//        }
//        return PageViewManager(style: style, titles: titles, childViewControllers: children, currentIndex: 0)
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if #available(iOS 11, *) {
//        } else {
//            automaticallyAdjustsScrollViewInsets = false
//        }
//        //布局
//        layoutTradeMainViewCtl()
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
//}
//
////MARK: 布局
//extension TradeMainViewCtl {
//    //布局
//    private func layoutTradeMainViewCtl(){
//        //背景色
//        topBackgroundView.snp.makeConstraints { make in
//            make.left.top.right.equalTo(self.view)
//            make.height.equalTo(TradeConfig.instance.tradeTopBackgroundHeight)
//        }
//
//        let titleView = pageViewManager.titleView
//        view.addSubview(titleView)
//
//        // 单独设置 titleView 的大小和位置，可以使用 autolayout 或者 frame
//        titleView.snp.makeConstraints { (maker) in
//            if #available(iOS 11.0, *) {
//                maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            } else {
//                maker.top.equalTo(topLayoutGuide.snp.bottom)
//            }
//            maker.left.equalTo(view)
//            maker.width.equalTo(view)
//            maker.height.equalTo(44)
//        }
//        // 单独设置 contentView 的大小和位置，可以使用 autolayout 或者 frame
//        pageContentView.snp.makeConstraints { (make) in
//            make.top.equalTo(titleView.snp.bottom)
//            make.left.right.bottom.equalTo(view)
//        }
//    }
//}


class TradeMainViewCtl: UIViewController {
    //    //UI 背景层
    private lazy var topBackgroundView: UIView = {
        let topBg = UIView.init(frame: CGRect(x: 0, y: 0,
                                              width: view.frame.size.width,
                                              height: CGFloat.safeAreaNavBarHeight + 4))
        view.addSubview(topBg)
        topBg.backgroundColor = UIColor.gradientColor(colors:[TradeConfig.instance.navStartColor,TradeConfig.instance.navEndColor],
                                                      startPoint: CGPoint(x: 0, y: 1),
                                                      width: self.view.frame.size.width)
        return topBg
    }()
    var type: Int = 5
    private var item: UIButton!
    private var items: [String] = ["代缴费","委托","过户"]
    // 分页顶部tile区
    private lazy var titleView: YoTabPagerBarView = {
        //不用  SnapKit
        let titleView =  YoTabPagerBarView.init(frame: CGRect(x: 0,y: CGFloat.statusBarHeight,
                                                              width: view.frame.size.width,
                                                              height: 44 + 4),
                                                delegate: self,
                                                default: 0)
        view.addSubview(titleView)
        return titleView
    }()
    // 分页 滚动区
    private lazy var pageView: YoPageView = {
        let pageView = YoPageView.init(frame: CGRect(x: 0,y: CGFloat.safeAreaNavBarHeight,
                                                     width: view.frame.size.width,
                                                     height:  view.frame.size.height -  CGFloat.safeAreaNavBarHeight - 4))
        view.addSubview(pageView)
        pageView.delegate = self
        pageView.currentIndex = 0
        return pageView
    }()
    //left- cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        //加载子view
        topBackgroundView.isHidden = false
        titleView.backgroundColor = .clear
        pageView.backgroundColor = .white
    }
    
}
//MARK: private 私有方法
extension TradeMainViewCtl {
    
    @objc func clickItem(_ sender: UIButton) {
        print("点击分段控件...")
    }
}
//MARK: - YoTabPagerBarViewDelegate 代理 - 分页title 回调
extension TradeMainViewCtl: YoTabPagerBarViewDelegate {
    // 配置 title 个数
    func numberOfTitles(in titleView: YoTabPagerBarView) -> Array<String> {
        return items
    }
    // 配置 title 选择 滚动页面
    func titleView(_ titleView: YoTabPagerBarView, didSelectedAt index: Int) {
        pageView.scrollToPage(at: index)
    }
    // 配置 title 属性  颜色 字体大小
    func attributesOfTitles(for titleView: YoTabPagerBarView) -> YoTitleAttributes {
        var attr = YoTitleAttributes()
        attr.layout = .fixed
        attr.style = .underline
        
        //        style.titleSelectedColor = TradeConfig.instance.mainTitleSelectColor
        //        style.titleColor =  TradeConfig.instance.mainTitleColor
        //        style.titleFont = TradeConfig.instance.mainTitleFont
        //标题 未选择 字体
        attr.titleFont = TradeConfig.instance.mainTitleFont
        //标题 选择 字体
        attr.titleSelectedFont =  TradeConfig.instance.mainTitleFont
        attr.underlineBackColor = .white
        attr.underlineWidth = 24
        attr.underlineOffsetY = -6
        attr.titleColor = TradeConfig.instance.mainTitleColor
        attr.titleSelectedColor = TradeConfig.instance.mainTitleSelectColor
        return attr
    }
}

//MARK: - YoPageViewDelegate 代理
extension TradeMainViewCtl: YoPageViewDelegate {
    //根据index 配置 页面
    func numberOfPageView(in pageView: YoPageView) -> Array<UIViewController> {
        var arrs: [UIViewController] = []
        for i in 0..<items.count {
            print(i)
            let  ctl = TradeListTableViewCtl()
            ctl.view?.backgroundColor  = .randomColor
            arrs.append(ctl)
        }
        return arrs
    }
    //滚动进度
    func pageView(_ pageView: YoPageView, from previousIndex: Int, to currentIndex: Int, progress: CGFloat) {
        titleView.scrollDidScroll(from: previousIndex, to: currentIndex, progress: progress)
    }
    //滚动完成
    func pageView(_ pageView: YoPageView, didEndScrollAt index: Int) {
        titleView.scrollDidEndToIndex(at: index)
    }
}
