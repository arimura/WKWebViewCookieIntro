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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string:"http://192.168.86.238:8000/hoge")!
        let config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let cookie = HTTPCookie.cookies(withResponseHeaderFields: ["Set-Cookie":"yummy_cookie=choco"], for: url)
        config.websiteDataStore.httpCookieStore.setCookie(cookie[0]) {
            //http://192.168.86.238:8000/hoge Set-Cookie: yummy_cookie=choco
            let url = url
            let req = URLRequest(url: url)
            self.webview1.load(req)
        }
        webview1 = WKWebView(frame: CGRect.zero, configuration: config)
        
        self.view.addSubview(webview1)
        webview1.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(self.view.snp.top).offset(50)
            make.centerX.equalTo(self.view)
        }
        
        self.view .addSubview(webview1)
        webview1.navigationDelegate = self
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
    }
}
