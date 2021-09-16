//
//  ViewController.swift
//  WKWebViewCookieIntro
//
//  Created by k-arimura on 2021/09/12.
//

import UIKit
import WebKit
import SnapKit
import FluctSDK

class ViewController: UIViewController {
    private static let g = "1000083204"
    private static let u = "1000124351"
    private static let url = URL(string:"http://192.168.86.238:8000/hoge")!
    var webview1: WKWebView!
    var config: WKWebViewConfiguration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config = WKWebViewConfiguration()
        config.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        let cookie = HTTPCookie.cookies(withResponseHeaderFields: ["Set-Cookie":"yummy_cookie=choco"], for: ViewController.url)
        config.websiteDataStore.httpCookieStore.setCookie(cookie[0]) {
            FSSRewardedVideo.shared.delegate = self
            let setting = FSSRewardedVideoSetting.default
            setting.activation.isAdColonyActivated = false
            setting.activation.isAppLovinActivated = true
            setting.activation.isFluctActivated = false
            setting.activation.isMaioActivated = false
            setting.activation.isNendActivated = false
            setting.activation.isTapjoyActivated = false
            setting.activation.isUnityAdsActivated = true
            setting.activation.isAdCorsaActivated = false
            setting.activation.isFiveActivated = false
            FSSRewardedVideo.shared.setting = setting
            FSSRewardedVideo.shared.load(withGroupId: ViewController.g, unitId: ViewController.u)
        }
        
        webview1 = WKWebView(frame: CGRect.zero, configuration: config)
        self.view.addSubview(webview1)
        webview1.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(self.view.snp.top).offset(50)
            make.centerX.equalTo(self.view)
        }
        self.view.addSubview(webview1)
        webview1.navigationDelegate = self
    }
}

extension ViewController : FSSRewardedVideoDelegate {
    func rewardedVideoDidLoad(forGroupID groupId: String, unitId: String) {
        print("rewarded video ad did load")
        FSSRewardedVideo.shared.presentAd(forGroupId: ViewController.g, unitId: ViewController.u, from: self)
    }

    func rewardedVideoShouldReward(forGroupID groupId: String, unitId: String) {
        print("should rewarded for app user")
    }

    func rewardedVideoDidFailToLoad(forGroupId groupId: String, unitId: String, error: Error) {
        // refs: error code list are FSSRewardedVideoError.h
        print("rewarded video ad load failed. Because \(error)")
    }

    func rewardedVideoWillAppear(forGroupId groupId: String, unitId: String) {
        print("rewarded video ad will appear")
    }

    func rewardedVideoDidAppear(forGroupId groupId: String, unitId: String) {
        print("rewarded video ad did appear")
    }

    func rewardedVideoWillDisappear(forGroupId groupId: String, unitId: String) {
        print("rewarded video ad will disappear")
    }

    func rewardedVideoDidDisappear(forGroupId groupId: String, unitId: String) {
        print("rewarded video ad did disappear")
        self.webview1.load(URLRequest(url: ViewController.url))
    }

    func rewardedVideoDidFailToPlay(forGroupId groupId: String, unitId: String, error: Error) {
        print("rewarded video ad play failed. Because \(error)")
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
