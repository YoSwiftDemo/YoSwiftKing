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
    //GET分页获取分类  非必传，默认1   5
    case  categoryPage(current: String, size: String)
    //GET获取分类列表
    case  categoryList
    //GET 获取分类树
    case categoryTree
    //修改分类
    case categoryUpdate(id: String, name: String)
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
        case .categoryAdd:
            return "/category/add"
        case .categoryPage:
            return "/category/page"
        case .categoryList:
            return "/category/list"
        case .categoryTree:
            return "/category/tree"
        case .categoryUpdate:
            return "/category/update"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categoryPage, .categoryList, .categoryTree :
             return .get
             default:
           return .post
        }
  
    }
    
    // return .requestParameters(parameters: [:], encodindo g: URLEncoding.default)
  //  return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["username": username, "password": password])
    var task: Task {
        switch self {
        case .categoryAdd(let name, let  parentId):
            return .requestCompositeParameters(bodyParameters:["name": name, "parentId": parentId], bodyEncoding: JSONEncoding.default,  urlParameters: [:] )
        case .categoryPage(let current,  let size):
            return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["current": current, "size": size])
        case .categoryList:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .categoryTree:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .categoryUpdate(let id, let name):
            return .requestCompositeParameters(bodyParameters:[:], bodyEncoding: JSONEncoding.default,  urlParameters: ["id": id, "name": name])
        }
    }
      
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}

    
