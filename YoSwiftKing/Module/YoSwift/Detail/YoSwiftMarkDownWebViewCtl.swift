//
//  YoSwiftMarkDownWebViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/17.
//

import Foundation
import JXSegmentedView
class YoSwiftMarkDownWebViewCtl: YoMarkDownWebViewCtl {
    //视图将要加载
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK: JXSegmentedView必须实现
extension YoSwiftMarkDownWebViewCtl: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

