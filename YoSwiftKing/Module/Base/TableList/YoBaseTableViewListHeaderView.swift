//
//  YoBaseTableViewListHeaderView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/10.
//

import UIKit
class YoBaseTableViewListHeaderView: UIView {
    public  lazy var lineView: UIView = {
        let view = UIView()
        self.addSubview(view)
        view.backgroundColor = .hex("FE5E2F")
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    //名称
    public  lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = TradeConfig.instance.titleColor
        lab.font =  .systemFont(ofSize: 18, weight: .bold)
        lab.textAlignment = .left
        self.addSubview(lab)
        return lab
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //布局
    open override func layoutSubviews() {
        super.layoutSubviews()
        //分割线
        lineView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(4)
            make.bottom.equalTo(self).offset(-10)
        }
        //标题  物业费
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(self.lineView.snp.right).offset(10)
            make.centerY.equalTo(self)
            make.width.greaterThanOrEqualTo(0)
            make.height.greaterThanOrEqualTo(10)
        }
    }
}
