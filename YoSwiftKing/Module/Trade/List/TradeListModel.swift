//
//  TradeListModel.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
import HandyJSON
//MARK: Model
 struct TradeListModel: HandyJSON {
    var title: String? // 标题  eg：物业费
    var text: String? // 文本描述 eg：2206 Kingnights Bridge
    var date: String? // 时间  eg：2020.10.112
    var expenses: String? //费用值  eg：3000P
}
