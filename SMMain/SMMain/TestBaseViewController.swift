//
//  TestBaseViewController.swift
//  SMMain
//
//  Created by smallsao on 2017/4/18.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit
import SMRouteBus
import SMTools
import SMExtension


open class TestBaseViewController: SMBaseViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(goBack))
        self.navigationItem.backBarButtonItem = item

        let btnBack = UIButton(type: .custom)
        btnBack.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
        btnBack.setTitle("返回", for: .normal)
        btnBack.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        
    }
    open override func receiveRoute(data:Dictionary<String, AnyObject>?) {
        
    }
    
    open func goBack() {
        
        self.navigationController?.popViewController(animated: true)
        
//        SMRoute.standard.pageCenter.close()
//        SMRoute.standard.pageCenter.close(byCount: 2)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit {
        print(11)
    }

}
