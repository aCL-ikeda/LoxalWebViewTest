//
//  ViewController.swift
//  WebView
//
//  Created by 岡﨑悠太 on 2018/08/20.
//  Copyright © 2018年 jp.okazaki. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let urlStr = "https://127.0.0.1"

    var activityIndicator = UIActivityIndicatorView()
    var webView: WKWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setLoadingControl()
        self.setWebView()
        self.load()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 最前面に移動
        self.view.bringSubview(toFront: self.activityIndicator)
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func load() {
        self.webView.load(URLRequest(url: URL(string: self.urlStr)!))
    }

    private func setWebView() {

        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)

        self.webView.translatesAutoresizingMaskIntoConstraints = false

        self.webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }

    private func setLoadingControl() {
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        self.activityIndicator.center = self.view.center

        // クルクルをストップした時に非表示する
        self.activityIndicator.hidesWhenStopped = true

        // 色を設定
        self.activityIndicator.activityIndicatorViewStyle = .whiteLarge
        self.activityIndicator.color = .green

        //Viewに追加
        self.view.addSubview(self.activityIndicator)
    }
}

extension WebViewController: WKNavigationDelegate {

    // 読み込み前
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        decisionHandler(.allow)
    }


    // 読み込み開始
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }

    // 読み込み後
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        decisionHandler(.allow)
    }

    // 読み込み失敗
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.activityIndicator.stopAnimating()
        debugPrint(error)
    }

    // 読み込み完了
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let trust = challenge.protectionSpace.serverTrust!
        let credential = URLCredential(trust: trust)
        completionHandler(.useCredential, credential)
    }
}


