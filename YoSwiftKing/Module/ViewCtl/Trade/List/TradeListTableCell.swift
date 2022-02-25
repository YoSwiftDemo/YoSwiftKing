//
//  TradeListTableCell.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
import SnapKit
//MARK:  cell
class TradeListTableCell: UITableViewCell {
    var indexPath: NSIndexPath?
       //计费名称
     public  lazy var titleLab: UILabel = {
           let lab = UILabel()
           lab.textColor = TradeConfig.instance.titleColor
           lab.font = TradeConfig.instance.titleFont
           lab.textAlignment = .left
           contentView.addSubview(lab)
           return lab
       }()
      //说明文本
    public  lazy var textLab: UILabel = {
          let lab = UILabel()
          lab.textColor = TradeConfig.instance.textColor
          lab.font = TradeConfig.instance.textFont
          lab.textAlignment = .left
          contentView.addSubview(lab)
          return lab
      }()
    //时间
    public  lazy var dateLab: UILabel = {
          let lab = UILabel()
          lab.textColor = TradeConfig.instance.textSubColor
          lab.font = TradeConfig.instance.textFont
          lab.textAlignment = .left
          contentView.addSubview(lab)
          return lab
      }()
     //总费用
    public  lazy var expensesLab: UILabel = {
          let lab = UILabel()
          lab.textColor = TradeConfig.instance.titleColor
          lab.font = TradeConfig.instance.titleFont
          lab.textAlignment = .left
          contentView.addSubview(lab)
          return lab
      }()
      //分割线
     public  lazy var lineView: UIView = {
          let line = UIView()
           line.backgroundColor = TradeConfig.instance.lineColor
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
               make.top.equalTo(titleLab.snp.bottom).offset(15)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
           }
           //时间
           dateLab.snp.makeConstraints { make in
               make.left.equalTo(titleLab.snp.right).offset(15)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
               make.centerY.equalTo(titleLab)
           }
           //总费用
           expensesLab.snp.makeConstraints { make in
               make.centerY.equalTo(contentView)
               make.right.equalTo(contentView).offset(-15)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(20)
           }
           //分割线
           lineView.snp.makeConstraints { make in
               make.height.equalTo(1)
               make.bottom.equalTo(contentView)
               make.left.equalTo(contentView).offset(15)
               make.right.equalTo(contentView).offset(-15)
           }
       }
   }
