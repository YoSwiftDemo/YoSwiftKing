//
//   YoSwiftViewListCell.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/3.
//

import UIKit
import SnapKit
//MARK:  cell
class YoSwiftViewListCell: UITableViewCell {
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
          lab.textColor = TradeConfig.instance.textSubColor
          lab.font = TradeConfig.instance.textFont
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
               make.left.equalTo(contentView).offset(20)
               make.top.equalTo(contentView).offset(20)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(13)
           }
           //说明文本 2206 Kingnights Bridge
           textLab.snp.makeConstraints { make in
               make.left.equalTo(titleLab)
               make.bottom.equalTo(contentView.snp.bottom).offset(-16)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(14)
           }
           //分割线
           lineView.snp.makeConstraints { make in
               make.height.equalTo(1)
               make.bottom.equalTo(contentView)
               make.left.equalTo(contentView).offset(20)
               make.right.equalTo(contentView).offset(-20)
           }
       }
   }
