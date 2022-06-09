//
//  YoSwiftDetailDemoViewCtl..swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/17.
//

import UIKit
import JXSegmentedView
class YoSwiftDetailDemoViewCtl:  YoBaseUIViewController {

    override func viewDidLoad() {
       super.viewDidLoad()
        self.navView.isHidden = true
    }
}
//MARK: JXSegmentedView必须实现
extension YoSwiftDetailDemoViewCtl: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
