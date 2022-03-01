//
//  YoCalendarConfig.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/22.
//

import UIKit
open class YoCalendarConfig: NSObject{
    /// 单例，设置一次全局使用
    public static let instance: YoCalendarConfig = {
        let instance = YoCalendarConfig()
        return instance
    }()
   //颜色相关
    //背景色  暂定黑色 0.2
    let containerColor: UIColor = .white
   //头部 背景 橘黄色FD6718
    let  topContainer: UIColor = UIColor.hex("#FD6718")
    //顶部 年颜色
    let yearTitleColor: UIColor = .hex("#AAAAAA", alpha: 0.2)
        //.hex("#AAAAAA")
    //日期  xx月xx日周x
    let monthDayWeekTitleColor: UIColor = .white
    //日期  xx年xx月
    let yearMonthTitleColor: UIColor = .black
    //周标题 容器 背景
    let weekContainerColor: UIColor = .yellow
    //日期 周标题   日 一 二 三 四 五 六
    let weekTitleColor: UIColor =  .red //UIColor.hex("#000000", alpha: 0.5)
    //日期  天 颜色
    let dayColor: UIColor = .black
    //
    //日期 容器 背景
    let daysContainerColor: UIColor = .red
    //选择日期颜色
    let selectedDayColor: UIColor = .green
    // 背景色 默认
    let dayBackgroundNormalColor: UIColor = .green
    //选择日期 背景色
    let dayBackgroundSelectedColor: UIColor = .yellow
    
    //选择按钮颜色   取消+确定
    let selectBtnColor: UIColor = UIColor.hex("#FD6718")
    
    //眼角弧度
    //背景圆角
    let  containerLayerCornerRadius: CGFloat = 10.0
    
    
    //高度
    //周标题 容器 背景
    let weekContainerHeight: CGFloat = 60
//    let weekTitleSpace: CGFloat = 10
    lazy var  weekTitleWidth: CGFloat = (375-(15+15)-(20+20))/CGFloat(weekTitleArray.count)
    //day宽度  = 周内 标题宽度
    lazy var dayWidth: CGFloat = weekTitleWidth
    let  dayHeight: CGFloat = 30
    let daySpace: CGFloat = 10  //设置day 上下间距
    
    
    //字体
    //年标题 字体大小
    let yearTitleFont: UIFont = .systemFont(ofSize: 16, weight: .bold)
    //月日周 标题 字体大小
    let monthDayWeekTitleFont : UIFont = .systemFont(ofSize: 24, weight: .heavy)
    //年月 标题 字体大小
    let yearMonthTitleFont : UIFont = .boldSystemFont(ofSize: 16)
    //周标题 字体大小
    let weekTitleFont : UIFont = .systemFont(ofSize: 16)
    //日 字体大小
    let dayFont : UIFont = .systemFont(ofSize: 16)
    //选择日期
    let selectedDayFont: UIFont = .systemFont(ofSize: 16)
    // 按钮大小  取消 确定
    let selectBtnFont: UIFont = .boldSystemFont(ofSize: 18)
    
    //星期数组  7天
    let weekTitleArray: [String] = ["日", "一", "二", "三", "四", "五", "六"]
    let timeArray = [["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"], ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]]
    //月数组  12个月
   let monthArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
}
