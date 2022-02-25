//
//  TradeConfig.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
//import SwiftUI
//MARK:
open class TradeConfig: NSObject{
    /// 单例，设置一次全局使用
    public static let instance: TradeConfig = {
        let instance = TradeConfig()
        return instance
    }()
    

    
    //字号相关 -----
    //1级标题
    //比如 代缴费/委托
    public var mainTitleFont: UIFont = .boldSystemFont(ofSize: 18)
    //选择按钮字号
    public var selectButtonFont: UIFont =  .systemFont(ofSize: 16)
    //2级标题    cell里  title 标题  生活费/物业费/地产税/水费
    public var titleFont: UIFont = .systemFont(ofSize: 16)
    //1级文本    Kingnights Bridge
    public var textFont: UIFont =  .systemFont(ofSize: 14)
    //2级文本    2021.10.12
    public var textSubFont: UIFont =  .systemFont(ofSize: 12)
   
   
    //颜色相关 -------
    //渐变色
    public var navStartColor: UIColor =  .hex("#FB7830")
    public var navEndColor: UIColor = .hex("#FF983A")
    //2个选择按钮 背景层
    public var  selectBtnBgViewColor: UIColor =  .groupTableViewBackground
    //标签层背景色
    public var tagsViewBgColor: UIColor = .groupTableViewBackground
    //1级标题  顶部分页栏标题 未选择
    public var mainTitleColor: UIColor  = .hex("#FEE9D7")
    //1级标题  顶部分页栏标题  选择
    public var mainTitleSelectColor: UIColor  = .hex("#FFFFFF")
    //选择按钮 -  按钮颜色
    public var  selectBtnSelectedColor: UIColor = .black
    //选择按钮 - 未选择验证
    public var  selectBtnNormalColor: UIColor = .black
    //选择区背景色
    public var changTypeColor: UIColor = .lightBackgroundColor

    //2级标题  cell 标题颜色
    public var titleColor: UIColor  = .black
    //1级文本  Kingnights Bridge
    public var textColor: UIColor = .black
    //2级文本    2021.10.12
    public var textSubColor: UIColor = .hex("#AAAAAA")
    
    //分割线颜色 cell里
    public var lineColor: UIColor = .hex("#AAAAAA", alpha: 0.1)
    
    //间距相关
    //顶部 标题间距
    public var titleMargin: CGFloat =  UIScreen.main.bounds.size.width/4.5
    //交易顶部
    public var tradeTopBackgroundHeight: CGFloat = 44+44+5  //注意告诉+ 顶部状态栏高度44或20
    

    
}
//MARK: 全局-
public enum YoTradeConfigType: String {
    case billPayment = "代缴费"
    case entrust = "委托"
    case transferOwnership = "过户"
    static let all: [YoTradeConfigType] = [.billPayment,
                                 .entrust,
                                 .transferOwnership]
}
