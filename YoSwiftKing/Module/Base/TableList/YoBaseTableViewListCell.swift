//
//  YoBaseTableViewListCell.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/10.
//

import UIKit
import SnapKit
open class YoBaseTableViewListCell: UITableViewCell {
 var indexPath: NSIndexPath?
    //语言标识
  public  lazy var textLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.font = .systemFont(ofSize: 12)
        lab.textAlignment = .left
        contentView.addSubview(lab)
        return lab
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
        textLab.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.bottom.equalTo(contentView)
        }
    }
}
