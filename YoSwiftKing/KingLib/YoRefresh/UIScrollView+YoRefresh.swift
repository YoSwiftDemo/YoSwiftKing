//
//  UIScrollView+YoRefresh.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import UIKit
import WeakMapTable
private var headerKey: UInt8 = 0
private var footerKey: UInt8 = 0
private var tempFooterKey: UInt8 = 0
//MARK: UIScrollView 扩展刷新
extension UIScrollView {
    //MARK:增属性
    // AssociatedObject（关联对象）
    // YoRefreshView可以是可选类型，也可以不是可选类型
    //    头部刷新对象
    private var header: YoRefreshView?{
        get {
            return objc_getAssociatedObject(self, &headerKey) as? YoRefreshView
        }
        set {
            header?.removeFromSuperview()
            //源对象，关键字，关联的对象和一个关联策略
            objc_setAssociatedObject(self, &headerKey,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue.map {
                insertSubview($0, at: 0)
            }
        }
    }
    //属性 尾部刷新对象
    private var footer: YoRefreshView?{
        get {
            return objc_getAssociatedObject(self, &footerKey) as? YoRefreshView
        }
        set {
            footer?.removeFromSuperview()
            objc_setAssociatedObject(self, &footerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            newValue.map {
                insertSubview($0, at: 0)
            }
        }
    }
    //
    private var tempFooter: YoRefreshView? {
        get {
            return objc_getAssociatedObject(self, &tempFooterKey) as? YoRefreshView
        }
        set {
            objc_setAssociatedObject(self, &tempFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    //MARK: 头部刷新+指示器  Indicator header
    public func createHeaderIndicator(height: CGFloat = 60, action: @escaping () -> Void) {
        header = YoIndicatorRefreshView(isHeader: true,height: height,action: action)
    }
    //MARK:头部刷新+指示器+文字 Indicator + Text header
    public func  createHeaderIndicatorText(refreshText: YoRefreshText = headerText, height: CGFloat = 60,action: @escaping () -> Void) {
        header = YoIndicatorTextRefreshView(isHeader: true, refreshText: refreshText, height: height, action: action)
    }
    //MARK:头部刷新—— gif  GIF header
    public func  createHeaderGif(data: Data, isLarger: Bool = false, height: CGFloat = 60 ,action: @escaping () -> Void){
        header = YoGifHeaderRefreshView(data: data, isLarger: isLarger, height: height, action: action)
    }
    //MARK:头部刷新 +小图+文字 Gif+text
    public func createHeaderGifText(data: Data,isLarger: Bool = false, refreshText: YoRefreshText = headerText, height: CGFloat = 60,action: @escaping() -> Void) {
        header = YoGifHeaderRefreshView(data: data, isLarger: isLarger, height: height, action: action)
    }
    //MARK:Header
    public func createHeaderCustom(refreshView: YoRefreshView) {
        header = refreshView
    }
    //MARK:Footer
    public func createFooterCustom(refreshView:YoRefreshView ) {
       footer = refreshView
    }
    //MARK: 开始刷新方法
    public func bginRefreshing() {
        header?.beginRefreshing()
    }
    //结束刷新
    public func endRefreshing() {
        header?.endRefreshing()
        footer?.endRefreshing()
    }
    //MARK:没有更多了
    public func endRefreshingWithNoMoreData() {
        tempFooter = footer
        tempFooter?.endRefreshing{ [weak self] in
            self?.footer = nil
        }
    }
    //MARK:重置 没有更多了no more data
    public func resetNoMoreData() {
            if footer == nil {
                footer = tempFooter
            }
      }
    //MARK:尾部刷新+指示器 Footer +Indicator
    public func createFooterIndicator(height: CGFloat = 60, action: @escaping () -> Void) {
        footer = YoIndicatorRefreshView(isHeader: false, height: height, action: action)
    }
    //尾部刷新+指示器+文字 Footer +Indicator+text
    public func createFooterIndicatorText(refreshText: YoRefreshText = footerText,
                                          height: CGFloat = 60,
                                          action: @escaping () -> Void){
        footer = YoIndicatorTextRefreshView(isHeader: false, refreshText:refreshText , height: height, action: action)
    }
    //尾部刷新+指示器+Auto Footer + Indicator + Auto
    public func createFootertIndicatorAuto(height: CGFloat = 60, action: @escaping () -> Void) {
        footer = YoIndicatorAutoFooterRefreshView(height: height, action: action)
    }
    //尾部刷新+文字 +Auto Footer + Text +Auto
    public func createFooterTextAuto(loadingText: String = loadingText, height: CGFloat = 60, action: @escaping () -> Void) {
        footer = YoTextAutoFooterRefreshView(loadingText: loadingText, height: height, action: action)
    }
    // 清除 头部刷新
    public func clearHeader() {
        header = nil
    }
    //清除 尾部刷新
    public func clearFooter() {
        footer = nil
    }
}

private let isChinese = Locale.preferredLanguages[0].contains("zh-Han")

public let loadingText = isChinese ? "正在加载..." : "Loading..."

public let headerText = YoRefreshText(
    loadingText: loadingText,
    pullingText: isChinese ? "下拉刷新" : "Pull down to refresh",
    releaseText: isChinese ? "释放刷新" : "Release to refresh"
)

public let footerText = YoRefreshText(
    loadingText: loadingText,
    pullingText: isChinese ? "上拉加载" : "Pull up to load more",
    releaseText: isChinese ? "释放加载" : "Release to load more"
)
