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
import DNSPageView

class TradeMainViewCtl: UIViewController {
    //背景层
    private lazy var topBackgroundView: UIView = {
        let topBg = UIView()
        view.addSubview(topBg)
        topBg.backgroundColor = UIColor.gradientColor(colors:[TradeConfig.instance.navStartColor,TradeConfig.instance.navEndColor],
                                                          startPoint: CGPoint(x: 0, y: 1),
                                                      width: self.view.frame.size.width)
        return topBg
    }()
    var changed = false
    private lazy var pageViewManager: PageViewManager = {
        // 创建 PageStyle，设置样式
        let style = PageStyle()
        style.isShowBottomLine = true
        style.isTitleViewScrollEnabled = true
        style.titleViewBackgroundColor = UIColor.clear
        style.titleMargin = 80
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.white
        style.bottomLineColor = .green
        style.bottomLineWidth = 20
        let titles = ["代缴费", "委托", "过户"]
        for i in 0..<titles.count {
            let controller = TradeListTableViewCtl()
            controller.view.backgroundColor = UIColor.randomColor
            addChild(controller)
        }

        return PageViewManager(style: style, titles: titles, childViewControllers: children, currentIndex: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *) {
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        navigationController?.navigationBar.isHidden = true
        //布局
        layoutTradeMainViewCtl()

    }
    //布局
    private func layoutTradeMainViewCtl(){
        //背景色
        topBackgroundView.snp.makeConstraints { make in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(TradeConfig.instance.tradeTopBackgroundHeight)
        }
        
        let titleView = pageViewManager.titleView
        view.addSubview(titleView)
        titleView.backgroundColor = .clear

        // 单独设置 titleView 的大小和位置，可以使用 autolayout 或者 frame
        titleView.snp.makeConstraints { (maker) in
            if #available(iOS 11.0, *) {
                maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            } else {
                maker.top.equalTo(topLayoutGuide.snp.bottom)
            }
//            maker.leading.trailing.equalToSuperview()
            maker.left.equalTo(view)
            maker.width.equalTo(view)
            maker.height.equalTo(44)
        }

        // 单独设置 contentView 的大小和位置，可以使用 autolayout 或者 frame
        let contentView = pageViewManager.contentView
        view.addSubview(pageViewManager.contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.top.equalTo(titleView.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
}
