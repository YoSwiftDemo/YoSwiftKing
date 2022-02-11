//
//  YoBaseTableViewListModel.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import Foundation
import UIKit
import HandyJSON

struct YoBaseTableViewListSectionModel: HandyJSON {
    var title: String? //区 标题
    var list: [YoBaseTableViewListModel] = []  // 数组
}
struct YoBaseTableViewListModel: HandyJSON  {
    var title: NSString? //行标题
}
