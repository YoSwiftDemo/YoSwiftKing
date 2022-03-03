//
//  YoUIImage.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/22.
//

import UIKit

extension UIImage {
    
    /// 由颜色生成图片
    /// - Parameter color: 颜色
    /// - Returns: 图片
    public static func image(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}
