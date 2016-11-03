//
//  SMRBPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit
import SMRouteBus

class TestRBPageCenter: SMBasePageCenter {
    
   
    
    func configMapData() {
        self.mapData = ["A":"Test2ViewController"]
    }
    
    override func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        // 根据pageId 找到相关的 ViewController
        let vcFrom = self.navigationController().topViewController
        let vcTo = self.createViewController(pageId: pageId)
        
        
        
        if let k = vcTo {
            k.receiveRoute(data: params)
            if let p = complete {
                p(vcFrom!,k)
            }
        }
        else {
            //            不存在页面，什么都不做
//            not found
        }
        
    }

    
    override func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    override func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    override func showErrorMsg() {
        super.showErrorMsg()
    }
    
}
