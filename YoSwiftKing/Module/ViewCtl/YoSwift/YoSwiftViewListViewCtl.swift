//
//  YoSwiftViewListViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/3/3.
//
import UIKit
import SnapKit
//MARK:
class YoSwiftViewListViewCtl: YoBaseUIViewController {
    //列表数据
     var listData = [Any]()
    //声明列表
     lazy var tableView: UITableView = {
        let tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(YoSwiftViewListCell.self, forCellReuseIdentifier: NSStringFromClass(YoSwiftViewListCell.self))
         tableView.separatorStyle = .none
         return tableView
    }()
     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
         navigationController?.navigationBar.isHidden = true
        //测试 数据
        var model = YoSwiftViewListModel()
        model.title = "RunTime原理"
        model.text = "2206 Kingnights Bridge2"

         
         var model2 = YoSwiftViewListModel()
         model2.title = "RunLoop解析"
         model2.text = "2206 Kingnights Bridge"
         
        listData = [model,model2]
        layoutViewCtlSubviews()
    }
}
//MARK: table DataSource
extension YoSwiftViewListViewCtl: UITableViewDataSource {
    //返回行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return listData.count
   }
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let model = listData[indexPath.section] as! YoSwiftViewListModel
       let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(YoSwiftViewListCell.self))! as! YoSwiftViewListCell
       cell.titleLab.text = model.title as String?
       cell.textLab.text = model.text
       cell.indexPath = indexPath as NSIndexPath
       return cell
   }
}
//MARK: table Delegate
extension YoSwiftViewListViewCtl: UITableViewDelegate {
    //行高
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 + 1
    }
    //xuan ze
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewCtl =  TradeDetailViewCtl()
        viewCtl.hidesBottomBarWhenPushed = true
       // self.currentViewController()?.navigationController?.pushViewController(viewCtl, animated: false)
       // self.navigationController?.pushViewController(viewCtl, animated: false)
    }
    //区头 高
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //区头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let headerView = YoSwiftViewListHeaderView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        headerView.titleLab.text = "RunTime"
        return headerView
    }
}
//MARK: 标签代理回调
extension YoSwiftViewListViewCtl:  YoTagsLabViewProtocol {
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
extension YoSwiftViewListViewCtl {

}
//MARK: 页面布局
extension YoSwiftViewListViewCtl {
    
}
//MARK: 页面布局
extension YoSwiftViewListViewCtl {
    //MARK: 布局
     private  func layoutViewCtlSubviews() {
        //表
           tableView.snp.makeConstraints { make in
               make.top.left.bottom.right.equalTo(view)
           }
     }
}
