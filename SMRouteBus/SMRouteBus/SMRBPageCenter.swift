//
//  SMRBPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMExtension
import SMUIKit


public class SMRBPageCenter: NSObject,SMRoutePageProtocol {
    
    var mapData = Dictionary<String, String>()
    
    public func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:()->Void) {
        // 根据pageId 找到相关的 ViewController
        let vcFrom = navigationController().topViewController
        let vcTo = createViewController(pageId: pageId)
        
        if let k = vcTo {
            if k.conforms(to: #protocol(SMRoutePageProtocol)) {
                
            }
            if let currentVC = k as? SMRoutePageProtocol {
                //currentVC responds to the MyCustomProtocol protocol =]
            }
            // 传递参数
//            k.responds(to: #selector(WDSPageProtocol)) {
//                let p = k as WDSPageProtocol
//                p.
//            }
        }
        else {
//            不存在页面，什么都不做
        }
        
    }
    
    public func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    public func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    
    
    func navigationController() -> UINavigationController {
        let appDelegate = UIApplication.shared().delegate
        return appDelegate?.window?!.rootViewController as! UINavigationController
    }
    
    
    func createViewController(pageId: String) -> SMBaseViewController? {
        let cls = convertClass(byPageId: pageId)
        let vc: SMBaseViewController.Type = cls as! SMBaseViewController.Type
        let viewController = vc.init()
        
        return viewController
        
    }
    
    func convert(pageId:String) -> UIViewController? {
        var vc = findViewController(byPageId: pageId)
        return vc
    }
    
    func findViewController(byPageId:String) -> UIViewController? {
        var cls = convertClass(byPageId: byPageId)
        
        if let k = cls {
            return k as! UIViewController
        }
        else {
            return nil
        }
    }
    
    
    func convertClass(byPageId:String) -> AnyClass? {
        let clsName = mapData.stringValue(key: byPageId)
        var cls = NSClassFromString(clsName)
        if cls == nil {
            cls = NSClassFromString(byPageId)
        }
        
        return cls
    }
}
