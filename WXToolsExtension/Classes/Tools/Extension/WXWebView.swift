//
//  WXWebView.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
import WebKit
class WXWebView: UIView,WKUIDelegate ,WKNavigationDelegate{
    
    
    var webView:WKWebView?
    var showLoading = true //是否显示 loading
    var isFiled:Bool = false
    var mWebLoadingFinishBlock:((_ webHeight:CGFloat,_ view:WXWebView?)->())?
    var hadLoading = false
    var mNotCache = true

    var mWebDidStartLoadBlock:((_ view:WXWebView?,_ loadinged: Bool)->())?
    
    var mWebLoadingEndBlock:((_ view:WXWebView?,_ isSuccess: Bool)->())?
    
    var mLoadingHUD:UIActivityIndicatorView?
    
    
    func br_loadingWebView() {
        webView = WKWebView()
        self.addSubview(webView!)
        webView?.snp.makeConstraints({ (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        })
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        
        mLoadingHUD = UIActivityIndicatorView()
        mLoadingHUD?.style = .gray
        self.addSubview(mLoadingHUD!)
        mLoadingHUD?.snp.makeConstraints({ (make) in
            make.center.equalTo(self)
        })
        
        mLoadingHUD?.hidesWhenStopped = true
        //        mLoadingHUD?.startAnimating()
        
        webView?.scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        webView?.addObserver(self, forKeyPath: "isLoading", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    deinit {
        webView?.scrollView.removeObserver(self, forKeyPath: "contentSize", context: nil)
        webView?.removeObserver(self, forKeyPath: "isLoading", context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            
            let point = change?[NSKeyValueChangeKey.newKey]
            if let point = point as? CGSize{
                
                print(webView?.scrollView.contentSize)
                mWebLoadingFinishBlock?(point.height,self)
                
                let js = "Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)"
                webView?.evaluateJavaScript(js, completionHandler: { (any, error) in
                    print(any)
                })
             
            }
            
            
        }
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if showLoading {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            mLoadingHUD?.startAnimating()
        }
        
        mWebDidStartLoadBlock?(self,true)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        mLoadingHUD?.stopAnimating()
        mWebDidStartLoadBlock?(self,false)
        mWebLoadingEndBlock?(self,true)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        mLoadingHUD?.stopAnimating()
        mWebDidStartLoadBlock?(self,false)
//        self.hadLoading = false;
        mWebLoadingEndBlock?(self,false)
    }
    
    
    func br_setWebBgColor(color:UIColor) {
        webView?.backgroundColor = color
    }
    func br_loadUrl(urlStr:String?) {
        if let urlStr = urlStr, let url = URL(string: urlStr) {
            if hadLoading {
                return
            }
            let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
            let dateTime = Date(timeIntervalSince1970: 0)
            WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: dateTime, completionHandler: {
                
            });
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60)
            webView?.load(request)
            self.hadLoading = true;
        }
    }
    func br_loadHtmlString(content:String) {
        /*
         
         
         NSString *path = [[NSBundle mainBundle] bundlePath];
         NSURL *baseURL = [NSURL fileURLWithPath:path];
         */
        let path = Bundle.main.bundlePath
        let urlPath = URL(fileURLWithPath: path)
        if isFiled {
            let filePath = Bundle.main.path(forResource: "NewsTemplate", ofType: "html")
            let   html = try? NSString(contentsOfFile: filePath!, encoding: String.Encoding.utf8.rawValue)
            if let html = html {
                let htmlStr  = NSString(format: html, content)
                DispatchQueue.main.async(execute: {
                    self.webView?.loadHTMLString(htmlStr as String, baseURL: urlPath)
                })
                
            }
        }
        else{
            webView?.loadHTMLString(content, baseURL: urlPath)
            
        }
    }
    
    
}
