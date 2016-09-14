//
//  SMRBPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMRouteBus

class TestRBPageCenter: SMRBPageCenter {
    
    static var standard : TestRBPageCenter {
        struct Static {
            static let instance : TestRBPageCenter = TestRBPageCenter()
        }
        
        
        Static.instance.configMapData()
        
        return Static.instance
    }
    
    func configMapData() {
        mapData = ["A":"Test2ViewController"]
    }
    
    override func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:()->Void) {
        // 根据pageId 找到相关的 ViewController
        super.open(pageId: pageId, params: params, complete: complete)
        
    }
    
    override func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    override func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
}
