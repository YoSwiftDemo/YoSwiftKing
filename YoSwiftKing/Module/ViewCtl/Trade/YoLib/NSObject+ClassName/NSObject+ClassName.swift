//
//  NSObject+ClassName.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import Foundation
//MARK: 获取类 名称
extension NSObject {
    // MARK:返回className
    /// 类名
    public var className: String {
        get{
            //   var  selfStr = String(describing:type(of: self))
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
            
        }
    }
    /// 类名
    public static var className: String {
        return String(describing: self)
    }
}
