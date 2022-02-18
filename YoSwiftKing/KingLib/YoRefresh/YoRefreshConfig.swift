//
//  YoRefresh.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import UIKit
/*
 简单刷新
 https://www.jianshu.com/p/0c89263a6fd1
 
 */
//MARK:
open class YoRefreshConfig: NSObject{
    /// 单例，设置一次全局使用
    public static let instance: YoRefreshConfig = {
        let instance = YoRefreshConfig()
        return instance
    }()
    //下拉上拉 绘制箭头颜色
    public var arrowStrokeColor: UIColor =  UIColor.black.withAlphaComponent(0.5)
    //绘制箭头-宽
    public var arrowLineWidth: CGFloat = 2
    //菊花颜色
    public var activityIndicatorColor: UIColor = .gray
    //菊花风格
    public var activityIndicatorStyle: UIActivityIndicatorView.Style = .gray
    //文字大小
    public var titleTextFont: UIFont = .systemFont(ofSize: 14)
    //文字颜色
    public var  titleTextTextColor = UIColor.black.withAlphaComponent(0.8)
    //刷新状态文字 大小
    public var refreshTextFont: UIFont = .systemFont(ofSize: 14)
    //刷新状态文字颜色
    public var  refreshTextTextColor = UIColor.black.withAlphaComponent(0.8)
    //判断是不是中文环境
    private lazy var isChinese:Bool  = Locale.preferredLanguages[0].contains("zh-Han")
    //刷让你加载文字
    public lazy var loadingText =  isChinese ? "正在加载..." : "Loading..."
    //刷新头部文字
    public lazy var headerText = YoRefreshText(
        loadingText: loadingText,
        pullingText: isChinese ? "下拉刷新" : "Pull down to refresh",
        releaseText: isChinese ? "释放刷新" : "Release to refresh"
    )
    //刷新尾部文字
    public lazy var footerText = YoRefreshText(
        loadingText: loadingText,
        pullingText: isChinese ? "上拉加载" : "Pull up to load more",
        releaseText: isChinese ? "释放加载" : "Release to load more"
    )

    
}

//MARK: 全局- 刷新类型
///头部刷新
///底部刷新
///底部自动刷新
public enum YoRefreshStyle {
    case header, footer, autoFooter
}
//MARK: 全局-
public struct YoRefreshText {
    let loadingText: String
    let pullingText: String
    let releaseText: String
    public init(loadingText: String, pullingText: String, releaseText: String) {
        self.loadingText = loadingText
        self.pullingText = pullingText
        self.releaseText = releaseText
    }
}
//MARK: 全局- 
public enum YoRefreshType: String {
    case indicatorHeader = "Indicator Header"
    case textHeader = "Indicator + Text Header"
    case smallGIFHeader = "Small GIF Header"
    case bigGIFHeader = "Big GIF Header"
    case gifTextHeader = "GIF + Text Header"
    case superCatHeader = "SuperCat Custom Header"
    case indicatorFooter = "Indicator Footer"
    case textFooter = "Indicator + Text Footer"
    case indicatorAutoFooter = "Indicator Auto Footer"
    case textAutoFooter = "Indicator + Text Auto Footer"
    
    static let all: [YoRefreshType] = [.indicatorHeader,
                                 .textHeader,
                                 .smallGIFHeader,
                                 .bigGIFHeader,
                                 .gifTextHeader,
                                 .superCatHeader,
                                 .indicatorFooter,
                                 .textFooter,
                                 .indicatorAutoFooter,
                                 .textAutoFooter]
}
