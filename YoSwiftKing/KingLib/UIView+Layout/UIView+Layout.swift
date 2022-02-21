//
//  File.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit

extension UIView {
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        } set(value) {
            frame = CGRect(x: value, y: y, width: width, height: height)
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        } set(value) {
            frame = CGRect(x: x, y: value, width: width, height: height)
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        } set(value) {
            frame = CGRect(x: x, y: y, width: value, height: height)
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        } set(value) {
            frame = CGRect(x: x, y: y, width: width, height: value)
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        } set(value) {
            frame = CGRect(origin: value, size: frame.size)
        }
    }
    
    public var size: CGSize {
        get {
            return frame.size
        } set(value) {
            frame = CGRect(origin: frame.origin, size: value)
        }
    }
    
    public var centerX: CGFloat {
        get {
            return center.x
        } set(value) {
            center = CGPoint(x: value, y: centerY)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return center.y
        } set(value) {
            center = CGPoint(x: centerX, y: value)
        }
    }
    
    public var top: CGFloat {
        get {
            return y
        } set(value) {
            y = value
        }
    }
    
    public var left: CGFloat {
        get {
            return x
        } set(value) {
            x = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return y + height
        } set(value) {
            y = value - height
        }
    }

    public var right: CGFloat {
        get {
            return x + width
        } set(value) {
            x = value - width
        }
    }
}
