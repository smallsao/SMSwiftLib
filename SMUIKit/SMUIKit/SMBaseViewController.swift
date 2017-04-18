//
//  SMBaseViewController.swift
//  SMUIKit
//
//  Created by smallsao on 16/8/17.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


open class SMBaseViewController: SMViewController {
    open override func viewDidLoad() {
        self.view.backgroundColor = .white
    }
    
    open func receiveRoute(data:Dictionary<String, AnyObject>?) {
        
    }
    
}
