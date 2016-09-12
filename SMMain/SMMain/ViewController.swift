//
//  ViewController.swift
//  SMMain
//
//  Created by smallsao on 16/7/13.
//  Copyright © 2016 smallsao. All rights reserved.
//

import UIKit

import SMExtension
import SMUIKit

class ViewController: SMBaseViewController, SMRefreshTableViewDelegate, SMRefreshTableViewDataSource {

    var tableView:SMRefreshTableView = SMRefreshTableView()
    
    override func viewDidLoad() {
        tableView.frame = self.view.frame
        tableView.needFooterRefresh = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        var k = UITableView()
        k.delegate = self
        
        
        let p = SMLabel(
        
    }
    
    
    
    
    
}

