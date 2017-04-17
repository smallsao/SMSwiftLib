//
//  SMWeb.swift
//  SMUIKit
//
//  Created by smallsao on 2017/4/17.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit

open class SMWebViewController: SMBaseViewController {
    
    var webview:UIWebView = UIWebView()
    var url:String
    
    public init(pUrl:String) {
        self.url = pUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    override open func viewDidLoad() {
        self.view.addSubview(webview)
        self.webview.loadRequest(URLRequest(url: URL(string: self.url)!))
    }
    

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLayoutSubviews() {
        webview.frame = self.view.bounds
    }
}
