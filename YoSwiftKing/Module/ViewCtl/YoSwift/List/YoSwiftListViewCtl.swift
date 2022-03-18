//
//  ListBaseViewController.swift
//  JXSegmentedView
//
//  Created by jiaxin on 2018/12/26.
//  Copyright © 2018 jiaxin. All rights reserved.
//

import UIKit
import SnapKit
import JXSegmentedView
//MARK:
class YoSwiftListViewCtl: YoBaseUIViewController {
    //区分列表标识
    //列表数据
     var listData = [YoSwiftViewListSectionModel]()
    //声明列表
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(YoSwiftListCell.self, forCellReuseIdentifier: NSStringFromClass(YoSwiftListCell.self))
         tableView.separatorStyle = .none
         return tableView
    }()
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         navigationController?.navigationBar.isHidden = true
        //测试 数据
        
//        let model = YoSwiftViewListModel()
//        model.title = "RunTime原理2222"
//        model.text = "2206 Kingnights Bridge2"
//        let sctionModel = YoSwiftViewListSectionModel()
//         sctionModel.title = "区头数据"
//         sctionModel.rows = [model]
//
//
//        listData = [sctionModel]
        layoutViewCtlSubviews()
        refreshTypeAction()
    }
    //启动刷新
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.beginRefreshing()
    }
}
//MARK: table DataSource
extension YoSwiftListViewCtl: UITableViewDataSource {
    //返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          let sectionModel = listData[section]
        if (sectionModel.rows != nil) {
            return sectionModel.rows!.count
        }
        return 0
   }
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //先去区数据
       let sectionModel = listData[indexPath.section]
        let model = sectionModel.rows![indexPath.row]
       let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(YoSwiftListCell.self))! as! YoSwiftListCell
       cell.titleLab.text = model.title as String?
       cell.textLab.text = model.text
       cell.indexPath = indexPath as NSIndexPath
       return cell
   }
}
//MARK: table Delegate
extension YoSwiftListViewCtl: UITableViewDelegate {
    //行高
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 + 1
    }
    //xuan ze
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtl = YoSwiftListDetailViewCtl()
        //YoPageDetailMainViewCtl()
        //YoMarkDownWebViewCtl()
        viewCtl.hidesBottomBarWhenPushed = true
//        viewCtl.markdownName =  "SwiftProtocol"
       self.currentViewController()?.navigationController?.pushViewController(viewCtl, animated: true)
      // self.navigationController?.pushViewController(viewCtl, animated: false)
    }
    //区头 高
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //区头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = listData[section]
       let headerView =  YoSwiftListHeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        headerView.titleLab.text = sectionModel.title
        return headerView
    }
}
//MARK: 标签代理回调
extension YoSwiftListViewCtl:  YoTagsLabViewProtocol {
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
extension YoSwiftListViewCtl {

}
//MARK: 页面布局
extension YoSwiftListViewCtl {
    
}
//MARK: 页面布局
extension YoSwiftListViewCtl {
    //MARK: 布局
     private  func layoutViewCtlSubviews() {
        //表
           tableView.snp.makeConstraints { make in
               make.top.left.bottom.right.equalTo(view)
           }
     }
}
//MARK: JXSegmentedView必须实现
extension YoSwiftListViewCtl: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}

extension YoSwiftListViewCtl {
    private func  refreshTypeAction() {
      //头部 指示器
    self.tableView.createHeaderIndicator(height: 60) { [weak self] in
        self?.action()
        }
    self.tableView.createFooterIndicator { [weak self] in
        self?.action()
    }
    }
    private func action() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5 ) {
            self.tableView.endRefreshing()
        }
    }
}
