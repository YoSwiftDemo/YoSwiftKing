//
//  YoTagsLabViewConfig.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/24.
//

import UIKit
open class YoTagsLabViewConfig: NSObject{
    /// 单例，设置一次全局使用
    public static let instance: YoTagsLabViewConfig = {
        let instance = YoTagsLabViewConfig()
        return instance
    }()
    //标签行间距
    public var minimumLineSpacing: CGFloat = 10.0
    // 标签的间距
    public var minimumInteritemSpacing: CGFloat = 10.0
   // tagsSupView的边距
    public var tagsViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    /** 每个tag的边距 default is top:5,letf:5,bottom:5,right:5*/
    public var contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    
      //tagsView 最小高度
    public var tagsViewMinHeight: CGFloat = 0.0 {
        didSet {
            // 限制条件
            tagsViewMinHeight = tagsViewMinHeight > tagsViewMaxHeight ? tagsViewMaxHeight : tagsViewMinHeight
        }
    }
    // tagsView 最大高度 default  is   MAXFLOAT；当contentSize 大于tagsViewMaxHeight ，则会滚动；scrollDirection == horizontal时，这个属性失效
    public var tagsViewMaxHeight: CGFloat = CGFloat(MAXFLOAT) {
        didSet {
            // 限制条件
            tagsViewMaxHeight = tagsViewMaxHeight < tagsViewMinHeight ? tagsViewMinHeight : tagsViewMaxHeight
        }
    }
    /** tagsView 滚动方向 default  is   Vertical*/
    public var scrollDirection : YoTagsLabViewScrollDirection = .vertical
    // 显示行数 0 全部显示
    public var showLine: UInt = 0
    
    
    //颜色相关
    //color  标签item 背景色
    //未选中tag 背景是
    let tagNormalBgColor: UIColor =  .hex("#FFFFFF")
    //选中tag 背景是
    let tagSelectedBgColor: UIColor =  .hex("#FB7830")
    //color  标签item 文字颜色
    let tagNormalTextColor: UIColor = .black
    //color  标签item 文字颜色
    let tagSelectTextColor: UIColor = .white

    
    //圆角相关
    let tagLayerCornerRadius: CGFloat = 0
    let tagLayerMasksToBounds: Bool =  true  // false+ 0 则是 高度一半
    //字号
    let  tagTextFont: UIFont = .systemFont(ofSize: 16, weight: .regular)
    
    
}
//MARK: 枚举 设置 滚动方向
public enum YoTagsLabViewScrollDirection {
    case vertical // 垂直方向
    case horizontal // 水平方向
}
