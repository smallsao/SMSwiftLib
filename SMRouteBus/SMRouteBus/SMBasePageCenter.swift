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


open class SMBasePageCenter: NSObject {
    
    public func initWithTT() {
        
    }
    
    public var mapData = Dictionary<String, String>()
    
    open func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        
    }
    
    open func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    open func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    
    
    public func navigationController() -> UINavigationController {
        let appDelegate = UIApplication.shared.delegate
        return appDelegate?.window?!.rootViewController as! UINavigationController
    }
    
    
    public func createViewController(pageId: String) -> SMBaseViewController? {
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
    
    public func classNotFound(){
        UIApplication.shared.endIgnoringInteractionEvents()
        showErrorMsg()
    }
    
    open func showErrorMsg() {
        
    }
    
}
