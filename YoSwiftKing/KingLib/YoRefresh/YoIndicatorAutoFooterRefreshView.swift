//
//  YoIndicatorAutoFooterRefreshView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/15.
//

import UIKit
class YoIndicatorAutoFooterRefreshView: YoRefreshView {
    let indictor = UIActivityIndicatorView(style: .gray)
    init(height: CGFloat, action: @escaping () -> Void) {
        super.init(refreshStyle: .autoFooter, height: height, action: action)
        addSubview(indictor)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        indictor.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    override func didUpdateState(_ isRefreshing: Bool) {
        isRefreshing ? indictor.startAnimating() : indictor.stopAnimating()
    }
    override func didUpdateProgress(_ progress: CGFloat) {
        
    }
}
