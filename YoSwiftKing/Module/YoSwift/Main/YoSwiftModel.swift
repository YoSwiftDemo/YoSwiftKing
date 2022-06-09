//
//  YoSwiftModel.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/17.
//
import UIKit
class YoSwiftModel: Codable {
    var code : Int
    var data : [YoSwiftTitleModel]?
    class YoSwiftTitleModel: Codable{
        var index: Int
        var title: String
    }
}
