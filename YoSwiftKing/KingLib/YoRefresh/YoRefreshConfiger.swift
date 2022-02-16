//
//  YoRefresh.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import UIKit
//MARK: 刷新类型
///头部刷新
///底部刷新
///底部自动刷新
public enum RefreshStyle {
    case header, footer, autoFooter
}
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
    
    static let all: [Refresh] = [.indicatorHeader,
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
