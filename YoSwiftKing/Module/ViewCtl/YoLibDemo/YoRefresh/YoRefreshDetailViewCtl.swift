//
//  YoRefreshDetailViewCtl.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import UIKit
import SnapKit
import WeakMapTable
class YoRefreshDetailViewCtl: YoBaseUIViewController {
    //刷新类型
    var refresh: YoRefreshType = .indicatorHeader
    //滚动scrollView
    private lazy var  scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalTo(self.view)
        }
        // 可以滚动的区域
        scrollView.contentSize = CGSize(width: self.view.frame.size.width,
                                        height: self.view.frame.size.height*2)
        return scrollView
    }()
}

extension YoRefreshDetailViewCtl {
    //启动刷新
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                scrollView.beginRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .green
        scrollView.backgroundColor = .red
        layoutViewCtl()
        refreshTypeAction()
    }
}
extension YoRefreshDetailViewCtl {
    //MARK: 布局
    private func layoutViewCtl() {
    
    }
}
extension YoRefreshDetailViewCtl {
    private func action() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            self.scrollView.endRefreshing()
        }
    }
    private func refreshTypeAction(){
        switch refresh {
        case .indicatorHeader:
            //头部 指示器
            scrollView.createHeaderIndicator(height: 60) { [weak self] in
                self?.action()
            }
            //头部 指示器 + 文字
        case .textHeader:
            scrollView.createHeaderIndicatorText { [weak self] in
                self?.action()
            }
        //头部  小gif
        case .smallGIFHeader:
            //判断gif数据
            guard let url = Bundle.main.url(forResource: "demo-small", withExtension: "gif"),
                  let data = try? Data(contentsOf: url) else {
                      return
                  }
            scrollView.createHeaderGif(data: data) { [weak self] in
                self?.action()
            }
            //头部  大gif
        case .bigGIFHeader:
            //判断gif数据
            guard let url = Bundle.main.url(forResource: "demo-small", withExtension: "gif"),
                  let data = try? Data(contentsOf: url) else {
                      return
                  }
            //头部大图刷新
            scrollView.createHeaderGif(data: data, isLarger: true, height: 120) { [weak self] in
                self?.action()
            }
         //头部 gif+ 文字
        case .gifTextHeader:
            //判断gif数据
            guard let url = Bundle.main.url(forResource: "demo-small", withExtension: "gif"),
                  let data = try? Data(contentsOf: url) else {
                      return
                  }
            //头部刷新 gif + 文字
            scrollView.createHeaderGifText(data: data) { [weak self] in
                self?.action()
            }
       //头部 自定义
        case .superCatHeader:
            let header = YoSuperCatHeaderRefreshView(refreshStyle: .header, height: 120) { [weak self] in
                self?.action()
            }
            scrollView.createHeaderCustom(refreshView: header)
         //尾部 指示器
        case .indicatorFooter:
            scrollView.createFooterIndicator { [weak self] in
                self?.action()
            }
        //尾部 指示器 + 文字
        case .textFooter:
            scrollView.createFooterIndicatorText {[weak self] in
                self?.action()
            }
            //尾部
        case .indicatorAutoFooter:
            scrollView.createFootertIndicatorAuto { [weak self] in
                    self?.action()
            }
            //尾部
        case .textAutoFooter:
            scrollView.createFooterTextAuto {[weak self] in
                self?.action()
            }
        }
    }
}

