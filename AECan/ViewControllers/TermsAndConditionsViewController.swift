//
//  TermsAndConditionsViewController.swift
//  AECan
//
//  Created by Gastón Sobrevilla on 06/02/2020.
//  Copyright © 2020 Inmind. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class TermsAndConditionsViewController: UIViewController {
    
    private var webview: WKWebView?
    private let html = "<h1 style='text-align:center;'>AECan</h1><p style='text-align:center';>Términos y condiciones</p>"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarHelper.configureNavigationBar(title: "Términos y condiciones")
        setupWebview()
    }
    
    private func setupWebview() {
        let webview = WKWebView()
        view.addEmbedded(view: webview)
        webview.loadHTMLString(html, baseURL: nil)
        self.webview = webview
    }
}
