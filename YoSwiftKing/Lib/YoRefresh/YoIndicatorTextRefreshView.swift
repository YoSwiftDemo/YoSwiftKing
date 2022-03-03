//
//  File.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import UIKit
class YoIndicatorTextRefreshView: YoIndicatorRefreshView {
    private let refreshText: YoRefreshText
    //文本
    private lazy var textLab: UILabel = {
        let lab = UILabel()
        lab.font = YoRefreshConfig.instance.titleTextFont
        lab.textColor = YoRefreshConfig.instance.titleTextTextColor
        addSubview(lab)
        return lab
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //记录 是否头部 还是尾部
    private let isHeader: Bool
    //初始化
    init(isHeader: Bool, refreshText: YoRefreshText, height: CGFloat, action: @escaping () -> Void) {
        self.isHeader  = isHeader
        self.refreshText = refreshText
        super.init(isHeader: isHeader, height: height, action: action)
    }
    //重写 布局
    override func layoutSubviews() {
         super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        arrowLayer.position = center.move(x: -textLab.bounds.midX - 4)
        indicatorView.center = center.move(x: -textLab.bounds.midX - 4)
        textLab.center = center.move(x: indicatorView.bounds.midX + 4)
    }
    //重写 状态
    override func didUpdateState(_ isRefreshing: Bool) {
        super.didUpdateState(isRefreshing)
        textLab.text  = isRefreshing ? refreshText.loadingText : refreshText.pullingText
        textLab.sizeToFit()
    }
    //重写 进度
    override func didUpdateProgress(_ progress: CGFloat) {
        super.didUpdateProgress(progress)
        textLab.text = progress == 1 ? refreshText.releaseText : refreshText.pullingText
        textLab.sizeToFit()
    }
}
extension CGPoint {
    func move(x: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: y)
    }
}
