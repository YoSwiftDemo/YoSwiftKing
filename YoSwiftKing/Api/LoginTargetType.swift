//
//  SwiftTargetType.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/10.
//   https://github.com/copoile/blog-web

import Moya
import DefaultsKit
enum LoginTargetType: SYTargetType {
    // 首页主播列表
    case accountLogin(username: String, password: String)
    case  oauth(type: String, code: String)

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
        case .accountLogin:
            return "/account/login"
        case .oauth:
            return "/oauth"
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

    
