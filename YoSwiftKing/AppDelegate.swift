//
//  AppDelegate.swift
//  YoSwiftKing
//
//  Created by admin on 2022/2/9.
//

import UIKit
import SwiftyJSON
import DefaultsKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy  var tabBarCtl = YoTabBarCtl()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        rootViewCtlAction()
        accountLogin("hanguiguang", password: "123456")
        return true
    }
}

/*
Swift 基础语法+基础理论
 UIKit 根据控件划分
 Foundation
 Lib
 Demo
 
 open： 用open修饰的类修饰的类可以在本某块(sdk),或者其他引入本模块的(sdk,module)继承，如果是修饰属性的话可以被此模块或引入了此某块(sdk)的模块（sdk）所重写
 public： 类用public(或级别更加等级更低的约束(如private等))修饰后只能在本模块（sdk）中被继承，如果public是修饰属性的话也是只能够被这个module(sdk)中的子类重写
 internal  是在模块内部可以访问，在模块外部不可以访问，a belong A , B import A, A 可以访问 a, B 不可以访问a.比如你写了一个sdk。那么这个sdk中有些东西你是不希望外界去访问他，这时候你就需要internal这个关键字（我在导入第三方框架时发现其实没有定义的话sdk里面是默认internal的
 fileprivate 同一个source文件中还是可以访问的，但是在其他文件中就不可以访问了 a belong to file A, a not belong to file B , 在 file A 中 可以访问 a，在 file B不可以访问a
 private
 
 
 
 Swift内存泄漏详解([weak self]使用场景)
 https://www.jianshu.com/p/cb45b5e016ff
 //@escaping @noescape
 //https://www.jianshu.com/p/905ba2a85455
 
 */



extension AppDelegate {
    func  rootViewCtlAction(){
        
//        window?.rootViewController  = self.tabBarCtl
//
//3333
        window?.rootViewController  = UINavigationController.init(rootViewController: LoginViewCtl())
    }
}

extension AppDelegate {

    func accountLogin(_ username: String, password: String) {
        let provider = SYMoyaProvider<LoginTargetType>()
        provider.responseSwiftyJSON(.server, target: .accountLogin(username: username, password: password)) { [weak self] (response: SYMoyaNetworkDataResponse<SwiftyJSON.JSON>) in
          
            switch response.result {
            case let .success(json):
               print(json)
                guard let code = json["code"].int, code == 200 , let data = json["data"].dictionary else {
                  
                    return
                }

                break
            case let .failure(error):
                print("7777")
                print(error)
                break
            }
        }
    }
}
