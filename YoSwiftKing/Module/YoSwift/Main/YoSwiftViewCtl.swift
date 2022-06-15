//
//  YoSwiftViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//

import UIKit
import JXSegmentedView
import SnapKit
import DefaultsKit
class YoSwiftViewCtl: YoBaseUIViewController {
    //分页基础配置
    var segmentedDataSource: JXSegmentedBaseDataSource?
    //分页器
     lazy var segmentedView : JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        view.addSubview(segmentedView)
         segmentedView.indicators = [self.indicator]
         segmentedView.dataSource =   self.segmentedDataSource
         segmentedView.delegate = self
         segmentedView.listContainer = listContainerView
        return segmentedView
    }()
    //分页容器
    lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(listContainerView)
        return listContainerView
    }()
    //tab数据源对象
    lazy var dataSource: JXSegmentedTitleDataSource = {
        //配置数据源
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titleNormalColor = .white
        dataSource.titleSelectedColor = .hex("#FFE9D7")
        dataSource.titleNormalFont =  .systemFont(ofSize: 18, weight: .medium)
        dataSource.titleSelectedFont =  .systemFont(ofSize: 18, weight: .medium)
        dataSource.isTitleZoomEnabled = true
        dataSource.isTitleColorGradientEnabled = true
        return dataSource
    }()
    // indicator tab 指示层
    lazy var indicator: JXSegmentedIndicatorLineView = {
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorColor = .white
        indicator.verticalOffset = 3
        return indicator
    }()
    //MARK: 布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentedView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
            make.height.equalTo(44)
        }
        listContainerView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(view)
            make.top.equalTo(segmentedView.snp.bottom)
        }
//        segmentedView.frame = CGRect(x: 0, y: 88, width: view.bounds.size.width, height: 50)
//        listContainerView.frame = CGRect(x: 0, y: 88 + 50, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }
    //MARK: 手势
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    //MARK: 手势
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    var  titles = [String]()
     override func viewDidLoad() {
        super.viewDidLoad()
         self.navView.isHidden = true
          self.view.backgroundColor =  .hex("FE5E2F")

         self.segmentedDataSource =    self.dataSource
         CategoryApi.shared.categoryTreeHandler { [weak self] finished in
             //本地取数据 TagsModel
             let defaults = Defaults()
             var  titles = [String]()
             if  defaults.has(.tags), let tags  = defaults.get(for: .tags) {
                 for  i in 0 ..< tags.count {
                     if  let model   = tags[i]  as? TagsModel , let name = model.name {
                         titles.append(name)
                     }
                 }
                 self?.dataSource.titles =   titles
             }else {
                 self?.dataSource.titles = titles
             }
             self?.segmentedView.reloadData()
             self?.segmentedView.reloadDataWithoutListContainer()
         }

         
    
    }
}
//MARK： 容器代理
// 点击tab  action 交互
extension YoSwiftViewCtl:  JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}
//MARK： 容器List代理
extension YoSwiftViewCtl:  JXSegmentedListContainerViewDataSource {
    //显示个数 tab
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
     //每个tab 对应的  list 页面
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
      let listViewCtl =   YoSwiftListViewCtl()
        //数据
            listViewCtl.listData =  getdataFromJson(index: index)
        return listViewCtl
    }
}
//MARK： 网络层获取数据
extension YoSwiftViewCtl {
    private func  getdataFromJson(index: Int)  -> [YoSwiftViewListSectionModel]{
        
        guard let path = Bundle.main.path(forResource: "YoSwift-" + String(index), ofType: "json") else { return [] }
          let localData = NSData.init(contentsOfFile: path)! as Data
          do {
                // banner即为我们要转化的目标model
                let model = try JSONDecoder().decode(YoSwiftViewModel.self, from: localData)
                  print(model)
              return model.sections ?? []
//                if let banners = banner.banners {
//                    self.banners = banners
//                }
            } catch {
                debugPrint("banner===ERROR")
                return []
            }
    }
}
