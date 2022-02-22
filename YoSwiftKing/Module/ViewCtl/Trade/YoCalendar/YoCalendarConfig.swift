//
//  YoCalendarConfig.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/22.
//

import UIKit
open class YoCalendarConfig: NSObject{
    /// 单例，设置一次全局使用
    public static let instance: YoCalendarConfig = {
        let instance = YoCalendarConfig()
        return instance
    }()
}
