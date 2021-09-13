//
//  ViewController.swift
//  WKWebViewCookieIntro
//
//  Created by k-arimura on 2021/09/12.
//

import UIKit
import WebKit
import SnapKit

class ViewController: UIViewController {

   var webview1: WKWebView!
   var webview2: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        webview1 = WKWebView(frame: CGRect.zero, configuration: config)
        webview2 = WKWebView(frame: CGRect.zero, configuration: config)
        
        self.view.addSubview(webview1)
        webview1.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(self.view.snp.top).offset(50)
            make.centerX.equalTo(self.view)
        }
        
        self.view.addSubview(webview2)
        webview2.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(webview1.snp.bottom)
            make.centerX.equalTo(webview1)
        }
        
        self.view .addSubview(webview1)
        
        webview1.navigationDelegate = self
        
        //http://192.168.86.238:8000/hoge Set-Cookie: yummy_cookie=choco
        let url = URL(string:"http://192.168.86.238:8000/hoge")!
        let req = URLRequest(url: url)
        webview1.load(req)
    }
}

extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        let cookieStore = webview1.configuration.websiteDataStore.httpCookieStore
        cookieStore.getAllCookies { (cookies) in
            for cookie in cookies {
                print(cookie)
            }
        }
        //chek request has yummy_cookie=choco on server
        let url = URL(string:"http://192.168.86.238:8000/fuga")!
        let req = URLRequest(url: url)
        webview2.load(req)
    }
}
