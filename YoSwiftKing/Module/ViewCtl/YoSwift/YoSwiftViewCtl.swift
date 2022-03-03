//
//  YoSwiftViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//

import UIKit
class YoSwiftViewCtl: YoBaseUIViewController {
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
    var items: [String] = ["全部","语法","基础","算法"]
    // 分页顶部tile区
     lazy var titleView: YoTabPagerBarView = {
        //不用  SnapKit
        let titleView =  YoTabPagerBarView.init(frame: CGRect(x: 10,
                                                              y: CGFloat.statusBarHeight,
                                                              width: view.frame.size.width - 10,
                                                              height: 44 + 4),
                                                delegate: self,
                                                default: 0)
        view.addSubview(titleView)
        return titleView
    }()
    // 分页 滚动区
    lazy var pageView: YoPageView = {
        let pageView = YoPageView.init(frame: CGRect(x: 0,y: CGFloat.safeAreaNavBarHeight,
                                                     width: view.frame.size.width,
                                                     height:  view.frame.size.height -  CGFloat.safeAreaNavBarHeight - 4))
        view.addSubview(pageView)
        pageView.delegate = self
        pageView.currentIndex = 0
        return pageView
    }()
    //left- cycle
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.navigationController?.navigationBar.isHidden = true
    }
     override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  .hex("FE5E2F")
        //加载子view
        topBackgroundView.isHidden = false
        titleView.backgroundColor = .clear
        pageView.backgroundColor = .white
    }
    
}
//MARK: private 私有方法
 extension YoSwiftViewCtl {
    @objc func clickItem(_ sender: UIButton) {
        print("点击分段控件...")
    }
}
//MARK: - YoTabPagerBarViewDelegate 代理 - 分页title 回调
extension YoSwiftViewCtl: YoTabPagerBarViewDelegate {
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
        attr.layout =  .automatic //fixed
        attr.style = .scale
        attr.titleSpacing = 15
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
extension YoSwiftViewCtl: YoPageViewDelegate {
    //根据index 配置 页面
    func numberOfPageView(in pageView: YoPageView) -> Array<UIViewController> {
        var arrs: [UIViewController] = []
        for i in 0..<items.count {
            print(i)
            let  ctl = YoSwiftViewListViewCtl()
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
