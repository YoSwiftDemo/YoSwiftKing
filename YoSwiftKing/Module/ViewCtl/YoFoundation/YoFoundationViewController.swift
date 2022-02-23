//
//  YoFoundationViewController.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//


import UIKit
import SnapKit
import LJTagsView
class YoFoundationViewController: YoBaseUIViewController {
   
    var dataSource = ["Listing ID","Tower","Sole Agency Type","Have Keys","New Development","Tags","Big landlord","Street Address","Currency","Price per unit","Price per unit(Gross)","Price per unit(Saleable)","Size(Gross)","Size(Saleable)","Status","Register","Landlord","SSD","Agent","Floor Alias","Unit Alias","Unit Balcony","Tower Type","Building Age","Segment","Car Park","Is Coop","SPV","Pet Friendly","View Type","Property Type","123"]
    var modelDataSource: [TagsPropertyModel] = [TagsPropertyModel]()
    lazy var tagsView0 : LJTagsView = {
        let tagsView0 = LJTagsView()
        view.addSubview(tagsView0)
        tagsView0.backgroundColor = .brown
        tagsView0.tagsViewDelegate = self
        tagsView0.tagsViewContentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsView0.tagsViewMinHeight = 40
        tagsView0.scrollDirection = .vertical
        tagsView0.tagsViewMaxHeight = 300
        tagsView0.minimumLineSpacing = 10;
        tagsView0.minimumInteritemSpacing = 10;
        return tagsView0
    }()
    
    //默认日期
    var defaultDate = Date()
    //弹窗日历
    private lazy var  calendarView: YoCalendar = {
        let calendar = YoCalendar()
        calendar.isHidden = false
        calendar.animationType = .center
        return calendar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn: UIButton = UIButton.init(frame: CGRect(x: 100, y: 100, width: 300, height: 200))
        view.addSubview(btn)
        
        
        return
        
        tagsView0.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalToSuperview().offset(0)
        }
        for index in 0...30 {
            
            let item = dataSource[Int(arc4random()) % dataSource.count]
            let model = TagsPropertyModel()
            model.imageAlignmentMode = .right
            model.titleLabel.text = item
            if index == 0 || index == 20 { model.titleLabel.font = .systemFont(ofSize: 20)  }
            if index == 30 { model.titleLabel.font = .systemFont(ofSize: 40)  }
            modelDataSource.append(model)
        }
        tagsView0.dataSource = dataSource
        tagsView0.tagsViewMaxHeight  = self.view.frame.size.height
        tagsView0.reloadData()
    }
}
extension YoFoundationViewController:  LJTagsViewProtocol {
    
    /** 设置每个tag的属性，包含UI ，对应的属性*/
    func tagsViewUpdatePropertyModel(_ tagsView: LJTagsView, item: TagsPropertyModel, index: NSInteger) {

        if (index  == 15) {item.minHeight = 40}
        item.imageAlignmentMode = .left


            item.normalImage = UIImage(named: "delete")
            item.imageSize = CGSize(width: 10, height: 10)

    }
    
    func tagsViewItemTapAction(_ tagsView: LJTagsView, item: TagsPropertyModel, index: NSInteger) {

            dataSource.remove(at: index)
            tagsView.dataSource.remove(at: index)
   
        tagsView.reloadData()
    }
    
    func tagsViewTapAction(_ tagsView: LJTagsView) {
        tagsView.isSelect = !tagsView.isSelect
        tagsView.reloadData()
    }
}
