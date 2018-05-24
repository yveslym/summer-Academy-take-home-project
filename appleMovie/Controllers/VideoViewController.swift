//
//  VideoViewController.swift
//  appleMovie
//
//  Created by Yveslym on 5/14/18.
//  Copyright © 2018 yveslym. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class VideoViewController: UIViewController, WKUIDelegate, WKNavigationDelegate  {
    
     var webView: WKWebView!
    var url : URL!
    var loadingView: UIView!
    var loading: Double!{
        didSet{
            DispatchQueue.main.async {
                let animation = {
                    self.loadingView.frame.size.width += CGFloat(self.loading)
                }
                UIView.animate(withDuration: 0.2, animations: animation)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let myRequest = URLRequest(url: url!)
        webView.load(myRequest)
        self.loadingView = UIView(frame: CGRect(x: self.view.bounds.midX/2, y:  self.view.bounds.midY/2, width: 0, height: 10))
        loadingView.backgroundColor = .blue
       // self.view.addSubview(self.loadingView)
        
    }

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loading = webView.estimatedProgress
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}








