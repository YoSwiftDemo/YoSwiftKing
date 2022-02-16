//
//  YoBaseTableListViewController.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/10.
//

import UIKit
import SnapKit
open class YoBaseTableListViewController: YoBaseUIViewController, UITableViewDataSource {
    //数据
    open var listData = [Any]()
    //声明表
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(YoBaseTableViewListCell.self, forCellReuseIdentifier: NSStringFromClass(YoBaseTableViewListCell.self))
        return tableView
    }()
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
   //测试 数据
        var model = YoBaseTableViewListSectionModel()
        model.title = "播放器xxx"
        var row1 = YoBaseTableViewListModel()
        row1.title = "播放器1"
        var row2 = YoBaseTableViewListModel()
        row2.title = "播放器1"
        model.list = [row1, row2]
        listData = [model]
        layoutViewCtlSubviews()
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listData.count > 0 {
            let sectionModel = listData[section] as! YoBaseTableViewListSectionModel
            return sectionModel.list.count
        }else{
            return 0
        }
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = listData[indexPath.section] as! YoBaseTableViewListSectionModel
        let rowModel: YoBaseTableViewListModel = sectionModel.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(YoBaseTableViewListCell.self))! as! YoBaseTableViewListCell
        cell.textLab.text = rowModel.title as String?
        cell.indexPath = indexPath as NSIndexPath
        cell.backgroundColor = .orange
        return cell
    }
    //MARK: 布局
    open  func layoutViewCtlSubviews() {
           tableView.snp.makeConstraints { make in
               make.left.top.bottom.right.equalTo(view)
           }
     }
}
extension YoBaseTableListViewController: UITableViewDelegate {
    //行高
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //区头view
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //取数据
        let sectionModel = listData[section] as! YoBaseTableViewListSectionModel
//        var sectionDic = [String: Any]()
//        sectionDic = listData[section] as! [String : Any]
//        var title = ""
//        if sectionDic.keys.contains("title") {
//            title = sectionDic["title"] as! String
//        }
       let  headerView = YoBaseTableViewListHeaderView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        headerView.titleLab.text = sectionModel.title
        return headerView
    }
    //区头高
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}


