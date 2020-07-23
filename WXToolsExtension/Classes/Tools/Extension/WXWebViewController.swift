//
//  WXWebViewController.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
import WebKit

class WXWebViewController: CHBaseController, WKNavigationDelegate, WKUIDelegate {
    
    enum kH5NavtionJS:String {
        case test = "等待与h5互调"//
    }
    
    var mAction: String?
    deinit {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    var mCustomerBgColor:UIColor?
    
    private var backNavItem:WKNavigation?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.configuration.userContentController.add(self, name: kH5NavtionJS.test.rawValue)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: kH5NavtionJS.test.rawValue)
    }
    
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = WKUserContentController.init()
        configuration.selectionGranularity = .character
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.backgroundColor = UIColor.white
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.view.addSubview(webView)
        
        self.view.backgroundColor = UIColor.white
        if self.mCustomerBgColor != nil  {
            self.view.backgroundColor = self.mCustomerBgColor
            webView.backgroundColor = self.mCustomerBgColor
            self.view.backgroundColor = self.mCustomerBgColor
            webView.scrollView.backgroundColor = self.mCustomerBgColor
            webView.isOpaque = false
        }
        if self.title != nil  {
            self.navigationItem.title = self.title
        }
        
        webView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(kNavgationAllH)
            make.bottom.equalTo(-kBottomHeight)
        }
        webView.allowsBackForwardNavigationGestures = true
        if #available(iOS 9.0, *) {
            webView.allowsLinkPreview = true
        }
        
        if let str = self.mAction?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let url = URL.init(string: str){
                let req = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
                webView.load(req)
            }
        }
    }
    
    // MARK: - WKNavigation Delegate Methods
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        let schem = navigationAction.request.url?.scheme
        if schem?.contains("tel") == true {
            var  resourceSpecifier = navigationAction.request.url?.absoluteString
            resourceSpecifier = resourceSpecifier?.replacingOccurrences(of: "", with: "tel")//br_replaseString(with: "tel:")
            if let resourceSpecifier = resourceSpecifier{
                let callPhone = "telprompt://\(resourceSpecifier)"
                if let url = URL(string: callPhone){
                    DispatchQueue.main.async {
                        UIApplication.shared.openURL(url)
                    }
                }
              
            }
        }
        
        decisionHandler(.allow)
    }
    
    /*! @abstract Invoked when a main frame navigation starts.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        MBProgressHUDSwift.show("加载中...", self.view)
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        MBProgressHUDSwift.hideFormView(view: self.view)
//        MBProgressHUDSwift.showError("加载失败")
    }
    
    /*! @abstract Invoked when a main frame navigation completes.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        MBProgressHUDSwift.hideFormView(view: self.view)
        self.title = webView.title
        
        webView.evaluateJavaScript("closeBounce()") { (closeBounce, error) in
            if error != nil {
                webView.scrollView.bounces = true
                return
            }
            webView.scrollView.bounces = !((closeBounce as? Bool) ?? true)
        }
        
        if self.backNavItem == navigation {
            self.backNavItem = nil
            webView.reloadFromOrigin()
        }
        
    }
    // MARK: - WKUIDelegate Methods
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(true)
        })
        
        let cancel = UIAlertAction(title: "取消", style: .default, handler: { (action) in
            completionHandler(false)
        })
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
}
extension WXWebViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        
        if message.name == kH5NavtionJS.test.rawValue{
            
        }
    }
    
}
