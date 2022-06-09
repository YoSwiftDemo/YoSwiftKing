//
//  NetworkConfig.swift
//  SYMoyaNetwork
//
//  Created by ShannonYang on 2021/7/14.
//  Copyright © 2021 Shannon Yang. All rights reserved.
//

import Foundation
import Moya

public struct NetworkConfig {
    
    public typealias LogConfiguration = SYMoyaNetworkLoggerPlugin.Configuration
    
    public static let sharedInstance : NetworkConfig = NetworkConfig()

    public var logConfiguration: LogConfiguration = NetworkConfig.defaultLogConfiguration()
    
    public var networkCache: NetworkCache = NetworkConfig.defaultNetworkCache()
    
    
    /// 生产环境(本地)
    static let proUrl =  "http://192.168.1.91:8603"
 
    // 开发 外网连本地
    static let devUrl = "http://dev-api.hymetlive.com:8603"
    
    /// 测试环境
     static let testUrl = "http://test-cdn.hymetlive.com"
    
    // 发布环境
    static let releaseUrl =  "https://app-api.hyshowlive.com"
    
    
    //视频
    static let  VIDEO_URL="https://hkong.bscstorage.com/video-boomlive/"
     //图片前缀
    static let picUrl = "https://hkong.bscstorage.com/picture-boomlive/"
     //国家图片 前缀
    static let countryUrl = "https://hkong.bscstorage.com/map-boomlive/"
     //头像
    static let  AVATAR_URL = "https://hkong.bscstorage.com/head-boomlive/"
    //礼物
    static let giftUrl = "https://hkong.bscstorage.com/gift-boomlive/"
    static let email = "hyshowlive@gmail.com"
    
    
}

// MARK: - Private

extension NetworkConfig {
    
   static func defaultLogConfiguration() -> LogConfiguration {
        return LogConfiguration()
    }
    
    static func defaultNetworkCache() -> NetworkCache {
        return NetworkCache(name: "Default")
    }

}
