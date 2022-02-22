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
import LJTagsView
class TradeMainViewCtl: UIViewController {
    //UI 背景层
    private lazy var topBackgroundView: UIView = {
        let topBg = UIView()
        view.addSubview(topBg)
        topBg.backgroundColor = UIColor.gradientColor(colors:[TradeConfig.instance.navStartColor,TradeConfig.instance.navEndColor],
                                                          startPoint: CGPoint(x: 0, y: 1),
                                                      width: self.view.frame.size.width)
        return topBg
    }()
    //UI选择类型按钮
    private lazy var selectTypeBtn: UIButton = {
        let btn = UIButton()
        view.addSubview(btn)
        btn.setTitle("选择类型", for: .normal)
        btn.titleLabel?.font = TradeConfig.instance.selectButtonFont
        btn.setTitleColor(TradeConfig.instance.selectBtnSelectedColor, for: .selected)
        btn.setTitleColor(TradeConfig.instance.selectBtnNormalColor, for: .normal)
        btn.addTarget(self, action: #selector(selectBtnAction(_:)), for: .touchUpInside)
        btn.backgroundColor = .red
        return btn
    }()
    //UI 选择 时间
    private lazy var selectDateBtn: UIButton = {
        let btn = UIButton()
        view.addSubview(btn)
        btn.setTitle("选择时间", for: .normal)
        btn.titleLabel?.font = TradeConfig.instance.selectButtonFont
        btn.setTitleColor(TradeConfig.instance.selectBtnSelectedColor, for: .selected)
        btn.setTitleColor(TradeConfig.instance.selectBtnNormalColor, for: .normal)
        btn.addTarget(self, action: #selector(selectBtnAction(_:)), for: .touchUpInside)
        btn.backgroundColor = .green
        return btn
    }()
    //UI 标签view
    var dataSource = ["类型标签1","测试数据","测试数据2","你","我鸡尾酒","二狗子","他们来了"]
    var modelDataSource: [TagsPropertyModel] = [TagsPropertyModel]()
    lazy var tagsView0 : LJTagsView = {
        let tagsView0 = LJTagsView()
        view.addSubview(tagsView0)
        tagsView0.backgroundColor = .brown
        tagsView0.tagsViewDelegate = self
        tagsView0.tagsViewContentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsView0.tagsViewMinHeight = 0
        tagsView0.scrollDirection = .vertical
        tagsView0.tagsViewMaxHeight = view.frame.size.height
        tagsView0.minimumLineSpacing = 10;
        tagsView0.minimumInteritemSpacing = 10;
        return tagsView0
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
    //
    private lazy var pageContentView: UIView = {
        let page = pageViewManager.contentView
        view.addSubview(page)
        return page
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
}
//MARK: 选择按钮事件
extension TradeMainViewCtl {
    @objc  private func selectBtnAction(_ sender: UIButton) {
        //选择类型
        if sender == selectTypeBtn {
            dataSource = ["类型标签1","测试数据","测试数据2","你","我鸡尾酒","二狗子","他们来了"]
            for index in 0...dataSource.count-1 {
                let item = dataSource[index]
                let model = TagsPropertyModel()
                model.imageAlignmentMode = .right
                model.titleLabel.text = item
                modelDataSource.append(model)
            }
        }
        //选择时间
        if sender == selectDateBtn {
            dataSource = []
            modelDataSource = []
        }
    
        tagsView0.dataSource = dataSource
        tagsView0.tagsViewMaxHeight  = self.view.frame.size.height
        tagsView0.reloadData()
//        let contentView = pageViewManager.contentView
//

                   // 更新动画
        print(self.tagsView0.frame.size.height)
        UIView.animate(withDuration: 0.2, animations: {
            self.pageContentView.y = self.tagsView0.y+self.tagsView0.frame.size.height
            //        // 告诉self.view约束需要更新
                    self.pageContentView.needsUpdateConstraints()
                               // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
                    self.pageContentView.updateConstraintsIfNeeded()
            self.pageContentView.layoutIfNeeded()
        })
        
        
     
        
        
        
      
    }
}
//MARK: 标签代理回调
extension TradeMainViewCtl:  LJTagsViewProtocol {
    /** 设置每个tag的属性，包含UI ，对应的属性*/
    func tagsViewUpdatePropertyModel(_ tagsView: LJTagsView, item: TagsPropertyModel, index: NSInteger) {

        if (index  == 15) {item.minHeight = 40}
        item.imageAlignmentMode = .left

            item.normalImage = UIImage(named: "delete")
            item.imageSize = CGSize(width: 10, height: 10)

    }
    
    func tagsViewItemTapAction(_ tagsView: LJTagsView, item: TagsPropertyModel, index: NSInteger) {
            dataSource.remove(at: index)
            tagsView.dataSource.remove(at: index)
        tagsView.reloadData()
    }
    
    func tagsViewTapAction(_ tagsView: LJTagsView) {
        tagsView.isSelect = !tagsView.isSelect
        tagsView.reloadData()
    }
}
//MARK: 布局
extension TradeMainViewCtl {
    //布局
    private func layoutTradeMainViewCtl(){
        //背景色
        topBackgroundView.snp.makeConstraints { make in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(TradeConfig.instance.tradeTopBackgroundHeight)
        }
        
        //按钮选择  类型
        selectTypeBtn.snp.makeConstraints { make in
            make.left.equalTo(view).offset(60)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(60)
            make.top.equalTo(topBackgroundView.snp.bottom).offset(40)
        }
        //按钮选择  时间
        selectDateBtn.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-60)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(60)
            make.top.equalTo(topBackgroundView.snp.bottom).offset(40)
        }
        //标签View
        tagsView0.snp.makeConstraints { make in
            make.top.equalTo(selectTypeBtn.snp.bottom).offset(30)
            make.left.right.equalToSuperview().offset(0)
            //不设置高度
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
            maker.left.equalTo(view)
            maker.width.equalTo(view)
            maker.height.equalTo(44)
        }
        // 单独设置 contentView 的大小和位置，可以使用 autolayout 或者 frame
        pageContentView.snp.makeConstraints { (make) in
            make.top.equalTo(tagsView0.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
}
