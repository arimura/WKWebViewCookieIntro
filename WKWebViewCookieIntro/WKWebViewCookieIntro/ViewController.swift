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
        
        let url = URL(string:"http://192.168.86.238:8000/hoge")!
        let req = URLRequest(url: url)
        webview.load(req)
    }


}

