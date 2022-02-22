//
//  TradeConfig.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
import SwiftUI
//MARK:
open class TradeConfig: NSObject{
    /// 单例，设置一次全局使用
    public static let instance: TradeConfig = {
        let instance = TradeConfig()
        return instance
    }()
    //字号相关
    //1级标题  比如 代缴费/委托
    public var mainTitleFont: UIFont =  .boldSystemFont(ofSize: 16)
    
    //选择按钮字号
    public var selectButtonFont: UIFont =  .systemFont(ofSize: 12)
    
    //2级标题    cell里 标题 物业费/地产税/水费
    public var titleFont: UIFont =  .systemFont(ofSize: 14)
    //1级文本    Kingnights Bridge
    public var textFont: UIFont =  .systemFont(ofSize: 12)
    //2级文本    2021.10.12
    public var textSubFont: UIFont =  .systemFont(ofSize: 10)
   
   
    //渐变色
    public var navStartColor: UIColor = .red
    public var navEndColor: UIColor = .yellow
    
    //1级标题  顶部分页栏标题
    public var mainTitleColor: UIColor  = .white
    //选择按钮 -  按钮颜色
    public var  selectBtnSelectedColor: UIColor = .black
    //选择按钮 - 未选择验证
    public var  selectBtnNormalColor: UIColor = .lightTextColor
    //选择区背景色
    public var changTypeColor: UIColor = .lightBackgroundColor
    
    //2级标题  cell 标题颜色
    public var titleColor: UIColor  = .black
    //1级文本  Kingnights Bridge
    public var textColor: UIColor = .black
    //2级文本    2021.10.12
    public var textSubColor: UIColor = .lightTextColor
    
    
    //分割线颜色 cell里
    public var lineColor: UIColor = .lightBackgroundColor
    
    //高度相关
    //交易顶部
    public var tradeTopBackgroundHeight: CGFloat = 44+44  //注意告诉+ 顶部状态栏高度44或20
    

    
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
