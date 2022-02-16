//
//  YoGifTextHeaderRefreshView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import Foundation
import UIKit

class YoGifTextHeaderRefreshView: YoGifHeaderRefreshView {
    //刷新文字
    private let refreshText: YoRefreshText
    //
    private lazy var  label: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()
    //
    init(data: Data, refreshText: YoRefreshText, height: CGFloat, action: @escaping() -> Void) {
        self.refreshText = refreshText
        super.init(data: data, isLarger: false, height: height, action: action)
        addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        imageView.center = center.move(x: -label.bounds.midX - 4)
        label.center = center.move(x: imageView.bounds.midX + 4)
    }
    //
    override func didUpdateState(_ isRefreshing: Bool) {
        super.didUpdateState(isRefreshing)
        label.text = isRefreshing ? refreshText.loadingText : refreshText.pullingText
        label.sizeToFit()
    }
    //
    override func didUpdateProgress(_ progress: CGFloat) {
        super.didUpdateProgress(progress)
        label.text = progress == 1 ? refreshText.releaseText : refreshText.pullingText
        label.sizeToFit()
    }
}
