//
//  CategoryTargetType.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/13.
//

import Foundation
import Moya
import DefaultsKit
enum CategoryTargetType: SYTargetType {
    // 一级分类parentId传0，若分类不需区分上下级parentId都传0即可
    //分类增
    case categoryAdd(name: String, parentId: String)
    //分页获取分类  非必传，默认1   5
    case  categoryPage(current: String, size: String)

    var baseURL: URL {
            return URL(string:  NetworkConfig.testUrl)!
    }
    var headers: [String : String]? {
//        var token = ""
//        let device = String.jk.stringWithUUID() ?? ""
//        //token
//        let defaults = Defaults()
//        if defaults.has(.token), let oneToken =  defaults.get(for: .token) {
//            token = oneToken
//        }
        return   ["Authorization":"Basic cGM6MTIzNDU2"]
       // return  ["device":device,"token":token]
    }
    
    var path: String {
        switch self {
        case .categoryAdd:
            return "/category/add"
        case .categoryPage:
            return "/category/page"
        }
    }
    
    var method: Moya.Method {
        return .post
//        switch self {
//        case .accountLogin:
//             return .get
//             default:
//           return .post
//        }
  
    }
    
    // return .requestParameters(parameters: [:], encodindo g: URLEncoding.default)
  //  return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["username": username, "password": password])
    var task: Task {
        switch self {
        case .accountLogin(let username, let  password):
            return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["username": username, "password": password])
        case .oauth(let type,  let code):
            return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["type": type, "code": code])
        }
    }
      
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}

    
