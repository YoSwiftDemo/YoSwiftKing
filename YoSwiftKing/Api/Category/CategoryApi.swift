//
//  CategoryApi.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/13.
//

import UIKit
import SwiftyJSON
import KakaJSON
import DefaultsKit
public class CategoryApi: NSObject {
    // 单例
     static let shared = CategoryApi()
     // 私有化构造方法，不允许外界创建实例
    
    private override init() {
         // 进行初始化工作
     }
    //只返回正确数据出去
    public func  categoryAddHandler( name: String, parentId: String ,handler: (@escaping (_ finished: Bool) -> Void)) {
        let provider = SYMoyaProvider<CategoryTargetType>()
        ///live/wallet/coin/exchange/list
        provider.responseSwiftyJSON(.server, target: .categoryAdd(name: name, parentId: parentId)) { (response: SYMoyaNetworkDataResponse<SwiftyJSON.JSON>) in
            switch response.result {
            case let .success(json):
                guard let isRegister = json["code"].int, isRegister == 0, let data = json["data"].array  else {
                    handler(false)
                    return
                }
                handler(true)
                break
            case let .failure(error):
                print(error)
                handler(false)
                break
            }
        }
    }
    //获取分类
    public func  categoryListHandler(handler: (@escaping (_ finished: Bool) -> Void)) {
        let provider = SYMoyaProvider<CategoryTargetType>()
        ///live/wallet/coin/exchange/list
        provider.responseSwiftyJSON(.server, target: .categoryList) { (response: SYMoyaNetworkDataResponse<SwiftyJSON.JSON>) in
            switch response.result {
            case let .success(json):
                guard let isRegister = json["code"].int, isRegister == 0, let data = json["data"].array  else {
                    handler(false)
                    return
                }
                handler(true)
                break
            case let .failure(error):
                handler(false)
                print(error)
                break
            }
        }
    }
    //分类树
    public func  categoryTreeHandler(handler: (@escaping (_ finished: Bool) -> Void)) {
        let provider = SYMoyaProvider<CategoryTargetType>()
        ///live/wallet/coin/exchange/list
        provider.responseSwiftyJSON(.server, target: .categoryTree) { (response: SYMoyaNetworkDataResponse<SwiftyJSON.JSON>) in
            switch response.result {
            case let .success(json):
                guard let code = json["code"].int, code == 0, let data = json["data"].array  else {
                    handler(false)
                    return
                }
                var models = [TagsModel]()
                for  i in 0 ..< data.count {

                    if   let dic = data[i].dictionary ,
                         let model = dic.kj.model(TagsModel.self) as? TagsModel {
                        models.append(model)
                    }
                }
                Defaults().set(models, for: .tags)
                handler(true)
                break
            case let .failure(error):
                handler(false)
                print(error)
                break
            }
        }
    }
    //更新分类
    public func  categoryUpdateHandler(name: String, id: String , handler: (@escaping (_ finished: Bool) -> Void)) {
        let provider = SYMoyaProvider<CategoryTargetType>()
        ///live/wallet/coin/exchange/list
        provider.responseSwiftyJSON(.server, target: .categoryUpdate(id: id, name: name)) { (response: SYMoyaNetworkDataResponse<SwiftyJSON.JSON>) in
            switch response.result {
            case let .success(json):
                guard let isRegister = json["code"].int, isRegister == 0, let data = json["data"].array  else {
                    handler(false)
                    return
                }
                handler(true)
                break
            case let .failure(error):
                handler(false)
                print(error)
                break
            }
        }
    }
}
