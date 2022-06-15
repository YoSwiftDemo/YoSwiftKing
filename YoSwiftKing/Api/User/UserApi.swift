//
//  UserApi.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/15.
//

import UIKit
import SwiftyJSON
import KakaJSON
import DefaultsKit
public class UserApi: NSObject {
    // 单例
     static let shared = UserApi()
     // 私有化构造方法，不允许外界创建实例
    
    private override init() {
         // 进行初始化工作
     }
    //只返回正确数据出去
    public func  categoryAddHandler( email: String ,handler: (@escaping (_ finished: Bool) -> Void)) {
        let provider = SYMoyaProvider<UserTargetType>()
        ///live/wallet/coin/exchange/list
        provider.responseSwiftyJSON(.server, target: .userEmailValidate(email: email)) { (response: SYMoyaNetworkDataResponse<SwiftyJSON.JSON>) in
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

}
