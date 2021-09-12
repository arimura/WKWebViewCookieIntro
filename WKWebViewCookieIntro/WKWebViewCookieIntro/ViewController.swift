//
//  ViewController.swift
//  WKWebViewCookieIntro
//
//  Created by k-arimura on 2021/09/12.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.navigationDelegate = self
        
        let url = URL(string:"http://192.168.86.238:8000/hoge")!
        let req = URLRequest(url: url)
        webview.load(req)
    }
}

extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        let cookieStore = webview.configuration.websiteDataStore.httpCookieStore
        cookieStore.getAllCookies { (cookies) in
            for cookie in cookies {
                print(cookie)
            }
        }
    }
}
