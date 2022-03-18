//
//  YoSwiftViewListModel.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/3.
//

import UIKit
import HandyJSON
//

class YoSwiftViewModel: Codable {
    var sections: [YoSwiftViewListSectionModel]?
}
//MARK: sction Model
class YoSwiftViewListSectionModel: Codable {
    var title: String = ""// 标题
    var rows: [YoSwiftViewListModel]?
}
//MARK: row Model
class YoSwiftViewListModel: Codable {
    var title: String = ""// 标题
    var text: String = "" // 文本描述
    var markdown: String = ""
    var className: String = ""
}


