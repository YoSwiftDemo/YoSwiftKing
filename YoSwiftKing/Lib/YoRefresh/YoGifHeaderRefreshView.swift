//
//  YoGifRefreshView.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/11.
//

import UIKit
import ImageIO
import MobileCoreServices
import Kingfisher
class YoGifHeaderRefreshView: YoRefreshView {
    private let data: Data
    private let isLarger: Bool  //是否是大图
   let imageView = YoGifAnimatedImageView()
    init(data: Data, isLarger: Bool, height: CGFloat,action: @escaping ()-> Void) {
        self.data = data
        self.isLarger = isLarger
        super.init(refreshStyle: .header, height: height, action: action)
        guard let animateImage = YoGifAnimatedImage(data: data) else {
            print("Error: data is not from an animated image")
            return
        }
        imageView.animatedImage = animateImage
        addSubview(imageView)
        if isLarger {
            imageView.bounds.size = CGSize(width: UIScreen.main.bounds.width, height: height)
            imageView.contentMode = .scaleAspectFill
        } else {
            let ratio = animateImage.size.width / animateImage.size.height
            imageView.bounds.size = CGSize(width: ratio * height * 0.7, height: height * 0.67)
            imageView.contentMode = .scaleAspectFit
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    override func didUpdateState(_ isRefreshing: Bool) {
        isRefreshing ? imageView.startAnimating() : imageView.stopAnimating()
    }
    override func didUpdateProgress(_ progress: CGFloat) {
        guard let count = imageView.animatedImage?.frameCount else {
            return
        }
        //
        if progress == 1 {
            imageView.startAnimating()
        } else {
            imageView.stopAnimating()
            imageView.index = Int(CGFloat(count - 1) * progress)
        }
    }
}
//协议
protocol YoAnimateImage: AnyObject {
    var size: CGSize {
        get
    }
    var frameCount: Int {
        get
    }
    func frameDurationForImage(at index: Int) -> TimeInterval
    subscript(index: Int) -> UIImage{
        get
    }
}
class YoGifAnimatedImage: YoAnimateImage {
    typealias  ImageInfo = (image: UIImage, duration: TimeInterval)
    private var images: [ImageInfo] = []
    var size: CGSize {
        return images.first?.image.size ?? .zero
    }
    //
    var frameCount: Int {
        return images.count
    }
    //
    init?(data: Data) {
        guard
            let source = CGImageSourceCreateWithData(data as CFData, nil),
            let type = CGImageSourceGetType(source)
            else { return nil }

        let isTypeGIF = UTTypeConformsTo(type, kUTTypeGIF)
        let count = CGImageSourceGetCount(source)
        if !isTypeGIF || count <= 1 { return nil }

        for index in 0 ..< count {
            guard
                let image = CGImageSourceCreateImageAtIndex(source, index, nil),
                let info = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [String: Any],
                let gifInfo = info[kCGImagePropertyGIFDictionary as String] as? [String: Any]
                else { continue }

            var duration: Double = 0
            if let unclampedDelay = gifInfo[kCGImagePropertyGIFUnclampedDelayTime as String] as? Double {
                duration = unclampedDelay
            } else {
                duration = gifInfo[kCGImagePropertyGIFDelayTime as String] as? Double ?? 0.1
            }
            if duration <= 0.001 {
                duration = 0.1
            }

            images.append((UIImage(cgImage: image), duration))
        }
    }
    //
    func frameDurationForImage(at index: Int) -> TimeInterval {
        return images[index].duration
    }

    subscript(index: Int) -> UIImage {
        return images[index].image
    }
}
class YoGifAnimatedImageView: UIImageView {
    var animatedImage: YoAnimateImage? {
        didSet {
            image = animatedImage?[0]
        }
    }
    var index: Int = 0 {
        didSet {
            if index != oldValue {
                image = animatedImage?[index]
            }
        }
    }
    private var animated = false
    private var lastTimestampChange = CFTimeInterval(0)
    // 定时器
    private lazy var displayLink: CADisplayLink = {
        let displayLink = CADisplayLink(target: self, selector: #selector(refreshDisplay))
        displayLink.add(to: .main, forMode: .common)
        displayLink.isPaused = true
        return displayLink
    }()
    //重写 开始刷新动画
    override func startAnimating() {
        if animated {
            return
        }
        displayLink.isPaused  = false
        animated = true
    }
    //重写 结束动画
    override func stopAnimating() {
        if !animated {
            return
        }
        displayLink.isPaused = true
        animated = false
    }
      //定时器 action
    @objc private func refreshDisplay() {
        guard animated, let animatedImage = animatedImage else { return }

        let currentFrameDuration = animatedImage.frameDurationForImage(at: index)
        let delta = displayLink.timestamp - lastTimestampChange

        if delta >= currentFrameDuration {
            index = (index + 1) % animatedImage.frameCount
            lastTimestampChange = displayLink.timestamp
        }
    }
}
