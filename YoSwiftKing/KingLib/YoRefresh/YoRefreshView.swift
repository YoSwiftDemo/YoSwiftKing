//
//  YoRefreshView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import UIKit
open class YoRefreshView: UIView {
    private let refreshStyle: RefreshStyle
    public let height: CGFloat
    private let action: () -> Void
    // 默认 是默认的@noescape，这意味着该闭包不能超出方法的作用域，方法return后闭包就销毁了，所以它是安全的
    //方法加了@escaping，以为着“逃脱”，闭包的生命周期可以逃脱方法的作用域，在方法return后不会销毁，这意味着它的调用时机是不确定的，是异步的。一般用于异步网络请求
    public init(refreshStyle: RefreshStyle, height: CGFloat, action:  @escaping () -> Void) {
        self.refreshStyle = refreshStyle
        self.height = height
        self.action = action
        super.init(frame: .zero)
        self.autoresizingMask = [.flexibleWidth]
        
    }
    //  //fatalError 在父类中强制抛出错误，以保证使用，必须在自己的子类中实现相关方法
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //属性-是否在刷新
    private var isRefreshing = false {
        didSet {
            didUpdateState(isRefreshing)
        }
    }
    //已经更新刷新状态
    open func didUpdateState(_ isRefreshing: Bool) {
        fatalError("didUpdateState(_:) has not been implemented")
    }
    //刷新进度
    private var progress: CGFloat = 0 {
        didSet {
            didUpdateProgress(progress)
        }
    }
    //已经更新进度
    open func didUpdateProgress(_ progress: CGFloat) {
        fatalError("didUpdateProgress(_:) has not been implemented")
    }
    private var scrollView: UIScrollView? {
        return superview as? UIScrollView
    }
    
    private var offsetToken: NSKeyValueObservation?
    private var stateToken: NSKeyValueObservation?
    private var sizeToken: NSKeyValueObservation?
    
  
}
//MARK: left-cycle
/*
 将要加载时候
 */
extension YoRefreshView {
    open override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            clearObserver()
        } else {
            guard let scrollView = scrollView else {
                return
            }
            setupObserver(scrollView)
        }
    }
}
//MARK: 刷新方法封装
extension YoRefreshView {
    //开始刷新
    func beginRefreshing() {
        //判断是否可以刷新 存在刷新不刷新
        guard let scrollView = scrollView, !isRefreshing else {
            return
        }
        progress = 1
        isRefreshing = true //标识 刷新中
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                switch self.refreshStyle {
                case .header:
                    scrollView.contentOffset.y = -self.height - scrollView.contentInsetTop
                    scrollView.contentInset.top += self.height
                case .footer:
                    scrollView.contentInset.bottom += self.height
                case .autoFooter:
                    scrollView.contentOffset.y = self.height + scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInsetBottom
                    scrollView.contentInset.bottom += self.height
                }
            }, completion: { _ in
                self.action()
            })
        }
    }
    //结束刷新
    func endRefreshing(completion: (() -> Void)? = nil) {
        guard let scrollView = scrollView else {
            return
        }
        guard isRefreshing else {
            completion?()
            return
        }

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                switch self.refreshStyle {
                case .header:
                    scrollView.contentInset.top -= self.height
                case .footer, .autoFooter:
                    scrollView.contentInset.bottom -= self.height
                }
            }, completion: { _ in
                self.isRefreshing = false
                self.progress = 0
                completion?()
            })
        }
    }
}
//MARK: 私有方法
extension YoRefreshView {
    //清楚监听
    private func clearObserver() {
        offsetToken?.invalidate()
        stateToken?.invalidate()
        sizeToken?.invalidate()
    }
    //添加监听
    private func setupObserver(_ scrollView: UIScrollView) {
        offsetToken = scrollView.observe(\.contentOffset) { [weak self] scrollView, _ in
            self?.scrollViewDidScroll(scrollView)
        }
        stateToken = scrollView.observe(\.panGestureRecognizer.state) { [weak self] scrollView, _ in
            guard scrollView.panGestureRecognizer.state == .ended else { return }
            self?.scrollViewDidEndDragging(scrollView)
        }
        if refreshStyle == .header {
            frame = CGRect(x: 0, y: -height, width: scrollView.bounds.width, height: height)
        } else {
            sizeToken = scrollView.observe(\.contentSize) { [weak self] scrollView, _ in
                self?.frame = CGRect(x: 0, y: scrollView.contentSize.height, width: scrollView.bounds.width, height: self?.height ?? 0)
                self?.isHidden = scrollView.contentSize.height <= scrollView.bounds.height
            }
        }
    }
    // 已经滑动处理
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isRefreshing {
            return
        }
        switch refreshStyle {
        case .header:
            progress = min(1, max(0, -(scrollView.contentOffset.y + scrollView.contentInsetTop) / height))
        case .footer:
            if scrollView.contentSize.height <= scrollView.bounds.height {
                return
            }
            progress = min(1, max(0, (scrollView.contentOffset.y + scrollView.bounds.height - scrollView.contentSize.height - scrollView.contentInsetBottom) / height))
        case .autoFooter:
            if scrollView.contentSize.height <= scrollView.bounds.height {
                return
            }
            if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInsetBottom{
                //开始刷新
            }
        }
    }
    // 结束滑动处理
    private func scrollViewDidEndDragging(_ scrollView: UIScrollView) {
        if isRefreshing || progress < 1 || refreshStyle == .autoFooter {
            return
        }
        beginRefreshing()
    }
}

 
//MARK: UIScrollView 扩展
private extension UIScrollView {
    //顶部偏移
    var contentInsetTop: CGFloat {
        if #available(iOS 11.0, *) {
            return contentInset.top + adjustedContentInset.top
        }else{
            return contentInset.top
        }
    }
    //底部偏移
    var contentInsetBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return contentInset.bottom + adjustedContentInset.bottom
        }else{
            return contentInset.bottom
        }
    }
}
