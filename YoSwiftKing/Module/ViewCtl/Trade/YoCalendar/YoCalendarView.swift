//
//  YoCalendarView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/23.
//

import UIKit
import SnapKit
public class YoCalendarView: UIView {
    //选择年份 默认年
    private  var selectedYear: Int?
    //选择年份 默认月
    private  var selectedMonth: Int?
    //选择年份 默认日
    private  var selectedDay: Int?
    
    //
    private  lazy var currentWindow: UIWindow = {
        var window:UIWindow = UIApplication.shared.keyWindow!
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).last!
        }
        return window
    }()
    //UI - 控制层
    private lazy var control: UIControl = {
        let ctl = UIControl(frame: UIScreen.main.bounds)
        ctl.backgroundColor = UIColor(white: 0, alpha: 0.5)
        ctl.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        self.addSubview(ctl)
        self.sendSubviewToBack(ctl)
        return ctl
    }()
    //ui 背景层 容器
      private lazy var containerView: UIView = {
          let container = UIView()
          self.addSubview(container)
          container.backgroundColor = YoCalendarConfig.instance.containerColor
          container.layer.cornerRadius = YoCalendarConfig.instance.containerLayerCornerRadius
          container.layer.masksToBounds = true
          //定义view的阴影颜色
          container.layer.shadowColor = UIColor.black.cgColor
        //阴影偏移量
          container.layer.shadowOffset=CGSize(width:0, height:1)
        //定义view的阴影宽度，模糊计算的半径
          container.layer.shadowRadius = 10
        //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
          container.layer.shadowOpacity = 0.1
          return container
      }()
    //顶部 容器
    private lazy var topContainer: UIView = {
        let container = UIView()
        containerView.addSubview(container)
        container.backgroundColor = YoCalendarConfig.instance.topContainer
        return container
    }()
    //顶部  年 标题
    private lazy var yearTitleLab: UILabel = {
        let lab = UILabel()
        topContainer.addSubview(lab)
        lab.font =  YoCalendarConfig.instance.yearTitleFont
        lab.textColor =  YoCalendarConfig.instance.yearTitleColor
        lab.text = "2022"
        return lab
    }()
    //月日周
    private lazy var monthDayWeekTitleLab: UILabel = {
        let lab = UILabel()
        topContainer.addSubview(lab)
        lab.font =  YoCalendarConfig.instance.monthDayWeekTitleFont
        lab.textColor =  YoCalendarConfig.instance.monthDayWeekTitleColor
        lab.text = "9月21日周三"
        return lab
    }()
    
    //底部部 容器
    private lazy var bottomContainer: UIView = {
        let container = UIView()
        containerView.addSubview(container)
        return container
    }()
    //周 容器
    private lazy var weekContainer: UIView = {
        let weekContainer = UIView()
        bottomContainer.addSubview(weekContainer)
        weekContainer.backgroundColor =  YoCalendarConfig.instance.weekContainerColor
        return weekContainer
    }()
    //日历列表区
    private lazy var daysContainer: UIView = {
        let daysContainer = UIView()
        bottomContainer.addSubview(daysContainer)
        daysContainer.backgroundColor =  YoCalendarConfig.instance.daysContainerColor
        return daysContainer
    }()
    
    //左侧上一个月按钮
    private lazy var lastMonnthBtn: UIButton = {
        let btn = UIButton()
        bottomContainer.addSubview(btn)
        btn.setTitle("上一个月", for: .normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(monthChangeBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    //右侧侧上一个月按钮
    private lazy var nextMonnthBtn: UIButton = {
        let btn = UIButton()
        bottomContainer.addSubview(btn)
        btn.setTitle("下一个月", for: .normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(monthChangeBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    //中间 年月 标题
    private lazy var yearMonthTitleLab: UILabel = {
        let lab = UILabel()
        bottomContainer.addSubview(lab)
        lab.font = YoCalendarConfig.instance.yearMonthTitleFont
        lab.textColor =  YoCalendarConfig.instance.yearMonthTitleColor
        lab.textAlignment = .center
        lab.text = "2022年2月"
        return lab
    }()
    
 

    
    //底部 取消
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        bottomContainer.addSubview(btn)
        btn.setTitle("取消", for: .normal)
        btn.backgroundColor = YoCalendarConfig.instance.selectBtnColor
        btn.titleLabel?.font = YoCalendarConfig.instance.selectBtnFont
        btn.addTarget(self, action: #selector(bottomCancelBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    //底部 确定
    private lazy var sureBtn: UIButton = {
        let btn = UIButton()
        bottomContainer.addSubview(btn)
        btn.setTitle("确定", for: .normal)
        btn.backgroundColor = YoCalendarConfig.instance.selectBtnColor
        btn.titleLabel?.font = YoCalendarConfig.instance.selectBtnFont
        btn.addTarget(self, action: #selector(bottomSureBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:  UIScreen.main.bounds.size.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:布局
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutYoCalendarView()
    }
}
//MARK:布局
extension YoCalendarView {
    //布局
    private func layoutYoCalendarView(){
        self.control.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        //ui容器
        containerView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(375-15-15)
            make.height.equalTo(640)
        }
        topContainer.snp.makeConstraints { make in
            make.top.left.right.equalTo(containerView)
            make.height.equalTo(120)
        }
        //年
        yearTitleLab.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.left.equalTo(topContainer).offset(30)
            make.right.equalTo(topContainer).offset(-15)
            make.top.equalTo(topContainer).offset(20)
        }
        //月日周
        monthDayWeekTitleLab.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.equalTo(topContainer).offset(30)
            make.right.equalTo(topContainer).offset(-30)
            make.top.equalTo(yearTitleLab.snp.bottom).offset(10)
        }
        
        //底部
        //底部容器
        bottomContainer.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom)
            make.left.equalTo(containerView)
            make.right.equalTo(containerView)
            make.bottom.equalTo(containerView)
        }
        //左侧 上一个月
        lastMonnthBtn.snp.makeConstraints { make in
            make.left.equalTo(bottomContainer).offset(40)
            make.width.equalTo(80)
            make.top.equalTo(bottomContainer).offset(20)
            make.height.equalTo(40)
        }
        //右侧 下一个月
        nextMonnthBtn.snp.makeConstraints { make in
            make.right.equalTo(bottomContainer).offset(-40)
            make.width.equalTo(80)
            make.top.equalTo(bottomContainer).offset(20)
            make.height.equalTo(40)
        }
        // 年月 标题
        yearMonthTitleLab.snp.makeConstraints { make in
            make.centerY.equalTo(lastMonnthBtn)
            make.left.equalTo(lastMonnthBtn.snp.right)
            make.right.equalTo(nextMonnthBtn.snp.left)
            make.height.equalTo(30)
        }
        //周 容器
        weekContainer.snp.makeConstraints { make in
            make.left.equalTo(bottomContainer).offset(20)
            make.right.equalTo(bottomContainer).offset(-20)
            make.height.equalTo(YoCalendarConfig.instance.weekContainerHeight)
            make.top.equalTo(nextMonnthBtn.snp.bottom).offset(20)
        }
        
        //日期区域
        daysContainer.snp.makeConstraints { make in
            make.left.equalTo(bottomContainer).offset(20)
            make.right.equalTo(bottomContainer).offset(-20)
            make.top.equalTo(weekContainer.snp.bottom).offset(20)
            make.bottom.equalTo(bottomContainer).offset(-30-40-20)
        }
        
        //确定
        sureBtn.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.right.equalTo(containerView).offset(-40)
            make.bottom.equalTo(containerView).offset(-30)
        }
        //取消
        cancelBtn.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(80)
            make.right.equalTo(containerView).offset(-40-80-20)
            make.bottom.equalTo(containerView).offset(-30)
        }
    
    }
}

//MARK:公有方法 加载显示
extension YoCalendarView {
    //添加子控件
    public func show(){
        //布局子控件
        self.addSubview(control)
        self.sendSubviewToBack(control)
        currentWindow.addSubview(self)
        
        
        
        let count = YoCalendarConfig.instance.weekTitleArray.count
        for i in 0..<count {
            let itemWidth = YoCalendarConfig.instance.weekTitleWidth
        let lab = UILabel()
           lab.text = YoCalendarConfig.instance.weekTitleArray[i]
            weekContainer.addSubview(lab)
            lab.textColor  = YoCalendarConfig.instance.weekTitleColor
            lab.font  = YoCalendarConfig.instance.weekTitleFont
            lab.textAlignment = .center
            lab.snp.makeConstraints { make in
                make.centerY.equalTo(self.weekContainer)
                make.height.equalTo(self.weekContainer)
                make.width.equalTo(itemWidth)
                make.left.equalTo(self.weekContainer).offset(CGFloat(i)*itemWidth)
            }
        }
        daysShow()
        
    }
    
}

//MARK:私有方法 加载显示
extension YoCalendarView {
    //MARK:-弹出视图
   @objc private func dismiss() {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.alpha = 0
//        }) { (finished) in
            self.control.removeFromSuperview()
            self.removeFromSuperview()
//        }
    }
    //MARK: 月份变更按钮Action
    @objc private func monthChangeBtnAction(_ monthChangeBtn: UIButton) {
        print("月份变更按钮Action")
    }
    //MARK: 底部 取消 按钮Action
    @objc private func bottomCancelBtnAction(_ monthChangeBtn: UIButton) {
        print("底部 取消 按钮Action")
    }
    //MARK: 底部 确定按钮Action
    @objc private func bottomSureBtnAction(_ monthChangeBtn: UIButton) {
        print("底部 确定按钮Action")
    }
    //日期列表刷新
//    @objc private func daysRefresh() {
//        let  firstDay = firstDayOfWeekInMonth()
//        let totalDays = numberOfDaysInMonth()
//            for i in 0...37 {
//                //寻找btn
//                if let btn = self.daysContainer.viewWithTag(i+10086) as? UIButton {
//                    btn.isSelected = false
//                    if i < (firstDay - 1) || (i > (totalDays + firstDay - 2)) {
//                        btn.isEnabled = false
//                        btn.setTitle("", for: .normal)
//                    } else {
//                        if year == selectYear && month == selectMonth {
//                            if day == (btn.tag - KBtnTag - (firstDay - 2)) {
//                                btn.isSelected = true
//                                let week = weekArray?[(btn.tag - KBtnTag)%7]
//                                weekLabel.text = "星期\(week ?? "")"
//                                dayLabel.text = "\(day ?? 0)"
//                            }
//                        } else {
//                            btn.isSelected = false
//                            dayLabel.text = nil
//                        }
//
//                        btn.isEnabled = true
//                        let d = i - (firstDay - 1) + 1
//                        btn.setTitle("\(d)", for: .normal)
//                    }
//                }
//            }
//    }
    
    
    
    @objc private func daysShow() {
    //每一个日期用一个按钮去创建，当一个月的第一天是星期六并且有31天时为最多个数，5行零2个，共37个
            for i in 0...KMaxCount {
        //            let margin: CGFloat = 2.0
                let btnX = CGFloat(i%7) * YoCalendarConfig.instance.dayWidth
                let btnY = CGFloat(i/7) * YoCalendarConfig.instance.dayHeight
                
                let btn = UIButton(type: .custom)
                btn.frame = CGRect(x: btnX, y: btnY, width: KBtnW, height: KBtnW)
                btn.tag = i + 10086
                btn.layer.cornerRadius = KBtnW/2
                btn.layer.masksToBounds = true
                btn.titleLabel?.font = YoCalendarConfig.instance.dayFont
                btn.setTitle("\(i + 1)", for: .normal)
                btn.setTitleColor(YoCalendarConfig.instance.dayColor, for: .normal)
                btn.setTitleColor(YoCalendarConfig.instance.selectedDayColor, for: .selected)
        
                btn.setBackgroundImage(self.imageWithColor(color: YoCalendarConfig.instance.dayBackgroundNormalColor), for: .highlighted)
                btn.setBackgroundImage(self.imageWithColor(color: YoCalendarConfig.instance.dayBackgroundSelectedColor), for: .selected)
//                btn.addTarget(self, action: #selector(dateBtnOnClick(_:)), for: .touchUpInside)
                daysContainer.addSubview(btn)
            }
    }
    //根据颜色返回图片
    fileprivate func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //根据选中日期，获取相应NSDate
    fileprivate func getSelectDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = selectedYear
        dateComponents.month = selectedMonth
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(from: dateComponents)!
    }
    
    //获取目标月份的天数
    fileprivate func numberOfDaysInMonth() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: self.getSelectDate())?.count ?? 0
    }
    
    //获取目标月份第一天星期几
    fileprivate func firstDayOfWeekInMonth() -> Int {
        //获取选中日期月份第一天星期几，因为默认日历顺序为“日一二三四五六”，所以这里返回的1对应星期日，2对应星期一，依次类推
        return Calendar.current.ordinality(of: .day, in: .weekOfYear, for: self.getSelectDate())!
    }
}



