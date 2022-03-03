//
//  YoBaseNavView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//

import UIKit
import SnapKit
/*
 左侧按钮  自带返回
 中间标题
 */
// MARK:代理 protocol
protocol YoBaseUINavigationControllerDelegate: NSObjectProtocol {
   // @objc optional  // 可选方法
    func selectedLeftButtonAction(on leftBtn: UIButton) //左侧按钮方法  // 必须实现的方法
}
// MARK: 类
class YoBaseNavView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //代理
    weak var delegate:YoBaseUINavigationControllerDelegate?
    //UI返回那妞
    lazy var leftButton: UIButton = {
        let btn = UIButton()
        addSubview(btn)
        btn.addTarget(self, action: #selector(leftButtonAction(leftBtn:)), for: .touchUpInside)
        return btn
    }()
    //标题
    var title: String = ""
    //UI-标题
    lazy var textLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .black
        lab.font = .systemFont(ofSize: 16)
        addSubview(lab)
        return lab
    }()
}
// MARK: 子视图+布局
extension YoBaseNavView {
    override func layoutSubviews() {
        //默认添加左侧返回按钮 +布局
        leftButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(self)
            make.width.height.equalTo(self) //默认44
        }
        //默认添加标题
        textLabel.snp.makeConstraints { make in
            make.center.height.equalTo(self)//默认44
            make.height.width.lessThanOrEqualTo(self)
        }
    }
}
// MARK: 私有方法
extension YoBaseNavView {
    @objc  func leftButtonAction(leftBtn: UIButton){
        guard delegate != nil , (((delegate?.responds(to: Selector.init(("selectedLeftButtonAction:"))))) != nil) else{
            return
        }
        delegate!.selectedLeftButtonAction(on: leftBtn)
    }
}



