//
//  UIColor+Expand.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/21.
//

import UIKit
extension UIColor {
    // test发现height 要传view的总高度，而不是要渲染区域的高度
    public  static func gradientColor(colors: [UIColor], startPoint: CGPoint = CGPoint.zero, height: CGFloat) -> UIColor? {
        
        guard !colors.isEmpty else {
            return nil
        }
        let size = CGSize(width: 1, height: height)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let cgColors = colors.map({ $0.cgColor })
        guard let colorSpace = colors[0].cgColor.colorSpace else {
            return nil
        }
        guard let gradients = CGGradient(colorsSpace: colorSpace, colors: NSArray(array: cgColors), locations: nil) else {
            UIGraphicsEndImageContext()
            return nil
        }
        context?.drawLinearGradient(gradients, start: startPoint, end: CGPoint(x: 0, y: size.height), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        return UIColor(patternImage: UIImage(cgImage: cgImage))
    }
    
    public static func gradientColor(colors: [UIColor], startPoint: CGPoint = CGPoint.zero, width: CGFloat) -> UIColor? {
        
        guard !colors.isEmpty else {
            return nil
        }
        let size = CGSize(width: width, height: 1)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let cgColors = colors.map({ $0.cgColor })
        guard let colorSpace = colors[0].cgColor.colorSpace else {
            return nil
        }
        guard let gradients = CGGradient(colorsSpace: colorSpace, colors: NSArray(array: cgColors), locations: nil) else {
            UIGraphicsEndImageContext()
            return nil
        }
        context?.drawLinearGradient(gradients, start: startPoint, end: CGPoint(x: size.width, y: 0), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        return UIColor(patternImage: UIImage(cgImage: cgImage))
    }
    
    /// 渐变色
    ///
    /// - Parameters:
    ///   - colors: 颜色
    ///   - point: 结束点的位置，从（0，0）点到 point点的颜色绘制
    public static func gradientColor(colors: [UIColor], point: CGPoint) -> UIColor? {
        
        guard !colors.isEmpty else {
            return nil
        }
        let size = CGSize(width: point.x, height: point.y)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let cgColors = colors.map({ $0.cgColor })
        guard let colorSpace = colors[0].cgColor.colorSpace else {
            return nil
        }
        guard let gradients = CGGradient(colorsSpace: colorSpace, colors: NSArray(array: cgColors), locations: nil) else {
            UIGraphicsEndImageContext()
            return nil
        }
        context?.drawLinearGradient(gradients, start: CGPoint.zero, end: CGPoint(x: size.width, y: size.height), options: [])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else {
            return nil
        }
        return UIColor(patternImage: UIImage(cgImage: cgImage))
    }
}
