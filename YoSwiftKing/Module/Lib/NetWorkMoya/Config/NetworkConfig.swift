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
    static let proUrl =  "http://123.57.254.149:10086"
 
    // 开发 外网连本地
    static let devUrl = "http://123.57.254.149:10086"
    
    /// 测试环境
     static let testUrl = "http://123.57.254.149:10086"
    
    // 发布环境
    static let releaseUrl =  "http://123.57.254.149:10086"
    
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
