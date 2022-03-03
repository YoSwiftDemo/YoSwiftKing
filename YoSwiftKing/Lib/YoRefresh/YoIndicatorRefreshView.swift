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
        layer.strokeColor = YoRefreshConfig.instance.arrowStrokeColor.cgColor
        //UIColor.black.withAlphaComponent(0.5).cgColor
        layer.lineWidth =  YoRefreshConfig.instance.arrowLineWidth
        layer.lineCap = .round
        return layer
    }()
    //MARK: 菊花
    let indicatorView = UIActivityIndicatorView(style: YoRefreshConfig.instance.activityIndicatorStyle)
    //MARK: private 纪录是否刷新状态
    private let isHeader: Bool
    //MARK: init
    init(isHeader: Bool, height: CGFloat, action: @escaping ()-> Void) {
        self.isHeader = isHeader
        super.init(refreshStyle: isHeader ? .header : .footer, height: height, action: action)
        layer.addSublayer(arrowLayer)
        addSubview(indicatorView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:重写布局
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
