//
//  SMRouteBusManager.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

public protocol SMRoutePageProtocol:NSObjectProtocol {
    func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:()->Void)
    func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void)
    func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void)
}

public class SMRoute: NSObject {
    public static let standard = SMRoute()
    
    public func open(pageId:String, params:Dictionary<String, AnyObject>?) {
        self.open(pageId: pageId, params: params, complete: {
          () in
        })
    }
    
    public func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:()->Void) {
        // 根据pageId 找到相关的 ViewController
        
    }
    
    public func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    public func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
}
