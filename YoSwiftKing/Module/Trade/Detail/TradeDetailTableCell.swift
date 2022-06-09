//
//  TradeDetailTableCell.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/23.
//

import Foundation
import SnapKit
import UIKit
//MARK:  cell
class TradeDetailTableCell: UITableViewCell {
    var indexPath: NSIndexPath?
       //名称
     public  lazy var titleLab: UILabel = {
           let lab = UILabel()
         lab.textColor = .hex("#333333")
         lab.font = .systemFont(ofSize: 14, weight: .medium)
           lab.textAlignment = .left
           contentView.addSubview(lab)
           return lab
       }()
      //说明文本
    public  lazy var textLab: UILabel = {
          let lab = UILabel()
        lab.textColor = .hex("#333333")
        lab.font = .systemFont(ofSize: 14, weight: .regular)
          lab.textAlignment = .right
          contentView.addSubview(lab)
          return lab
      }()
    //时间
    public  lazy var nextImageView: UIImageView = {
          let imgView = UIImageView()
           contentView.addSubview(imgView)
        imgView.image = UIImage(named: "yo_calendar_right")
          return imgView
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
           self.backgroundColor = .white
       }
       
       required public init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       //布局
       open override func layoutSubviews() {
           super.layoutSubviews()
           //标题  物业费
           titleLab.snp.makeConstraints { make in
               make.left.equalTo(contentView).offset(16)
               make.centerY.equalTo(contentView)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(14)
           }
           //说明文本
           textLab.snp.makeConstraints { make in
               make.right.equalTo(contentView).offset(-16)
               make.centerY.equalTo(contentView)
               make.width.greaterThanOrEqualTo(0)
               make.height.equalTo(13)
           }
           //next
//           nextImageView.snp.makeConstraints { make in
//               make.left.equalTo(titleLab.snp.right).offset(10)
//               make.width.greaterThanOrEqualTo(0)
//               make.height.equalTo(20)
//               make.centerY.equalTo(titleLab)
//           }
           //分割线
           lineView.snp.makeConstraints { make in
               make.height.equalTo(1)
               make.bottom.equalTo(contentView)
               make.left.equalTo(contentView).offset(16)
               make.right.equalTo(contentView).offset(-16)
           }
       }
   }
