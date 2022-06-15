//
//  UserTargetType.swift
//  YoSwiftKing
//
//  Created by admin on 2022/6/10.
//

import Foundation
import Moya
import DefaultsKit
enum UserTargetType: SYTargetType {
    //邮箱验证 /user/email/validate  email：邮箱
    case userEmailValidate(email: String)
    //绑定邮箱 /user/email/bind
    case userEmailBind(code: String)

    var baseURL: URL {
            return URL(string:  NetworkConfig.testUrl)!
    }
    var headers: [String : String]? {
        var token = ""
        let defaults = Defaults()
        if defaults.has(.token), let oneToken =  defaults.get(for: .token), defaults.has(.tokenType), let tokenType =  defaults.get(for: .tokenType)  {
            token =   tokenType + " "  + oneToken
        }
        return   ["Authorization": token]
    }
    
    var path: String {
        switch self {
        case .userEmailValidate:
            return "/user/email/validate"
        case .userEmailBind:
            return "/user/email/bind"
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
  //邮箱验证
        case .userEmailValidate(let email):
            return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["email": email] )
            //绑定邮箱
        case .userEmailBind(let code):
            return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["code": code] )
        }
    }
      
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}

    
