//
//  YoTagsLabView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/24.
//

import UIKit

//MARK: 代理  YoTagsLabViewProtocol
//可选
@objc public protocol YoTagsLabViewProtocol: NSObjectProtocol {
    @objc optional func tagsViewUpdatePropertyModel(_ tagsView: YoTagsLabView, item: YoTagsPropertyModel,index: NSInteger) -> Void
    @objc optional func tagsViewUpdateHeight(_ tagsView: YoTagsLabView, sumHeight: CGFloat) -> Void
    @objc optional func tagsViewTapAction(_ tagsView: YoTagsLabView) -> Void
    @objc optional func tagsViewItemTapAction(_ tagsView: YoTagsLabView, item: YoTagsPropertyModel,index: NSInteger) -> Void
}



public class YoTagsLabView: UIView {
  //数据源
    public var dataSource: [String] = [] {
        didSet {
            config()
        }
    }
    //数据源
    public var modelDataSource: [YoTagsPropertyModel] = [] {
        didSet {
            config()
        }
    }
    /** 代理*/
    open weak var tagsViewDelegate : YoTagsLabViewProtocol?
    /** 默认显示行数;  0 为全部显示， 设置 YoTagsLabViewScrollDirection = horizontal, showLine 无效*/
    private var showLine: UInt = YoTagsLabViewConfig.instance.showLine {
        willSet {
            if newValue > 0 {
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(tagsViewTapAction))
                self.addGestureRecognizer(tap)
            }
        }
    }
    /** showLine 大于0 的时候 显示*/
    public var arrowImageView: UIImageView = UIImageView.init(image: UIImage.init(named: "arrow")?.withRenderingMode(.alwaysOriginal))
    /** 是否选中*/
    public var isSelect = false
    
    /** tagsView 宽度 default  is 屏幕宽度  */
    private var tagsViewWidth = UIScreen.main.bounds.width
    
    /** 记录*/
    private var dealDataSource: [YoTagsPropertyModel] = [YoTagsPropertyModel]()
    
    private var scrollView = UIScrollView()
    
    private var contentSize = CGSize.zero
    
    public var selectModel: YoTagsPropertyModel? //记录当前选中tag 索引
    
    public override init(frame:CGRect) {
        super.init(frame: frame)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        arrowImageView.isHidden = true
        addSubview(scrollView)
        addSubview(arrowImageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -- setup数据
extension YoTagsLabView {
    
    public func reloadData() -> Void {
        
        layoutIfNeeded()
        
        var tagX: CGFloat =  YoTagsLabViewConfig.instance.tagsViewContentInset.left
        var tagY: CGFloat =  YoTagsLabViewConfig.instance.tagsViewContentInset.top
        var tagW: CGFloat = 0.0
        var tagH: CGFloat = 0.0
        
        var labelW: CGFloat = 0.0
        var labelH: CGFloat = 0.0
        var LableY: CGFloat = 0.0
        var imageY: CGFloat = 0.0
        
        // 下一个tag的宽度
        var nextTagW: CGFloat = 0.0
        // 记录当前的行数，
        var currentLine: UInt = 1
        // 记录当前行数的全部数据
        var showLineDataSource: [YoTagsPropertyModel] = [YoTagsPropertyModel]()
        
        // 设置arroImageView
        arrowImageView.isHidden = !(dealDataSource.count > 0 && showLine > 0)
        if arrowImageView.isHidden {
            tagsViewWidth = frame.width
        }else {
            let arrowImageViewSize = arrowImageView.bounds.size
            arrowImageView.frame = CGRect(x: frame.width -  YoTagsLabViewConfig.instance.tagsViewContentInset.right - arrowImageViewSize.width, y:  YoTagsLabViewConfig.instance.tagsViewContentInset.top, width: arrowImageViewSize.width, height: arrowImageViewSize.height)
            tagsViewWidth = frame.width - arrowImageViewSize.width - 10
            let angle = isSelect == true ? Double.pi : 0.0
            UIView.animate(withDuration: 0.3) { [unowned self] in
                arrowImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(angle))
            }
        }
        
        for (index,propertyModel) in dealDataSource.enumerated() {
            
            if  tagsViewDelegate?.responds(to: #selector(tagsViewDelegate?.tagsViewItemTapAction(_:item:index:))) ?? false {
                let tap = UITapGestureRecognizer(target: self, action: #selector(contentViewTapAction(gestureRecongizer:)))
                propertyModel.contentView.addGestureRecognizer(tap)
            }
            
            propertyModel.contentView.tag = index
            
            tagW = tagWidth(propertyModel)
            
            switch YoTagsLabViewConfig.instance.scrollDirection {
            case .vertical:
                if tagW > tagsViewWidth -  YoTagsLabViewConfig.instance.tagsViewContentInset.left -  YoTagsLabViewConfig.instance.tagsViewContentInset.right {
                    tagW = tagsViewWidth -  YoTagsLabViewConfig.instance.tagsViewContentInset.left -  YoTagsLabViewConfig.instance.tagsViewContentInset.right
                }
            case .horizontal:
                break
            }
            
            labelW = tagW - (propertyModel.contentInset.left + propertyModel.contentInset.right + propertyModel.tagContentPadding + propertyModel.imageWidth)
            
            labelH = tagHeight(propertyModel, width: labelW)
            
            let contentH = labelH < propertyModel.imageHeight ? propertyModel.imageHeight : labelH
            
            tagH = contentH + propertyModel.contentInset.top + propertyModel.contentInset.bottom
            
            tagH = tagH < propertyModel.minHeight ? propertyModel.minHeight : tagH
            
            LableY = (tagH - labelH) * 0.5
            
            imageY = (tagH - propertyModel.imageHeight) * 0.5
            
            propertyModel.contentView.frame = CGRect(x: tagX, y: tagY, width: tagW, height: tagH)
            
            //剪切问题
            if YoTagsLabViewConfig.instance.tagLayerCornerRadius == 0 && YoTagsLabViewConfig.instance.tagLayerMasksToBounds {
                propertyModel.contentView.layer.cornerRadius = tagH/2
            }else{
                propertyModel.contentView.layer.cornerRadius = YoTagsLabViewConfig.instance.tagLayerCornerRadius
            }
            //处理背景色问题
            if selectModel == nil {
                selectModel = propertyModel
            }
            if self.selectModel!.index == propertyModel.index {
                propertyModel.isSelected = true
            }else{
                propertyModel.isSelected = false
            }
            
            switch propertyModel.imageAlignmentMode {
            case .left:
                propertyModel.imageView.frame = CGRect(x: propertyModel.contentInset.left,
                                                       y: imageY,
                                                       width: propertyModel.imageWidth,
                                                       height: propertyModel.imageHeight)
                propertyModel.titleLabel.frame = CGRect(x:  propertyModel.imageView.frame.maxX + propertyModel.tagContentPadding,
                                                        y: LableY,
                                                        width: labelW,
                                                        height: labelH)
            case .right:
                propertyModel.titleLabel.frame = CGRect(x: propertyModel.contentInset.left, y: LableY, width: labelW, height: labelH)
                propertyModel.imageView.frame = CGRect(x: propertyModel.titleLabel.frame.maxX + propertyModel.tagContentPadding, y: imageY, width: propertyModel.imageWidth, height: propertyModel.imageHeight)
            }
            
            if showLine >= currentLine {
                showLineDataSource.append(propertyModel)
            }
            
            // 下一个tag，X,Y位置
            let nextTagX = tagX + tagW + YoTagsLabViewConfig.instance.minimumInteritemSpacing
            
            switch YoTagsLabViewConfig.instance.scrollDirection {
            case .vertical:
                // 获取下一个tag的宽度
                if index < dealDataSource.count - 1 {
                    let nextIndex = index + 1
                    let nextPropertyModel = dealDataSource[nextIndex]
                    nextTagW = tagWidth(nextPropertyModel)
                }
                if nextTagX + nextTagW +  YoTagsLabViewConfig.instance.tagsViewContentInset.right > tagsViewWidth {
                    currentLine = currentLine + 1
                    tagX =  YoTagsLabViewConfig.instance.tagsViewContentInset.left
                    
                    let subDealDataSource = dealDataSource[0...index]
                    let maxYModel = subDealDataSource.max { (m1, m2) -> Bool in
                       return m1.contentView.frame.maxY < m2.contentView.frame.maxY
                    }
                    
                    let lastObjFrame = maxYModel!.contentView.frame
                    tagY = lastObjFrame.maxY + YoTagsLabViewConfig.instance.minimumLineSpacing
                }else {
                    tagX = nextTagX
                }
            case .horizontal:
                tagX = nextTagX
            }
        }
        
        // 最大收合数 等于 总数量 说明 不需要展开 隐藏箭头图标
        if showLineDataSource.count == dealDataSource.count {
            arrowImageView.isHidden = true
        }
       
        var sumHeight = YoTagsLabViewConfig.instance.tagsViewMinHeight
        var scrollContentSize = CGSize.zero
        var viewContentSize = CGSize(width: tagsViewWidth, height: sumHeight)
        
        switch YoTagsLabViewConfig.instance.scrollDirection {
        case .vertical:
        
            if dealDataSource.count != 0 {
                var lastPropertyModel: YoTagsPropertyModel!
                
                if showLine > 0 && isSelect == false {
                    lastPropertyModel = filterMaxYModel(dataSource: showLineDataSource, standardModel: showLineDataSource.last!)
                }else {
                    lastPropertyModel = filterMaxYModel(dataSource: dealDataSource, standardModel: dealDataSource.last!)
                }
                
                sumHeight = lastPropertyModel!.contentView.frame.maxY +  YoTagsLabViewConfig.instance.tagsViewContentInset.bottom
                scrollContentSize = CGSize(width: tagsViewWidth, height: sumHeight)
                sumHeight = sumHeight > YoTagsLabViewConfig.instance.tagsViewMaxHeight ? YoTagsLabViewConfig.instance.tagsViewMaxHeight : sumHeight
                viewContentSize = CGSize(width: tagsViewWidth, height: sumHeight)
            }
        case .horizontal:
            
            if dealDataSource.count != 0 {
                let lastPropertyModel = filterMaxYModel(dataSource: dealDataSource, standardModel: dealDataSource.last!)
                let sumWidth = lastPropertyModel.contentView.frame.maxX +  YoTagsLabViewConfig.instance.tagsViewContentInset.right
                sumHeight = lastPropertyModel.contentView.frame.maxY +  YoTagsLabViewConfig.instance.tagsViewContentInset.bottom
                scrollContentSize = CGSize(width: sumWidth, height: sumHeight)
                viewContentSize = scrollContentSize
            }
        }
        
        frame.size.height = sumHeight
        scrollView.frame = CGRect(x: 0, y: 0, width: tagsViewWidth, height: sumHeight)
        scrollView.contentSize = scrollContentSize;
        
        if (!contentSize.equalTo(viewContentSize)) {
            contentSize = viewContentSize;
            // 通知外部IntrinsicContentSize失效
            invalidateIntrinsicContentSize()
        }
        
        tagsViewDelegate?.tagsViewUpdateHeight?(self, sumHeight: sumHeight)
        
    }
    
    public override var intrinsicContentSize: CGSize {
       return contentSize
    }
}

  //MARK: -- private
extension YoTagsLabView {
    
    private func config() {
        
         dealDataSource.removeAll()
         scrollView.subviews.forEach {  $0.removeFromSuperview() }
        
        if dataSource.count > 0 {
            for (index, value) in dataSource.enumerated() {
                let propertyModel = YoTagsPropertyModel()
                propertyModel.titleLabel.text = value
                propertyModel.index = index
                if let d = tagsViewDelegate  {
                    d.tagsViewUpdatePropertyModel?(self, item: propertyModel, index: index)
                }
                scrollView.addSubview(propertyModel.contentView)
                dealDataSource.append(propertyModel)
            }
        }else {
            for (index,item) in modelDataSource.enumerated() {
                if let d = tagsViewDelegate  {
                    d.tagsViewUpdatePropertyModel?(self, item: item, index: index)
                }
                scrollView.addSubview(item.contentView)
                dealDataSource.append(item)
            }
        }
    
     }

    private func tagWidth(_ model: YoTagsPropertyModel) -> CGFloat {
        let w = ceil(sizeWidthText(model).width) + 0.5 + model.contentInset.left + model.contentInset.right + model.tagContentPadding + model.imageWidth
        return w
    }
    
    private func sizeWidthText(_ model: YoTagsPropertyModel) -> CGSize {
        return model.titleLabel.text?.size(withAttributes: [.font : model.titleLabel.font!]) ?? CGSize.zero
    }
    
    private func tagHeight(_ model: YoTagsPropertyModel, width: CGFloat) -> CGFloat {
        let size = model.titleLabel.text?.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options:[.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: [.font : model.titleLabel.font!], context: nil)
        return ceil(size?.height ?? 0.0)
    }
    
    // filter  - result return maxYModel
    private func filterMaxYModel(dataSource:[YoTagsPropertyModel],standardModel:YoTagsPropertyModel) -> YoTagsPropertyModel {
        let maxYModel = dataSource.filter { (m) -> Bool in
            m.contentView.frame.minY == standardModel.contentView.frame.minY
         }.max { (m1, m2) -> Bool in
            m1.contentView.frame.maxY <= m2.contentView.frame.maxY
         }
        return maxYModel!
    }
}

//MARK: -- action
extension YoTagsLabView {
    @objc func contentViewTapAction(gestureRecongizer: UIGestureRecognizer) {
        let int = gestureRecongizer.view?.tag ?? 0
        if let d = tagsViewDelegate {
            self.selectModel?.isSelected = false
            let item = dealDataSource[int];
            item.isSelected = true 
//            item.isSelected = !item.isSelected
            self.selectModel = item
            d.tagsViewItemTapAction?(self, item: dealDataSource[int], index: int)
        }
    }
    
    @objc func tagsViewTapAction() {
        tagsViewDelegate?.tagsViewTapAction?(self)
    }
}

//MARK: -- 设置每个tag的属性
public class YoTagsPropertyModel: NSObject {
    public var index: Int?
    public enum YoTagImageViewAlignmentMode {
        case right
        case left
    }
    
    /** 正常的图片*/
    public var normalImage:UIImage? {
        willSet {
            if selectIedImage == nil { selectIedImage = newValue }
            if isSelected == false { imageView.image = newValue }
        }
    }
    /** 选中状态的图片*/
    public var selectIedImage:UIImage? {
        willSet {
            if isSelected == true { imageView.image = newValue }
        }
    }
    /** 图片的大小*/
    public var imageSize: CGSize {
        willSet {
            imageView.frame.size = newValue
        }
    }
    /** 是否选中*/
    public var isSelected: Bool = false {
        willSet {
            imageView.image = newValue ? selectIedImage : normalImage
            let config = YoTagsLabViewConfig.instance
            contentView.backgroundColor =  newValue ? config.tagSelectedBgColor :  config.tagNormalBgColor
            titleLabel.textColor =  newValue ? config.tagSelectTextColor :  config.tagNormalTextColor
        }
    }
    /** image 和title 的间距 默认为8.0 ,设置image时生效*/
    public var contentPadding: CGFloat = 8.0
    /** 每个tag 最小高度 default is 0 */
    public var minHeight: CGFloat = 0.0
    /** 每个tag的边距 default is top:5,letf:5,bottom:5,right:5*/
    public var contentInset = YoTagsLabViewConfig.instance.contentInset
    //UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    /** 装载view*/
    public var contentView = UIView()
    /** 标题*/
    public var titleLabel = UILabel()
    /** 图片的位置*/
    public var imageAlignmentMode : YoTagImageViewAlignmentMode = .right
    
    /** 图片*/
    fileprivate var imageView = UIImageView()
    
    /** 默认为 image 大小*/
    fileprivate var imageWidth: CGFloat {
        guard let imageW = imageView.image?.size.width else {
            return 0.0
        }
        if imageView.frame != CGRect.zero, imageView.image != nil {
            return imageView.frame.width
        }
        return imageW
    }
    fileprivate var imageHeight: CGFloat {
        guard let imageH = imageView.image?.size.height else {
            return 0.0
        }
        if imageView.frame != CGRect.zero, imageView.image != nil {
            return imageView.frame.height
        }
        return imageH
    }
    fileprivate var tagContentPadding: CGFloat {
        get {
            return imageWidth > 0.0 ? contentPadding : 0.0
        }
    }
    public override init() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        /** 每个tagtext 默认值*/
        contentView.backgroundColor = YoTagsLabViewConfig.instance.tagNormalBgColor
//        contentView.layer.masksToBounds = true
//        contentView.layer.cornerRadius = YoTagsLabViewConfig.instance.tagLayerCornerRadius
        titleLabel.font = YoTagsLabViewConfig.instance.tagTextFont
        titleLabel.text = ""
        titleLabel.textColor = YoTagsLabViewConfig.instance.tagNormalTextColor
        titleLabel.numberOfLines = 0
        imageSize = CGSize.zero
        super.init()
    }
}

