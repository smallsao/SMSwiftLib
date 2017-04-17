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


public class SMBaseCenter: NSObject {
    public var navigation:UINavigationController = UINavigationController()
    
    
    open func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        
    }
    
    open func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    open func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void) {
        
    }
    
    
    public func currentViewController() -> UIViewController {
        return self.navigationController().topViewController!
    }
    
    
    public func navigationController() -> UINavigationController {
        return self.navigation
    }
    
    
    public func createViewController(vcType viewControllerType:SMRBPageType, aUrl: String) -> UIViewController? {
        var viewController:UIViewController?
        if viewControllerType == .None {
            
        }
        else if viewControllerType == .PAGE {
            if let cls = convert(className: aUrl) {
                let vc: UIViewController.Type = cls as! UIViewController.Type
                viewController = vc.init()
            }
            
        }
        else if viewControllerType == .HTTP {
            viewController = SMWebViewController(pUrl: aUrl)
            
        }
        else if viewControllerType == .HTTPS {
            viewController = SMWebViewController(pUrl: aUrl)
           
        }
        else if viewControllerType == .IMG {
            
        }
        
        return viewController
        
    }
    
    func convert(className:String) -> AnyClass? {
        return NSClassFromString(className)
    }
    
    public func classNotFound(){
        UIApplication.shared.endIgnoringInteractionEvents()
        showErrorMsg()
    }
    
    open func showErrorMsg() {
        //FIXME: 不存在页面
    }
    
}
