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
        $0.image = R.image.loginLogo()
        view.addSubview($0)
    }
    //标题
    lazy var loginTitleLab = UILabel().then  {
        view.addSubview($0)
    }
    //账号
    lazy var accountView = UIView().then  {
        view.addSubview($0)
    }
    //账号输入
    lazy var accountTf = UITextField().then {
        view.addSubview($0)
    }
    //密码
    lazy var pswView = UIView().then  {
        view.addSubview($0)
    }
    //密码输入
    lazy var pswTf = UITextField().then {
        view.addSubview($0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //布局
        logoImgView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(view)
            make.height.equalTo(234*CGFloat.sale)
        }
        //标题
        
    }
}
extension LoginViewCtl {
    
}
