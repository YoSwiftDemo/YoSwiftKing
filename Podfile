
source 'https://github.com/CocoaPods/Specs.git' # https://www.cnblogs.com/-WML-/p/8944484.html


use_modular_headers!
inhibit_all_warnings!
pre_install do |installer|
    remove_swiftui()
end

def remove_swiftui
  # 解决 xcode13 Release模式下SwiftUI报错问题
  system("rm -rf ./Pods/Kingfisher/Sources/SwiftUI")
  code_file = "./Pods/Kingfisher/Sources/General/KFOptionsSetter.swift"
  code_text = File.read(code_file)
  code_text.gsub!(/#if canImport\(SwiftUI\) \&\& canImport\(Combine\)(.|\n)+#endif/,'')
  system("rm -rf " + code_file)
  aFile = File.new(code_file, 'w+')
  aFile.syswrite(code_text)
  aFile.close()
end

use_frameworks!
platform :ios, '13.0'
target 'YoSwiftKing' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YoSwiftKing
  pod 'YoNavBarView'
  pod 'YoCommon'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'ReactorKit'
  pod 'SnapKit'
  pod 'HandyJSON'
  pod 'NSObject+Rx'  # 为我们提供 rx_disposeBag
  pod 'Moya/RxSwift'    # 为RxSwift专用提供，对Alamofire进行封装的一个网络请求库
  pod 'RxNetwork/Core'
  pod 'Alamofire'
  pod 'RxNetwork/Cacheable'
  pod 'CleanJSON'
  pod 'MJRefresh'      # 上拉加载、下拉刷新的库
  pod 'Kingfisher'      # 图片加载库
  pod 'ObjectMapper'  # Json转模型
  pod 'Reusable'  # 优雅的使用自定义cell和view,不再出现Optional
  pod 'SVProgressHUD'
  pod 'ReactorKit' # RxSwift 一种框架
  pod 'RxGesture' # 基于view的Rx化手势封装
  pod 'DNSPageView' # 分页器
  pod 'LJTagsView'
  pod 'JXSegmentedView'
  pod 'Toaster'
  pod 'KakaJSON'
  pod 'SwiftyJSON'
  pod 'DefaultsKit'  , '~> 0.2.0' #  本地数据存储
  pod 'Then'
  pod 'R.swift', '6.1.0'
  target 'YoSwiftKingTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'YoSwiftKingUITests' do
    # Pods for testing
  end

end



