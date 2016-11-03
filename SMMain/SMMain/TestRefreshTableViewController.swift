//
//  TestRefreshTableViewController.swift
//  SMMain
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMExtension
import SMUIKit

class TestRefreshTableViewController: SMBaseViewController, SMRefreshTableViewDelegate, SMRefreshTableViewDataSource {
    
    var tableView:SMRefreshTableView = SMRefreshTableView(frame: CGRect(x: 40, y: 40, width: 300, height: 400), style: .plain)
    
    var datas:Array<String> = Array()
    
    var p = 0
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        tableView.needRefresh(header: true, footer: true)
        tableView.backgroundColor = UIColor.green
        
        self.view.backgroundColor = UIColor.yellow
        
        
        for i in 1...10 {
            datas.append("\(i)")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "SMRefreshTableViewCellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            let name = SMLabel()
            name.frame = CGRect(x: 20, y: 10, width: 100, height: 20)
            name.tag = 1000
            cell?.contentView.addSubview(name)
        }
        let name = cell?.contentView.viewWithTag(1000) as! SMLabel
        name.text = self.datas[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas.count
    }
    
    
    
    func tableFooterRefresh(_ tableView: SMRefreshTableView) {
        DispatchQueue.main.async(execute: {
            sleep(1)
            self.p = self.p + 10
            for i in 1...10 {
                self.datas.append("\(self.p + i)")
            }
            tableView.enableTableFooter()
            tableView.reloadData()
        })
    }
    
    
    func tableHeaderRefresh(_ tableView: SMRefreshTableView) {
        DispatchQueue.main.async(execute: {
            sleep(1)
            self.datas = Array<String>()
            self.p = 0
            for i in 1...10 {
                self.datas.append("\(i)")
            }
            
            tableView.enableTableHeader()
            
            tableView.reloadData()
            
            
        })
    }
    
    
    
}
