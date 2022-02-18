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
         var row0 = YoBaseTableViewListModel()
         row0.title = "头部+指示器"
         var row1 = YoBaseTableViewListModel()
         row1.title = "头部+指示器+文字"
         var row2 = YoBaseTableViewListModel()
         row2.title = "头部+小gif"
         var row3 = YoBaseTableViewListModel()
         row3.title = "头部+大gif"
         var row4 = YoBaseTableViewListModel()
         row4.title = "头部+自定义"
         var row5 = YoBaseTableViewListModel()
         row5.title = "尾部+指示器"
         var row6 = YoBaseTableViewListModel()
         row6.title = "尾部+指示器+文字"
         var row7 = YoBaseTableViewListModel()
         row7.title = "尾部+指示器（自动，一拉就刷新）"
         var row8 = YoBaseTableViewListModel()
         row8.title = "尾部+指示器+文字（自动，一拉就刷新）"
         model.list = [row0, row1, row2, row3, row4, row5, row6, row7, row8]
         listData = [model]
         layoutViewCtlSubviews()
    }
    //选择cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtl = YoRefreshDetailViewCtl()
        if indexPath.row == 0 {
            viewCtl.refresh = .indicatorHeader
        }
        else if indexPath.row == 1 {
            viewCtl.refresh = .textHeader
        }
        else if indexPath.row == 2 {
            viewCtl.refresh = .smallGIFHeader
        }
        else if indexPath.row == 3 {
            viewCtl.refresh = .gifTextHeader
        }
        else if indexPath.row == 4 {
            viewCtl.refresh = .superCatHeader
        }
        else if indexPath.row == 5 {
            viewCtl.refresh = .indicatorFooter
        }
        else if indexPath.row == 6 {
            viewCtl.refresh = .textFooter
        }
        else if indexPath.row == 7 {
            viewCtl.refresh = .indicatorAutoFooter
        }
        else if indexPath.row == 8 {
            viewCtl.refresh = .textAutoFooter
        }else{
            
        }
        viewCtl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewCtl, animated: true)
    }
}
