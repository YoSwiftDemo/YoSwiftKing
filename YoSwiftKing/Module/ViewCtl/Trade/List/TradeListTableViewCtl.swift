//
//  TradeListTableViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
import SnapKit
import HandyJSON
//MARK: Model
 struct TradeListModel: HandyJSON {
    var title: String? // 标题  eg：物业费
    var text: String? // 文本描述 eg：2206 Kingnights Bridge
    var date: String? // 时间  eg：2020.10.112
    var expenses: String? //费用值  eg：3000P
}
//MARK:  cell
class TradeListTableCell: UITableViewCell {
    var indexPath: NSIndexPath?
       //计费名称
     public  lazy var titleLab: UILabel = {
           let lab = UILabel()
           lab.textColor = YoTradeConfig.instance.titleColor
           lab.font = YoTradeConfig.instance.titleFont
           lab.textAlignment = .left
           contentView.addSubview(lab)
           return lab
       }()
      //说明文本
    public  lazy var textLab: UILabel = {
          let lab = UILabel()
          lab.textColor = YoTradeConfig.instance.textColor
          lab.font = YoTradeConfig.instance.textFont
          lab.textAlignment = .left
          contentView.addSubview(lab)
          return lab
      }()
    //时间
    public  lazy var dateLab: UILabel = {
          let lab = UILabel()
          lab.textColor = YoTradeConfig.instance.textSubColor
          lab.font = YoTradeConfig.instance.textFont
          lab.textAlignment = .left
          contentView.addSubview(lab)
          return lab
      }()
     //总费用
    public  lazy var expensesLab: UILabel = {
          let lab = UILabel()
          lab.textColor = YoTradeConfig.instance.titleColor
          lab.font = YoTradeConfig.instance.titleFont
          lab.textAlignment = .left
          contentView.addSubview(lab)
          return lab
      }()
      //分割线
     public  lazy var lineView: UIView = {
          let line = UIView()
           line.backgroundColor = YoTradeConfig.instance.lineColor
          contentView.addSubview(line)
          return line
      }()
    
       //初始化
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           self.selectionStyle = .none
       }
       
       required public init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       //布局
       open override func layoutSubviews() {
           super.layoutSubviews()
           //标题  物业费
           titleLab.snp.makeConstraints { make in
               make.left.equalTo(contentView).offset(10)
               make.top.equalTo(contentView).offset(10+5)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
           }
           //说明文本
           textLab.snp.makeConstraints { make in
               make.left.equalTo(titleLab)
               make.top.equalTo(titleLab.snp.bottom).offset(10)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
           }
           //时间
           dateLab.snp.makeConstraints { make in
               make.left.equalTo(titleLab.snp.right).offset(10)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
               make.centerY.equalTo(titleLab)
           }
           //总费用
           expensesLab.snp.makeConstraints { make in
               make.centerY.equalTo(contentView)
               make.right.equalTo(contentView).offset(-10)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
           }
           //分割线
           lineView.snp.makeConstraints { make in
               make.height.equalTo(1)
               make.bottom.equalTo(contentView)
               make.left.equalTo(contentView).offset(10)
               make.right.equalTo(contentView).offset(-10)
           }
           
       }
   }
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
        model.title = "物业费"
        model.text = "2206 Kingnights Bridge"
        model.date = "2020.10.12"
        model.expenses = "3000P"
        listData = [model]
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
           tableView.snp.makeConstraints { make in
               make.left.top.bottom.right.equalTo(view)
           }
     }
}
extension TradeListTableViewCtl: UITableViewDelegate {
    //行高
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15+20+10+20+15+1
    }
}


