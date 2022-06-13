//
//  LoginViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/11.
//

import UIKit
import Then
import SnapKit
class LoginViewCtl: YoBaseUIViewController {
    //logo
    lazy  var logoImgView = UIImageView().then {
        view.addSubview($0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //布局
        logoImgView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(234*CGFloat.sale)
        }
    }
}
extension LoginViewCtl {
    
}
