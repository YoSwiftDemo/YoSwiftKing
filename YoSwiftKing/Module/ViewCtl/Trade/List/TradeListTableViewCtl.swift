//
//  TradeListTableViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/21.
//

import UIKit
import SnapKit
//MARK:
class TradeListTableViewCtl: UIViewController, UITableViewDataSource {
    //UI选择类型按钮
    private lazy var selectTypeBtn: UIButton = {
        let btn = UIButton()
        view.addSubview(btn)
        btn.setTitle("选择类型", for: .normal)
        btn.titleLabel?.font = TradeConfig.instance.selectButtonFont
        btn.setTitleColor(TradeConfig.instance.selectBtnSelectedColor, for: .selected)
        btn.setTitleColor(TradeConfig.instance.selectBtnNormalColor, for: .normal)
        btn.addTarget(self, action: #selector(selectBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    //UI 选择 时间
    private lazy var selectDateBtn: UIButton = {
        let btn = UIButton()
        view.addSubview(btn)
        btn.setTitle("选择时间", for: .normal)
        btn.titleLabel?.font = TradeConfig.instance.selectButtonFont
        btn.setTitleColor(TradeConfig.instance.selectBtnSelectedColor, for: .selected)
        btn.setTitleColor(TradeConfig.instance.selectBtnNormalColor, for: .normal)
        btn.addTarget(self, action: #selector(selectBtnAction(_:)), for: .touchUpInside)
        return btn
    }()
    //默认日期
    var defaultDate = Date()
    //弹窗日历
    private lazy var  calendarView: YoCalendar = {
        let calendar = YoCalendar()
         //        calendar.isHidden = false
        calendar.animationType = .center
        return calendar
    }()
    
    private lazy var  testCalendarView: YoCalendarView = {
        let calendar = YoCalendarView()
        return calendar
    }()
    
    
    //UI 标签view
    var dataSource = ["全部","物业费","地产税","水费","电费","网费","罚款","月供"]
    var modelDataSource: [YoTagsPropertyModel] = [YoTagsPropertyModel]()
    lazy var tagsView : YoTagsLabView = {
        let tagsView = YoTagsLabView()
        view.addSubview(tagsView)
        tagsView.backgroundColor =  TradeConfig.instance.tagsViewBgColor
        tagsView.tagsViewDelegate = self
        
        let config =   YoTagsLabViewConfig.instance
        config.tagsViewContentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        config.tagsViewMinHeight = 0
        config.scrollDirection = .vertical
        config.tagsViewMaxHeight = view.frame.size.height
        config.minimumLineSpacing = 10;
        config.minimumInteritemSpacing = 10;
        return tagsView
    }()

    //列表数据
     var listData = [Any]()
    //声明列表
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TradeListTableCell.self, forCellReuseIdentifier: NSStringFromClass(TradeListTableCell.self))
        return tableView
    }()
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         navigationController?.navigationBar.isHidden = true
        //测试 数据
        var model = TradeListModel()
        model.title = "生活费"
        model.text = "2206 Kingnights Bridge"
        model.date = "2020.10.12"
        model.expenses = "3000P"
         
         var model2 = TradeListModel()
         model2.title = "书本费"
         model2.text = "2206 Kingnights Bridge"
         model2.date = "2020.10.12"
         model2.expenses = "788900P"
         
        listData = [model,model2]
        layoutViewCtlSubviews()
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return listData.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = listData[indexPath.section] as! TradeListModel
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TradeListTableCell.self))! as! TradeListTableCell
        cell.titleLab.text = model.title as String?
        cell.textLab.text = model.text
        cell.dateLab.text = model.date
        cell.expensesLab.text = model.expenses
        cell.indexPath = indexPath as NSIndexPath
        return cell
    }
    //MARK: 布局
    func layoutViewCtlSubviews() {
        //按钮选择  类型
        selectTypeBtn.snp.makeConstraints { make in
            make.left.equalTo(view).offset(60)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(60)
            make.top.equalTo(self.view).offset(20)
        }
        //按钮选择  时间
        selectDateBtn.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-60)
            make.height.equalTo(30)
            make.width.greaterThanOrEqualTo(60)
            make.top.equalTo(self.view).offset(20)
        }
        //标签View
        tagsView.snp.makeConstraints { make in
            make.top.equalTo(selectTypeBtn.snp.bottom).offset(10)
            make.left.right.equalToSuperview().offset(0)
            //不设置高度
        }
        //表
           tableView.snp.makeConstraints { make in
               make.top.equalTo(tagsView.snp.bottom)
               make.left.bottom.right.equalTo(view)
           }
     }
}
extension TradeListTableViewCtl: UITableViewDelegate {
    //行高
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 15+20+10+20+15+1
    }
    //xuan ze
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let viewCtl =  TradeDetailViewCtl()
        viewCtl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewCtl, animated: true)
    }
}
//MARK: 标签代理回调
extension TradeListTableViewCtl:  YoTagsLabViewProtocol {
    /** 设置每个tag的属性，包含UI ，对应的属性*/
    func tagsViewUpdatePropertyModel(_ tagsView: YoTagsLabView, item: YoTagsPropertyModel, index: NSInteger) {

        if (index  == 15) {item.minHeight = 40}
        item.imageAlignmentMode = .left
            item.normalImage = UIImage(named: "delete")
            item.imageSize = CGSize(width: 10, height: 10)

    }
    
    func tagsViewItemTapAction(_ tagsView: YoTagsLabView, item: YoTagsPropertyModel, index: NSInteger) {
//        dataSource.remove(at: index)
//        tagsView.dataSource.remove(at: index)
//        tagsView.reloadData()
    }
    
    func tagsViewTapAction(_ tagsView: YoTagsLabView) {
        tagsView.isSelect = !tagsView.isSelect
        tagsView.reloadData()
    }
}

//MARK: 选择按钮事件
extension TradeListTableViewCtl {
    @objc  private func selectBtnAction(_ sender: UIButton) {
        //选择类型
        if sender == selectTypeBtn {
            dataSource = ["全部","物业费","地产税","水费","电费","网费","罚款","月供"]
            for index in 0...dataSource.count-1 {
                let item = dataSource[index]
                let model = YoTagsPropertyModel()
                model.contentView.backgroundColor = .white
                model.contentView.layer.cornerRadius = 20
                model.imageAlignmentMode = .right
                model.titleLabel.text = item
                model.titleLabel.textColor = .black
                modelDataSource.append(model)
            }
        }
        //选择时间
        if sender == selectDateBtn {
            calendarView.callback = { [unowned self](value) in
                if let date = value as? String {
                    self.defaultDate = dateFromFormat(date: date)
                }
            }
            calendarView.show()
        }
    
        tagsView.dataSource = dataSource
//        tagsView.tagsViewMaxHeight  = self.view.frame.size.height
        tagsView.reloadData()
    }
}

