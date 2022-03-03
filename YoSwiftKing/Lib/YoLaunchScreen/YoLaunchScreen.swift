//
//  YoLaunchScreen.swift
//  KingHealth
//
//  Created by admin on 2022/1/26.
//
// https://github.com/MQZHot/ZLaunchAd
/*
 仿写 资料
 https://github.com/internetWei/LLaunchScreen
 
 //try 能反序列化成功, 就给你返回成功的值; 不能成功就给你返回nil
 https://www.jianshu.com/p/a5015199d94e
 */
import Foundation
import UIKit
import Kingfisher
// MARK: 代理
protocol YoLaunchScreenDelegate: NSObjectProtocol {
    //定义协议方法
}
// MARK: 定义启动类型枚举  13才有暗黑
public enum YoLaunchScreenType: String{
    case verticalLight
    case horizontalLight
    @available(iOS 13, *)
    case verticalDark
    case horizontalDark
}
//标识符，用于存储/读取启动图的具体名称(
private let LaunchImageInfoID = "LaunchImageInfoID"
//标识符，用于存储/读取启动图的修改记录
private let LaunchImageModifyID = "LaunchImageModifyID"
//标识符，用于存储/读取新版本信息
private let LaunchImageVersionInfoID = "LaunchImageVersionInfoID"
//标识符，用于存储/读取版本记录
private let LaunchImageOldVersionID = "LaunchImageOldVersionID"
//标识符，true表示将`restoreAsBefore`方法延迟执行
private var isLaunchImageRestoreAsBefore = false
//标识符，true表示将`repairException`方法延迟执行
private var isLaunchImageRepairException  = false
// MARK: 定义启动管理类
public class YoLaunchScreen: NSObject {
    //声明协议对象
    weak var delegate: YoLaunchScreenDelegate?
    /*
     自定义暗黑系启动图的校验规则:
     默认情况下，`YoaunchScreen`通过获取图片最右上角1×1像素单位的RGB值来判断该图片是不是暗黑系图片；
     如果您需要修改它，请在`application: didFinishLaunchingWithOptions:`返回前实现它
     */
    public static var hasDarkImageBlock:(_ image: UIImage) -> Bool = {
        $0.hasDarkImage
    }
    /*
     获取 指定模式下的 本地启动图
     当您的APP不支持深色/横屏时，尝试获取启动图会返回nil
     */
    public class func launchImage(from type: YoLaunchScreenType) -> UIImage? {
        //初始化启动
        self.initLaunchScreen()
        //声明原图变量
        var originImage: UIImage?
        //
        self.launchScreenImageCustonBlock { (tmpDirectory) in
            let launchImageInfo =  launchScreenInfo(key: LaunchImageInfoID)
            let imageName = launchImageInfo[type.rawValue]
            guard imageName != nil else {
                return
            }
            let fullPath = tmpDirectory.appending("/\(imageName!)")
            originImage = UIImage.init(contentsOfFile: fullPath)
        }
        return originImage
    }
    /*
    恢复至默认启动图
     */
    public class func restoreAsBefore() {
        //判定默认启动图 是否存在
        if isExistsOriginLaunchImage {
            //启动图 替换 置空处理
            self.replaceLaunchImage(replaceImage: nil, launchScreenType: .verticalLight, quality: 0.8, validation: nil)
            self.replaceLaunchImage(replaceImage: nil, launchScreenType: .horizontalLight, quality: 0.8, validation: nil)
            if #available(iOS 13.0, *) {
                self.replaceLaunchImage(replaceImage: nil, launchScreenType: .verticalDark, quality: 0.8, validation: nil)
                self.replaceLaunchImage(replaceImage: nil, launchScreenType: .horizontalDark, quality: 0.8, validation: nil)
            }
            //删除自定义启动图路径
            try? FileManager.default.removeItem(atPath: customLaunchImageFullBackupPath)
            isLaunchImageRestoreAsBefore = false
        }else{
            isLaunchImageRestoreAsBefore = true
        }
    }
    //替换指定启动图
    @discardableResult
    public class func replaceLaunchImage(replaceImage: UIImage?, launchScreenType: YoLaunchScreenType, quality: CGFloat, validation: ((UIImage, UIImage) -> Bool)?) -> Bool {
        //初始化启动图设置
        self.initLaunchScreen()
        let isReplace = (replaceImage != nil)
        //替换图不存在
        if replaceImage == nil {
            //启动图备份路径
            //rawValue 用于swift中的enum(枚举)，用于取枚举项的原始值
            let fullPath = originLaunchImageBackupFullPath.appending("/\(launchScreenType.rawValue).png")
            let replaceImage = UIImage.init(contentsOfFile: fullPath)
            if replaceImage == nil {
                return false
            }
        }
          //判断是不是竖屏
        var isVertocal = false
        if launchScreenType  == .verticalLight {
            isVertocal = true
        }
        if #available(iOS 13.0, *) {
            if launchScreenType == .verticalDark {
                isVertocal = true
            }
        }
        //调正图片尺寸和启动图一致
        let replaceImage: UIImage = replaceImage!.resizeImage(isVertical: isVertocal)
        let replaceImageData: Data! = replaceImage.jpegData(compressionQuality:quality)
        if replaceImageData == nil{
            return false
        }
         //替换启动图 写入本地
        var isResult = false
        isResult = self.launchScreenImageCustonBlock{ (tempDirectory) in
                        let launchImageInfo = launchScreenInfo(key: LaunchImageInfoID)
                        let imageName: String! = launchImageInfo[launchScreenType.rawValue]
                        if imageName == nil {
                          return
                        }
                          //存储路径+动态模式下图名
                        let fullPath = tempDirectory + "/" + imageName
                        let originImage: UIImage! = UIImage.init(contentsOfFile: fullPath)
                        if originImage == nil {
                            return
                        }
            
                        let validationResult = validation == nil ? true : validation!(originImage, replaceImage)
                        if validationResult == false {
                            return
                        }
            
                        do {
                            try replaceImageData.write(to: URL.init(fileURLWithPath: fullPath))
                            isResult = true
                        }catch {
                            assert(false, "replae image write faile")
                        }
        }
        if isResult == false {
            return isResult
        }
        //备份 replaceImage
       let customLaunchImageFullPath = customLaunchImageFullBackupPath + "/" + launchScreenType.rawValue + ".png"
        if isReplace {
            try? replaceImageData.write(to: URL.init(fileURLWithPath: customLaunchImageFullPath))
        } else {
            try? FileManager.default.removeItem(atPath: customLaunchImageFullPath)
        }
        //纪录启动码那个图修改信息
        var modifyDictionary = launchScreenInfo(key: LaunchImageModifyID)
        modifyDictionary[launchScreenType.rawValue] = isReplace ? "true" : "false"
        UserDefaults.standard.setValue(modifyDictionary, forKey: LaunchImageModifyID)
        return true
    }
    //替换所有竖屏启动图
    public class func replaceVerticalLaunchImage(replaceImage: UIImage?){
        self.replaceLaunchImage(replaceImage: replaceImage, launchScreenType: .verticalLight, quality: 0.8, validation: nil)
        if #available(iOS 13.0, *) {
            self.replaceLaunchImage(replaceImage: replaceImage, launchScreenType: .verticalDark, quality: 0.8, validation: nil)
        }
    }
    //替换所有横屏 启动图
    public class func rplaceHorizontalLaunchImage(replaceImage: UIImage?){
        self.replaceLaunchImage(replaceImage: replaceImage, launchScreenType: .horizontalLight, quality: 0.8, validation: nil)
        if #available(iOS 13.0, *) {
            self.replaceLaunchImage(replaceImage: replaceImage, launchScreenType: .horizontalDark, quality: 0.8, validation: nil)
        }
    }
    //完成启动
    public class func  finishLaunching() {
        self.initLaunchScreen()
        self.launchImageVersion(identifier: "finishLaunching") {
            let modifyDictionary = launchScreenInfo(key: LaunchImageModifyID)
            //当更新版本时恢复启动图为上次修改时的状态
            for  (imageName, isModify) in modifyDictionary {
                if isModify.elementsEqual("true") {
                    let fullPath = customLaunchImageFullBackupPath + "/" + imageName + ".png"
                    self.replaceLaunchImage(replaceImage: UIImage.init(contentsOfFile: fullPath),
                                            launchScreenType: YoLaunchScreenType.init(rawValue: imageName)!,
                                            quality: 0.8,
                                            validation: nil)
                }
            }
            self.repairException()
        }
    }
    //备份启动图
    public class func backupSystemLaunchImage(){
        self.launchImageVersion(identifier: "backupSystemLaunchImage") {
            var supportHorizontalScreen: Bool {
                get {
                    let  bundleInfoArray: Array<String>? = Bundle.main.infoDictionary!["UISupportedInterfaceOrientations"] as? Array<String>
                    assert(bundleInfoArray != nil, "UISupportedInterfaceOrientations get faild")
                    if bundleInfoArray!.contains("UIInterfaceOrientationLandscapeLeft") || bundleInfoArray!.contains("UIInterfaceOrientationLandscapeRight") {
                      return true
                    }else{
                        return false
                    }
                }
            }
            //备份 路径
            let backupPath = originLaunchImageBackupFullPath
            //清理备份文件夹
            let backupArray = try? FileManager.default.contentsOfDirectory(atPath: backupPath)
            for name in backupArray ?? [] {
                let fullPath = backupPath + "/\(name)"
                try? FileManager.default.removeItem(atPath: fullPath)
            }
        //生成启动图
            var verticalLightImage: UIImage? = nil
            var verticalDarkImage: UIImage? = nil
            var horizontalLightImage: UIImage? = nil
            var horizontalDarkImage: UIImage? = nil
            verticalLightImage = UIImage.createLaunchimageFromSnapshotStoryboard(isPortrait: true, isDark: false)
            if #available(iOS 13.0 , *) {
                verticalDarkImage = UIImage.createLaunchimageFromSnapshotStoryboard(isPortrait: true, isDark: true)
            }
            if supportHorizontalScreen{
                horizontalLightImage = UIImage.createLaunchimageFromSnapshotStoryboard(isPortrait: false, isDark: false)
                if #available(iOS 13.0, *) {
                    horizontalDarkImage = UIImage.createLaunchimageFromSnapshotStoryboard(isPortrait: false, isDark: true)
                }
            }
            
            //本地启动图路径
            let verticalLightPath = backupPath.appending("/\(YoLaunchScreenType.verticalLight).png")
            let horizontalLightPath = backupPath.appending("/\(YoLaunchScreenType.horizontalLight.rawValue).png")
            var verticalDarkPath: String? = nil
            var horizontalDarkPath: String? = nil
            if #available(iOS 13.0, *) {
                verticalDarkPath = backupPath.appending("/\(YoLaunchScreenType.verticalDark).png")
                horizontalDarkPath = backupPath.appending("/\(YoLaunchScreenType.horizontalDark).png")
            }
            
            //初始化启动image对象
            if verticalLightImage != nil {
                try? verticalLightImage?.jpegData(compressionQuality: 0.8)?.write(to: URL.init(fileURLWithPath: verticalLightPath))
            }
            if verticalDarkImage != nil && verticalDarkPath != nil {
                try? verticalDarkImage?.jpegData(compressionQuality: 0.8)?.write(to: URL.init(fileURLWithPath: verticalDarkPath!))
            }
            if horizontalLightImage != nil {
                try? horizontalLightImage?.jpegData(compressionQuality: 0.8)?.write(to: URL.init(fileURLWithPath: horizontalLightPath))
            }
            if horizontalDarkImage != nil && horizontalDarkPath != nil {
                try? horizontalDarkImage?.jpegData(compressionQuality: 0.8)?.write(to: URL.init(fileURLWithPath: horizontalDarkPath!))
            }
            
            if isLaunchImageRestoreAsBefore {
                self.repairException()
            }
            if  isLaunchImageRestoreAsBefore {
                self.restoreAsBefore()
            }
        }
    }
}
// MARK: - Private
extension YoLaunchScreen {
    // MARK: 获取 启动信息
    private  class func launchScreenInfo(key defaultName: String) -> Dictionary <String, String>{
        guard  let infoDic = UserDefaults.standard.object(forKey: defaultName) as? Dictionary<String, String> else    {
            return [:]
        }
        return infoDic
    }
    // MARK: - Private  获取图片前设置
    private class func initLaunchScreen() {
        //获取启动信息
        var modifyDic = launchScreenInfo(key: LaunchImageInfoID)
        if modifyDic.isEmpty {
            modifyDic[YoLaunchScreenType.verticalLight.rawValue] = "false"
            modifyDic[YoLaunchScreenType.horizontalDark.rawValue] = "false"
            if #available(iOS 13.0, *) {
                modifyDic[YoLaunchScreenType.verticalDark.rawValue] = "false"
                modifyDic[YoLaunchScreenType.horizontalDark.rawValue] = "false"
            }
        }
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let oldAppVersion: String = UserDefaults.standard.object(forKey: LaunchImageOldVersionID) as? String ?? "default"
        //对比版本
        if appVersion.elementsEqual(oldAppVersion) == false {
            var versionInfoDic =  launchScreenInfo(key: LaunchImageVersionInfoID)
            versionInfoDic["finishLaunching"] = "true"
            versionInfoDic["generateLaunchScreenInfo"] = "true"
            versionInfoDic["backupSystemLaunchImage"] = "true"
            versionInfoDic["repairException"] = "true"
            //存 版本信息
            UserDefaults.standard.setValue(versionInfoDic, forKey: LaunchImageVersionInfoID)
            UserDefaults.standard.setValue(appVersion, forKey: LaunchImageOldVersionID)
        }
        //
    }
    // MARK: 生成启动图名称信息
    private class func initLaunchScreenInfo() {
        //启动图版本对比
        self.launchImageVersion(identifier: "generateLaunchScreenInfo") {
            self.launchScreenImageCustonBlock { (tmpDirectory) in
                var infoDictoinary: Dictionary<String, String> = [:]
                let contents = try? FileManager.default.contentsOfDirectory(atPath: tmpDirectory)
                for imageName in contents ?? [] {
                    if isSnapShotSuffix(imageName: imageName) == false {
                        continue
                    }
                    let image = UIImage.init(contentsOfFile: tmpDirectory + "/" + imageName)
                    if image == nil {
                        continue
                    }
                    //13以上才有暗黑
                    if #available(iOS 13.0, *) {
                        let hasDarkImage = hasDarkImageBlock(image!)
                        if image!.size.width < image!.size.height {
                            //13 竖屏 深色启动图
                            if hasDarkImage {
                                infoDictoinary[YoLaunchScreenType.verticalDark.rawValue] = imageName
                            }else{
                                //13 竖屏 浅色启动图
                                infoDictoinary[YoLaunchScreenType.verticalLight.rawValue] = imageName
                            }
                        } else {
                            //13横屏 深色启动图
                            if hasDarkImage {
                                infoDictoinary[YoLaunchScreenType.horizontalDark.rawValue] = imageName
                            }else{
                                //13 横屏 浅色启动图
                                infoDictoinary[YoLaunchScreenType.horizontalLight.rawValue] = imageName
                            }
                        }
                    }  else {
                        
                        if image!.size.width < image!.size.height {
                            // 竖屏浅色启动图
                            infoDictoinary[YoLaunchScreenType.verticalLight.rawValue] = imageName
                        }else{
                            //横屏 深色启动图
                            infoDictoinary[YoLaunchScreenType.horizontalLight.rawValue] = imageName
                        }
                    }
                }
            }
        }
    }
    // MARK: 修复启动图显示异常
    private class func launchImageRepairException() {
        //判断是不是新版本
        launchImageVersion(identifier: "repairException") {
            
        }
        
        
    }
    // MARK: 判断是不是 新版本
    //如果版本对比不一致 更新本地数据
    private class func launchImageVersion(identifier: String, block: () -> ()) {
#if DEBUG
        block()
#else
        var  versionInfoDic = launchScreenInfo(key: LaunchImageVersionInfoID)
        let isNewVersion = versionInfoDic[identifier] ?? ""
        if isNewVersion.elementsEqual("true") {
            block()
            versionInfoDic[identifier] = "false"
            UserDefaults.standard.setValue(versionInfoDic, forKey: LaunchImageVersionInfoID)
        }
#endif
    }
    //
    private class var haveOriginLaunchImage: Bool {
        let array  = try? FileManager.default.contentsOfDirectory(atPath: originLaunchImageBackupFullPath)
        for obj in array ?? [] {
            if isSnapShotSuffix(imageName: obj) {
                return true
            }
        }
        return true
    }
    //
    private class func createFolder(folderName: String) -> String {
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/YoLaunchScreen")
        let fullPath = rootPath + "/" + folderName
        if FileManager.default.fileExists(atPath: fullPath) == false {
            do {
                try FileManager.default.createDirectory(atPath: fullPath, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                assert(false, error.localizedDescription)
            }
        }
        
        return fullPath
    }
    //判断图片类型
    private class func isSnapShotSuffix(imageName: String) -> Bool {
        if imageName.hasSuffix(".ktx") {
            return true
        }
        if imageName.hasSuffix(".png") {
            return true
        }
        return false
    }
    //启动图备份路径
    private static var originLaunchImageBackupFullPath: String {
        //设置备份路径
        return YoLaunchScreen.createFileFolder(folderName: "OriginLaunchImageBackupFullPath")
    }
    //用户启动图备份路径
    private class var customLaunchImageFullBackupPath: String {
        return YoLaunchScreen.createFolder(folderName: "custom_launchImage_backup_rootpath")
    }
    //设置沙盒存储文件夹
    private class func createFileFolder(folderName: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("YoLaunchScreen")
        let fullPath = path + "/" + folderName
        if FileManager.default.fileExists(atPath: fullPath) == false {
            do {
                try FileManager.default.createDirectory(atPath: fullPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
                assert(false, error.localizedDescription)
            }
        }
        return fullPath
    }
    //创建图片存储路径并返回 路径
    @discardableResult
    private class func launchScreenImageCustonBlock(block: (String) -> ()) -> Bool {
        //获取 系统启动图路径
        let launchImageFullPath: String! = systemLaunchImagePath
        if  launchImageFullPath == nil{
            return false
        }
        // 工作目录(get work directory)
        let tmpDirectory: String = {
            let rootPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
            return rootPath!.appending("/YoLaunchScreen_tmp")
        }()
        // 清理工作目录(clean of folders)
        if FileManager.default.fileExists(atPath: tmpDirectory) {
            try? FileManager.default.removeItem(atPath: tmpDirectory)
        }
        
        do {
            try FileManager.default.moveItem(atPath: launchImageFullPath, toPath: tmpDirectory)
        } catch let error {
            assert(false,error.localizedDescription)
            return false
        }
        
        block(tmpDirectory)
        
        //还原启动图 Restore
        do {
            try FileManager.default.moveItem(atPath: tmpDirectory, toPath: launchImageFullPath)
        } catch let error {
            assert(false, error.localizedDescription)
            return false
        }
        // 删除工作文件夹(delete of folders)
        if FileManager.default.fileExists(atPath: tmpDirectory) {
            do {
                try FileManager.default.removeItem(atPath: tmpDirectory)
            } catch let error {
                assert(false, error.localizedDescription)
                return false
            }
        }
        return true
    }
    //系统启动图路径
    private class var systemLaunchImagePath: String? {
        
        let bundleID: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String
        
        guard bundleID != nil else {
            assert(false, "get CFBundleIdentifier faild")
            return nil
        }
        
        let snapshotsPath: String
        if #available(iOS 13.0, *) {
            let libraryDirectory = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first ?? ""
            snapshotsPath = "\(libraryDirectory)/SplashBoard/Snapshots/\(bundleID!) - {DEFAULT GROUP}"
        } else {
            let cacheDirectory = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
            snapshotsPath = cacheDirectory + "/Snapshots/" + bundleID!
        }
        
        if FileManager.default.fileExists(atPath: snapshotsPath) { return snapshotsPath }
        
        return nil
    }
    // 判断是不是 默认启动图
    private class var isExistsOriginLaunchImage: Bool {
        let subArray = try? FileManager.default.contentsOfDirectory(atPath: originLaunchImageBackupFullPath)
        for obj in subArray ?? [] {
            if isSnapShotSuffix(imageName: obj) {
                return true
            }
        }
        return false
    }
    // 修复启动图显示异常(Fix the abnormal display of the launch screen)
    private class func repairException() {
        self.launchImageVersion(identifier: "repairException") {
            if isExistsOriginLaunchImage {
                let modifyDictionary = launchScreenInfo(key: LaunchImageModifyID)
                for (imageName, isModify) in modifyDictionary {
                    if isModify.elementsEqual("false") {
                        self.replaceLaunchImage(replaceImage: nil,
                                                launchScreenType: YoLaunchScreenType(rawValue: imageName)!,
                                                quality: 0.8,
                                                validation: nil)
                    }
                }
                
                isLaunchImageRepairException = false
            } else {
                isLaunchImageRepairException = true
            }
        }
    }
}

extension UIImage {
    
    var hasDarkImage: Bool {
        get {
            let RGBArr = self.pixelColor(from: CGPoint(x: self.size.width - 1, y: 1))
            
            guard RGBArr != nil else {
                assert(false, "RGBArr is nil")
                return false
            }
            
            
            var maxRGB: Double! = RGBArr!.first
            // 找到颜色的最大值(Get the maximum color)
            for number in RGBArr! {
                if maxRGB < number {
                    maxRGB = number
                }
            }
            
            
            if maxRGB >= 190 { return false }
            
            
            for number in RGBArr! {
                if number + 10 < maxRGB { return false }
            }
            
            return true
        }
    }
    
    
    func pixelColor(from point: CGPoint) -> Array<Double>? {
        
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: self.size).contains(point) else {
            return nil
        }
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let red = Double(data[pixelInfo])
        let green = Double(data[pixelInfo+1])
        let blue = Double(data[pixelInfo+2])
        
        return [red, green, blue]
    }
    
    
    /// 调整图片尺寸与启动图保持一致(Adjust the image size to be consistent with the launch image)
    func resizeImage(isVertical: Bool) -> UIImage {
        
        let imageSize = CGSize.init(width: self.size.width * self.scale, height: self.size.height * self.scale)
        let contextSize = UIImage.contextSize(isVertical: isVertical)
        
        if imageSize.equalTo(contextSize) == false {
            UIGraphicsBeginImageContext(contextSize)
            let ratio = max((contextSize.width / self.size.width), (contextSize.height / self.size.height))
            let rect = CGRect.init(x: 0, y: 0, width: self.size.width * ratio, height: self.size.height * ratio)
            self.draw(in: rect)
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return resizedImage!
        }
        
        return self
    }
    
    
    class func contextSize(isVertical: Bool) -> CGSize {
        
        let screenScale = UIScreen.main.scale
        let screenSize = UIScreen.main.bounds.size
        
        var width = min(screenSize.width, screenSize.height)
        var height = max(screenSize.width, screenSize.height)
        
        if isVertical == false {
            width = max(screenSize.width, screenSize.height)
            height = min(screenSize.width, screenSize.height)
        }
        
        return CGSize.init(width: width * screenScale, height: height * screenScale)
    }
    
    
    // 创建启动图(create launch image)
    class func createLaunchimageFromSnapshotStoryboard(isPortrait: Bool, isDark: Bool) -> UIImage? {
        
        var launchScreenName: String {
            get {
                let name = Bundle.main.infoDictionary!["UILaunchStoryboardName"]
                assert(name != nil, "get UILaunchStoryboardName faild")
                return name as! String
            }
        }
        
        
        let currentWindows = UIApplication.shared.windows;
        
        var interfaceStyleArray: Array<Any>! = []
        if #available(iOS 13.0, *) {
            for window in currentWindows {
                interfaceStyleArray.append(window.overrideUserInterfaceStyle)
                if isDark {
                    window.overrideUserInterfaceStyle = .dark
                } else {
                    window.overrideUserInterfaceStyle = .light
                }
            }
        }
        
        
        let storyboard = UIStoryboard.init(name: launchScreenName, bundle: nil)
        let launchImageVC = storyboard.instantiateInitialViewController()
        
        guard launchImageVC != nil else {
            assert(false, "launchImageVC faild")
            return nil
        }
        
        
        launchImageVC!.view.frame = UIScreen.main.bounds
        
        if isPortrait {
            if launchImageVC!.view.frame.size.width > launchImageVC!.view.frame.size.height {
                launchImageVC!.view.frame = CGRect.init(x: 0, y: 0, width: launchImageVC!.view.frame.size.height, height: launchImageVC!.view.frame.size.width)
            }
        } else {
            if launchImageVC!.view.frame.size.width < launchImageVC!.view.frame.size.height {
                launchImageVC?.view.frame = CGRect.init(x: 0, y: 0, width: launchImageVC!.view.frame.size.height, height: launchImageVC!.view.frame.size.width)
            }
        }
        
        launchImageVC!.view.setNeedsLayout()
        launchImageVC!.view.layoutIfNeeded()
        
        UIGraphicsBeginImageContextWithOptions(launchImageVC!.view.frame.size, false, UIScreen.main.scale)
        launchImageVC!.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let launchImage = UIGraphicsGetImageFromCurrentImageContext()
        if launchImage == nil { return nil }
        UIGraphicsEndImageContext()
        
        if #available(iOS 13.0, *) {
            for (index, interfaceStyle) in interfaceStyleArray.enumerated() {
                let window = currentWindows[index]
                window.overrideUserInterfaceStyle = interfaceStyle as! UIUserInterfaceStyle
            }
        }
        
        return launchImage!
    }
}





