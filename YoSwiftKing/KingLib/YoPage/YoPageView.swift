//
//  YoPageView.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/22.
//

import UIKit
//import RxSwift
//MARK: - 协议
 protocol YoPageViewDelegate: NSObjectProtocol {
    //N个界面
    func numberOfPageView(in pageView: YoPageView) -> Array<UIViewController>
    
    // 滚动事件
    /*
    ///   - pageView: 对象
    ///   - previousIndex: 上一个页面位置
    ///   - currentIndex: 当前页面位置
    ///   - progress: 滚动的百分比
     */
    func pageView(_ pageView: YoPageView, from fromIndex: Int, to toIndex: Int, progress: CGFloat)
    
    /// 结束滚动事件
    /// - Parameters:
    ///   - pageView: 对象
    ///   - index: 结束时页面位置
    func pageView(_ pageView: YoPageView, didEndScrollAt index: Int)
}
//MARK: - View
class YoPageView: UIView {
    /// 代理
    public weak var delegate: YoPageViewDelegate!
    /// 当前位置Index
    public var currentIndex: Int = 0
    /// 是否开始拖拽
    private var beginDragging: Bool = false
    /// 记录拖拽开始时的偏移量
    private var beginDraggingOffsetX: CGFloat = 0
    /// 页面数据
    private lazy var pageArray: [UIViewController] = {
            return delegate.numberOfPageView(in: self)
    }()
    //表
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = frame.size
        layout.invalidateLayout()
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
//        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.className)
//        if #available(iOS 11.0, *) { view.contentInsetAdjustmentBehavior = .never }
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - YoPageView 增加一些 公有方法  方便设置一些参数
extension YoPageView {
   /**滚动到指定页面 默认无动画
      - index: 页面下标
      - scrollPosition: 滚动方向
      - animation: 是否动画
    */
    public func scrollToPage(at index: Int, at scrollPosition: UICollectionView.ScrollPosition = .left, animation: Bool = false) {
        currentIndex = index
        beginDragging = false
        //https://www.jianshu.com/p/d5aba8dfaf54
        //https://www.jianshu.com/p/440df1d19ffb
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0),at: scrollPosition,animated: animation)
        collectionView.isPagingEnabled = true
       // collectionView.setContentOffset(CGPoint(x: CGFloat(currentIndex) * self.frame.size.width, y: 0), animated: animation)
    }
    /*
     数据变化后 执行刷新
     */
    public func reloadRefresh(){
        if   self.currentIndex < self.pageArray.count {
        }else{
            self.currentIndex = 0
        }
        collectionView.reloadData()
        collectionView.contentOffset = CGPoint(x: CGFloat(currentIndex) * self.frame.size.width, y: 0)
    }
}


//MARK: - UICollectionViewDataSource 数据源
extension YoPageView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.className, for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        if pageArray.count > 0 {
            let viewCtl = pageArray[indexPath.item]
            viewCtl.view.frame = cell.contentView.bounds
            cell.contentView.addSubview(viewCtl.view)
        }
        return cell
    }
}
extension YoPageView: UICollectionViewDelegate{
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //选择那个  目前没 点击需求
    }
}
//MARK: - UIScrollViewDelegate 代理
extension YoPageView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        progress(in: self, scrollView: scrollView)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginDraggingOffsetX = scrollView.contentOffset.x
        beginDragging = true
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            index(in: self, scrollView: scrollView)
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        index(in: self, scrollView: scrollView)
    }
}

//MARK: - 滚动事件
private extension YoPageView {
    
    /// 页面下标
    func index(in pageView: YoPageView, scrollView: UIScrollView) {
        currentIndex = Int((scrollView.contentOffset.x / scrollView.frame.size.width))
        delegate.pageView(self, didEndScrollAt: currentIndex)
    }
    
    /// 滚动的百分比
    func progress(in pageView: YoPageView, scrollView: UIScrollView) {
        guard beginDragging == true else {
            return
        }
        var progress: CGFloat = 0, currentIndex: Int = 0, previousIndex: Int = 0;
        
        let offsetX = scrollView.contentOffset.x
        let remainder = offsetX.truncatingRemainder(dividingBy: scrollView.frame.size.width)
        guard (remainder / scrollView.frame.size.width) > 0,
              !(remainder / scrollView.frame.size.width).isNaN
        else { return }
        
        progress = remainder / scrollView.frame.size.width
        let index = Int(offsetX / scrollView.frame.size.width)
        if offsetX > beginDraggingOffsetX {
            previousIndex = index
            currentIndex = index + 1
            guard currentIndex <= pageArray.count - 1 else { return }
        }else {
            previousIndex = index + 1
            currentIndex = index
            progress = 1 - progress
            guard currentIndex >= 0  else { return }
        }
        if progress > 0.9 { progress = 1 }
        
        delegate.pageView(self, from: previousIndex, to: currentIndex, progress: progress)
    }
}
