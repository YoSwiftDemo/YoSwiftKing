//
//  TradeDetailTopView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/23.
//

import UIKit
import SnapKit
//MARK: 自定义头部view
class TradeDetailTopView: UIView {
    //渐变色 容器
  public  lazy var container: UIView = {
        let view = UILabel()
      view.backgroundColor = UIColor.gradientColor(colors:[TradeConfig.instance.navStartColor,TradeConfig.instance.navEndColor],
                                                        startPoint: CGPoint(x: 0, y: 1),
                                                    width: self.frame.size.width)
        self.addSubview(view)
      view.layer.cornerRadius = 10
      view.layer.masksToBounds = true
        return view
    }()
    //花费 总数
  public  lazy var costLab: UILabel = {
        let costLab = UILabel()
      costLab.textColor = .white
      costLab.font = .systemFont(ofSize: 30, weight: .semibold)
      costLab.textAlignment = .left
        container.addSubview(costLab)
        return costLab
    }()
    //详情
  public  lazy var detailLab: UILabel = {
        let detailLab = UILabel()
      detailLab.textColor = .white
      detailLab.font = .systemFont(ofSize: 18, weight: .bold)
      detailLab.textAlignment = .left
        container.addSubview(detailLab)
        return detailLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //渐变色 容器
        container.snp.makeConstraints { make in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(90)
        }
        //费用
        costLab.snp.makeConstraints { make in
            make.left.equalTo(container).offset(30)
            make.top.equalTo(container).offset(20)
            make.right.equalTo(container).offset(-30)
            make.height.equalTo(25)
        }
        //说明
        detailLab.snp.makeConstraints { make in
            make.left.equalTo(container).offset(30)
            make.top.equalTo(costLab.snp.bottom).offset(5)
            make.right.equalTo(container).offset(-30)
            make.height.equalTo(20)
        }
    }
}
