//
//  YoRefreshDetailViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import UIKit
class YoRefreshDetailViewCtl: YoBaseUIViewController {
    private lazy var  scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        return scrollView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
