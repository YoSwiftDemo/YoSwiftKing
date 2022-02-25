//
//  TradeDetailViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/23.
//

import UIKit
import SnapKit
import LJTagsView
//MARK:
class TradeDetailViewCtl: UIViewController, UITableViewDataSource {
    //表头
    lazy var topView: TradeDetailTopView = {
        let topView = TradeDetailTopView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 150))
        view.addSubview(topView)
        return topView
    }()
    //列表数据
     var listData = [Any]()
    //声明列表
     lazy var tableView: UITableView = {
        let tableView = UITableView()
         view.addSubview(tableView)
         tableView.backgroundColor = .groupTableViewBackground
         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(TradeDetailTableCell.self, forCellReuseIdentifier: NSStringFromClass(TradeDetailTableCell.self))
         tableView.separatorStyle = .none
         return tableView
    }()
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
         navigationController?.navigationBar.isHidden = false
         title = "交易详情"
        //测试 数据
        var model = TradeDetailModel()
        model.title = "交易类型"
        model.content = "代缴费-物业费"

         var model2 = TradeDetailModel()
         model2.title = "业主信息"
         model2.content = "Todd Baker， 1976年5月10日"
         
        listData = [model,model2]
         self.topView.costLab.text = "30000P"
         self.topView.detailLab.text = "wek sjd aksdkadk "
         self.topView.backgroundColor = .groupTableViewBackground
         tableView.tableHeaderView = topView
        layoutViewCtlSubviews()
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return listData.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listData[indexPath.row] as! TradeDetailModel
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TradeDetailTableCell.self))! as! TradeDetailTableCell
        cell.titleLab.text = model.title as String?
        cell.textLab.text = model.content
        cell.indexPath = indexPath as NSIndexPath
        return cell
    }
    //MARK: 布局
    func layoutViewCtlSubviews() {
        //表
           tableView.snp.makeConstraints { make in
               make.top.left.bottom.right.equalTo(view)
           }
     }
}
extension TradeDetailViewCtl: UITableViewDelegate {
    //行高
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45+1
    }
}

