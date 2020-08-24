//
//  WebViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 09/03/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewViewController: UIViewController, ViewControllerWithLoadingOverlay {
    
    var url: String?
    private var webView: WKWebView?
    var loadingOverlay = LoadingOverlay()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
    }

    private func setupWebview() {
        webView = WKWebView()
        webView?.navigationDelegate = self

        view.addSubview(webView!)
        view.addEmbedded(view: webView!)

        loadUrl()
    }

    private func loadUrl() {
        if let urlString = self.url, let urlObject = URL(string: urlString) {
            webView?.load(URLRequest(url: urlObject))
            showLoadingOverlay()
        }
    }
}

extension WebViewViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoadingOverlay()
    }
}

extension WebViewViewController {
    
    func setUpNavBarTitle(title: String) {
        self.navigationItem.title = title
    }
}
