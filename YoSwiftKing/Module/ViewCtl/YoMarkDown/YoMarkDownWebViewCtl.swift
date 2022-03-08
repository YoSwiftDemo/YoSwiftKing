//
//  YoMarkDownWebViewCtl.swift
//  RxSwiftKing
//
//  Created by admin on 2021/10/14.
//

import UIKit
import WebKit
import SnapKit
class YoMarkDownWebViewCtl: YoBaseUIViewController , WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate{
    var webView: WKWebView!
    var  urlString  = Bundle.main.url(forResource: "markdown", withExtension:"html")?.absoluteString ?? ""
    var fileURLStr: String?
    var fileName: String?
   var markdownStr: String?
    var markdownName: String?
    ///文件相对路径
    var filePathStr: String = ""
    //视图将要加载
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    func loadUrl() {
       if   urlString != ""  {
            if let url = URL(string: urlString){
                webView.load(URLRequest(url: url))
            }
       }else if let fileUrlStr = self.fileURLStr{
           let fileUrl = URL(fileURLWithPath: fileUrlStr)
            webView.load(URLRequest(url: fileUrl))
       }else if let fileName = fileName {
           if let  fileUrl = Bundle.main.url(forResource: fileName, withExtension: nil) {
               webView.load(URLRequest(url: fileUrl))
           }
       }
    }
    //创建 webView
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Web展示"
        self.view.backgroundColor = .red
        initWebView()
        loadUrl()
    }
    //加载webview
    func initWebView() {
        let config =  WKWebViewConfiguration()
        config.userContentController.add(self, name: "YoMarkDownWeb")
        webView =  WKWebView(frame:view.frame, configuration: config)
        view.addSubview(webView)
        //
        webView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalTo(self.view);
        }
        webView.backgroundColor = .white
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    //接收的js发来的消息
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("didReceive JS message = \n \(message.name)\n \(message.body)")
    }
    //web加载完成
    func  webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.scrollView.refreshControl?.endRefreshing()
        debugPrint(self.webView.canGoBack)
        webView.evaluateJavaScript("document.title") {(result:Any?, error) in
            self.navigationItem.title = result as? String
        }
        
        if  let mdName : String = self.markdownName {
            self.markdownStr = self.getLocalContent(mdName as String)
            if  let markdownStr =  self.markdownStr {
                let hash = self.markdownName?.hash ?? 0
                let markdownToJS = markdownStr.replaceEscapeCharacter()
                let js = "document.getElementById('content').innerHTML = ppmarked('\(markdownToJS)');document.getElementById('ppTOCContent').innerHTML = ppGenerateTOC('\(markdownToJS)');setFileHash(\(hash));"
                webView.evaluateJavaScript(js) { result, error in
                    debugPrint(error ?? "")
                }
            }
        }
 
    }
    /** 获取本地的markdown文档内容 */
        func getLocalContent(_ resourceName: String) -> String {
            let path2 = Bundle.main.path(forResource: resourceName as String , ofType: "md")
            
            print(path2)
            if let path = Bundle.main.url(forResource: resourceName as String , withExtension: "md") {
            do{
                return try String(contentsOf: path, encoding:String.Encoding.utf8)
            } catch {
                return ""
            }
        }
        return "";
    }
    
    //MARK: WKNavigationDelegate
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
////        let should = shouldStartLoad(with: navigationAction.request)
////        if should {
////            decisionHandler(WKNavigationActionPolicy.allow)
////        } else {
////            decisionHandler(WKNavigationActionPolicy.cancel)
////        }
//    }
    //MARK: 是否可以跳转
    func shouldStartLoad(with request: URLRequest) -> Bool {
        //获取当前调转页面的URL
//        let requestUrl = request?.url?.absoluteString
        guard let urlString = request.url?.absoluteString else { return false }
        debugPrint("shouldStartLoad==\(urlString)")
        //    NSLog(@"requestUrl==%@",requestUrl);
        //    NSString *actionName = [requestUrl lastPathComponent];
        //    actionName = [actionName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if request.url?.scheme?.caseInsensitiveCompare("YoMarkDownWeb") == .orderedSame {
            self.webView.evaluateJavaScript("jsReceiveData('loginSucceed', 'success')", completionHandler: { response, error in
                
            })
            return false
        }
       if urlString.contains("markdown.html#") {
            //跳转到目录的某个位置后隐藏
            self.webView.evaluateJavaScript("displayTOC()", completionHandler: nil)
           return true
        }
        return false
 
    }
    override func didReceiveMemoryWarning() {
        debugPrint("==内存警告！")
    }

}

extension String {
    //https://github.com/marcuswestin/WebViewJavascriptBridge/blob/master/WebViewJavascriptBridge/WebViewJavascriptBridgeBase.m#L181
    ///如果在模板字符串中需要使用反引号，则前面要用反斜杠转义
    /// https://stackoverflow.com/a/22810989/4493393
    func replaceEscapeCharacter() -> String {
        var newMD = self.replacingOccurrences(of: "\\", with: "\\\\")
        newMD = newMD.replacingOccurrences(of: "\"", with: "\\\"")
        newMD = newMD.replacingOccurrences(of: "\'", with: "\\\'")
        newMD = newMD.replacingOccurrences(of: "\n", with: "\\n")
        //newMD = newMD.replacingOccurrences(of: "`", with: "\\`")
        //newMD = newMD.replacingOccurrences(of: "\r", with: "\\r")
        //newMD = newMD.replacingOccurrences(of: "\f", with: "\\f")
        //newMD = newMD.replacingOccurrences(of: "\u2028", with: "\\u2028")
        //newMD = newMD.replacingOccurrences(of: "\u2029", with: "\\u2029")
        return newMD
    }
}
