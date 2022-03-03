//
//  YoImageTextButton.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/1.
//

import UIKit

public enum YoImageTextButtonType: Int {
    case topImageBottomTitle = 0    //图片在上文字在下
    case topTitleBottomImage    //文字在上图片在下
    case leftTitleRightImage    //文字在左图片在右
    case leftImageRightTitle    //图片在左文字在右(默认情况)
}

public class YoImageTextButton: UIButton {
    /// 文字图片显示位置类型
    private var type: YoImageTextButtonType = .leftImageRightTitle
    
    /// 文字图片间距
    private var space: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func updateConstraints() {
        resetEdgeInsets(type: type, space: space)
        
        super.updateConstraints()
    }
}
public extension YoImageTextButton{
    /// 重置edgeinsets
    //
    /// - Parameters:
    ///   - type: 图片文字位置类型, 默认左图片右文字
    ///   - space: 图片文字间距, 默认间距为0
    func resetEdgeInsets(type: YoImageTextButtonType = .leftImageRightTitle, space: CGFloat = 0.0) {
        self.type = type
        self.space = space
        
        let imageWidth = self.imageView!.frame.width
        let imageHeight = self.imageView!.frame.height
        
        var labelWidth = self.titleLabel!.frame.width
        var labelHeight = self.titleLabel!.frame.height
        
//        assert((imageWidth + labelWidth) > self.frame.width && (imageHeight + labelHeight) > self.frame.height, "button frame过小")
        
        if #available(iOS 8.0, *) {
            //高于 iOS 8.0
            labelWidth = self.titleLabel!.intrinsicContentSize.width
            labelHeight = self.titleLabel!.intrinsicContentSize.height
        }
        
        var titleTop, titleLeft, titleBottom, titleRight: CGFloat
        var imageTop, imageLeft, imageBottom, imageRight: CGFloat
        switch type {
        case .leftImageRightTitle:
            imageTop = 0
            imageBottom = 0
            imageLeft = -space / 2.0
            imageRight = -imageLeft
            
            titleTop = 0
            titleBottom = 0
            titleLeft = space / 2.0
            titleRight = titleLeft
            
        case .leftTitleRightImage:
            imageTop = 0
            imageBottom = 0
            imageLeft = labelWidth + space / 2.0
            imageRight = -imageLeft
            
            titleTop = 0
            titleBottom = 0
            titleLeft = -(imageWidth + space / 2.0)
            titleRight = -titleLeft
            
        case .topTitleBottomImage:
            imageTop = labelHeight / 2.0 + space / 2.0
            imageBottom = -imageTop
            imageLeft = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0
            imageRight = -imageLeft
            
            titleTop = -(imageHeight / 2.0 + space / 2.0)
            titleBottom = -titleTop
            //titleLeft偏移量 = imageWidth + labelWidth / 2.0 - (imageWidth + labelWidth) / 2.0, 计算之后为 imageWidth / 2.0
            titleLeft = -imageWidth / 2.0
            titleRight = -titleLeft
            
        case .topImageBottomTitle:
            imageTop = -(labelHeight / 2.0 + space / 2.0)
            imageBottom = -imageTop
            imageLeft = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0
            imageRight = -imageLeft
            
            titleTop = imageHeight / 2.0 + space / 2.0
            titleBottom = -titleTop
            //titleLeft偏移量 = imageWidth + labelWidth / 2.0 - (imageWidth + labelWidth) / 2.0, 计算之后为 imageWidth / 2.0
            titleLeft = -imageWidth / 2.0
            titleRight = -titleLeft
        }
        self.imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight)
        self.titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight)
    }
}
