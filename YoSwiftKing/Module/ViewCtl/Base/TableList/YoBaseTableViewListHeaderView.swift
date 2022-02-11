//
//  YoBaseTableViewListHeaderView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/10.
//

import UIKit
class YoBaseTableViewListHeaderView: UIView {
    //标题
    public lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = .systemFont(ofSize: 12)
        lab.textAlignment = .left
        addSubview(lab)
        return lab
    }()
    //初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   //布局
   override func layoutSubviews() {
           super.layoutSubviews()
           titleLab.snp.makeConstraints { make in
               make.centerY.equalTo(self)
               make.left.equalTo(self).offset(10)
               make.width.lessThanOrEqualTo(self)
               make.height.lessThanOrEqualTo(self)
           }
    }
}
