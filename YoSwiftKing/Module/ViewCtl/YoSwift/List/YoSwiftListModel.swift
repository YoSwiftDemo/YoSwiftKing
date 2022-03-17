//
//  YoSwiftViewListModel.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/3.
//

import UIKit
import HandyJSON
//MARK: sction Model
class YoSwiftViewListSectionModel: HandyJSON {
    var title: String = ""// 标题
    var rows: [YoSwiftViewListModel]?
    required init(){}

}
//MARK: row Model
class YoSwiftViewListModel: HandyJSON {
    var title: String = ""// 标题
    var text: String = "" // 文本描述
    required init(){
        
    } // 必须实现一个空的初始化方法
}
