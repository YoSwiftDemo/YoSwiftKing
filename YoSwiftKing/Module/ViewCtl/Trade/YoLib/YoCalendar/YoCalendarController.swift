//
//  YoCalendarController.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/23.
//

import UIKit
//class YoCalendarController: UIControl {
//    //日历UI层
//    lazy var calendarView: YoCalendarView = {
//        let view = YoCalendarView()
//        self.addds
//    }()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
// 
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
////MARK: 公有方法
//extension YoCalendarController {
//    //加载 显示
//    func show() {
//        let ctl = UIControl(frame: UIScreen.main.bounds)
//        ctl.backgroundColor = UIColor(white: 0, alpha: 0.5)
//        ctl.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
//        var window:UIWindow = UIApplication.shared.keyWindow!
//        if #available(iOS 13.0, *) {
//            window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).last!
//        }
//        window.addSubview(ctl)
//        
//    }
//}
////MARK:私有方法 加载显示
//extension YoCalendarView {
//    //MARK:-弹出视图
//   @objc private func dismiss() {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.alpha = 0
//        }) { (finished) in
//            self.removeFromSuperview()
//        }
//    }
//}
