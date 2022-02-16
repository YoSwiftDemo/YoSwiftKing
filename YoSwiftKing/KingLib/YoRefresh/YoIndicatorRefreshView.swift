//
//  YoIndicatorView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import UIKit
class YoIndicatorRefreshView: YoRefreshView {
    //自定义 箭头
    lazy var arrowLayer: CAShapeLayer = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: 0, y: -8))
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: 5.66, y: 2.34))
        path.move(to: CGPoint(x: 0, y: 8))
        path.addLine(to: CGPoint(x: -5.66, y: 2.34))

        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.withAlphaComponent(0.8).cgColor
        layer.lineWidth = 2
        layer.lineCap = .round
        
        //测试
        layer.strokeColor =  UIColor.green.cgColor
        return layer
    }()
    //
    let indicatorView = UIActivityIndicatorView(style: .gray)
    private let isHeader: Bool
    init(isHeader: Bool, height: CGFloat, action: @escaping ()-> Void) {
        self.isHeader = isHeader
        super.init(refreshStyle: isHeader ? .header : .footer, height: height, action: action)
        layer.addSublayer(arrowLayer)
        addSubview(indicatorView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //重写布局
    override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        arrowLayer.position = center
        indicatorView.center = center
    }
    //重写父层 状态变化方法
    override func didUpdateState(_ isRefreshing: Bool) {
        arrowLayer.isHidden = isRefreshing
        if isRefreshing {
            indicatorView.startAnimating()
        }else{
            indicatorView.stopAnimating()
        }
    }
    //重写父层 进度变化方法
    override func didUpdateProgress(_ progress: CGFloat) {
        let rotation =  CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)
        if isHeader {
            arrowLayer.transform = progress == 1 ? rotation : CATransform3DIdentity
        } else {
            arrowLayer.transform = progress == 1 ? CATransform3DIdentity : rotation
        }
    }
}
