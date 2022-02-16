//
//   YoRefreshDetailViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import UIKit
class YoRefreshListViewCtl: YoBaseTableListViewController {
     override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .green
    //测试 数据
         var model = YoBaseTableViewListSectionModel()
         model.title = "UIScrollView刷新封装"
         var row1 = YoBaseTableViewListModel()
         row1.title = "Header1"
         var row2 = YoBaseTableViewListModel()
         row2.title = "Header2"
         model.list = [row1, row2]
         listData = [model]
         layoutViewCtlSubviews()
    }
}
