//
//  TradeDetailModel.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/23.
//

import Foundation
import HandyJSON
//MARK: Model
 struct TradeDetailModel: HandyJSON {
    var title: String? // 标题  eg：交易类型
    var content: String? // 文本描述 eg：代缴物业费
    var type: String? //类型  eg：0=文本 1=收据 显示箭头图标
}
