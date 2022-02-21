//
//  TradeListTableViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
import SnapKit
//MARK:
class TradeListTableViewCtl: UIViewController, UITableViewDataSource {
    //数据
     var listData = [Any]()
    //声明表
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TradeListTableCell.self, forCellReuseIdentifier: NSStringFromClass(TradeListTableCell.self))
        return tableView
    }()
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //测试 数据
        var model = TradeListModel()
        model.title = "生活费"
        model.text = "2206 Kingnights Bridge"
        model.date = "2020.10.12"
        model.expenses = "3000P"
         
         var model2 = TradeListModel()
         model2.title = "书本费"
         model2.text = "2206 Kingnights Bridge"
         model2.date = "2020.10.12"
         model2.expenses = "788900P"
         
        listData = [model,model2]
        layoutViewCtlSubviews()
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return listData.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listData[indexPath.section] as! TradeListModel
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TradeListTableCell.self))! as! TradeListTableCell
        cell.titleLab.text = model.title as String?
        cell.textLab.text = model.text
        cell.dateLab.text = model.date
        cell.expensesLab.text = model.expenses
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
extension TradeListTableViewCtl: UITableViewDelegate {
    //行高
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15+20+10+20+15+1
    }
}


