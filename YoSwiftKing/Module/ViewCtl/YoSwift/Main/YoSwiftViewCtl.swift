//
//  YoSwiftViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//

import UIKit
import JXSegmentedView
import SnapKit
class YoSwiftViewCtl: YoBaseUIViewController {
    //分页基础配置
    var segmentedDataSource: JXSegmentedBaseDataSource?
    //分页器
     lazy var segmentedView : JXSegmentedView = {
        let segmentedView = JXSegmentedView()
        view.addSubview(segmentedView)
        return segmentedView
    }()
    //分页容器
    lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self)
        view.addSubview(listContainerView)
        return listContainerView
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //处于第一个item的时候，才允许屏幕边缘手势返回
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
     override func viewDidLoad() {
        super.viewDidLoad()
         self.navView.isHidden = true
        self.view.backgroundColor =  .hex("FE5E2F")
         let titles = ["语法", "算法", "基础", "功能", "封装"]
         //配置数据源
         let dataSource = JXSegmentedTitleDataSource()
         dataSource.titleNormalColor = .white
         dataSource.titleSelectedColor = .hex("#FFE9D7")
         dataSource.titleNormalFont =  .systemFont(ofSize: 18, weight: .medium)
         dataSource.titleSelectedFont =  .systemFont(ofSize: 18, weight: .medium)
         dataSource.isTitleZoomEnabled = true
         dataSource.isTitleColorGradientEnabled = true
         dataSource.titles = titles
         self.segmentedDataSource = dataSource
         //配置指示器
         let indicator = JXSegmentedIndicatorLineView()
         indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
         indicator.indicatorColor = .white
         indicator.verticalOffset = 3
         self.segmentedView.indicators = [indicator]
         self.segmentedView.dataSource =   self.segmentedDataSource
         self.segmentedView.delegate = self
         segmentedView.listContainer = listContainerView
//         self.segmentedView.reloadData()
//         segmentedView.reloadDataWithoutListContainer()
         
    }
}
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
//MARK： 容器代理
extension YoSwiftViewCtl:  JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
     //
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return YoSwiftListViewCtl()
    }
}
