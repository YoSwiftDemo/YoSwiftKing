//
//  YoTextAutoFooterRefreshView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import UIKit
class YoTextAutoFooterRefreshView: YoIndicatorAutoFooterRefreshView {
    private let loadingText: String
    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }()
    //
    init(loadingText: String, height: CGFloat, action: @escaping () -> Void) {
        self.loadingText = loadingText
        super.init(height: height, action: action)
        addSubview(label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.minX, y: bounds.midX)
        indictor.center = center.move(x: -label.bounds.midX - 4)
        label.center  = center.move(x: indictor.bounds.midX - 4)
    }
    override func didUpdateState(_ isRefreshing: Bool) {
        super.didUpdateState(isRefreshing)
        label.text = isRefreshing ? loadingText : ""
        label.sizeToFit()
    }
}
