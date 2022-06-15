//
//  DefaultsKey+Ex.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/11.
//

import Foundation
import DefaultsKit
import  KakaJSON
extension DefaultsKey{
    static let token = Key<String>("token")
    static let tokenType = Key<String>("tokenType")
    
    static let  tags =  Key<[TagsModel]>("tags")
    
}
//3级数据
struct TagsModel: Codable, Convertible {
    var parentId : Int?
    var name : String?
    var id : Int?
    var children : [TagsModel]?
}


//https://www.jianshu.com/p/fb77c78de8a8
////映射属性 userModel 为模型属性， user_Model 为后台json给的字段
// override func kj_modelKey(from property: Property) -> ModelPropertyKey {
//     switch property.name{
//     case "userModel": return "user_Model"
//     default:return property.name
