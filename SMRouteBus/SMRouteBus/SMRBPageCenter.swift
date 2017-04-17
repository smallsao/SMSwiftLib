//
//  SMPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit

public class SMRBPageCenter: SMBaseCenter {
    
    var pageMapping = SMRBPageMapping()
    
    
    public func loadPageMapping(pageMapping:Dictionary<String,String>) {
        self.pageMapping.loadPageMapData(pageMapping: pageMapping)
    }
    
    public func open(url: String) {
        self.open(url: url, params: nil, animated:true, complete: nil)
    }
    
    public func open(url: String, animated: Bool) {
        self.open(url: url, params: nil, animated:animated, complete: nil)
    }
    
    public func open(url: String, params:Dictionary<String, AnyObject>) {
        self.open(url: url, params: params, animated:true, complete: nil)
    }
    
    public func open(url: String, params: Dictionary<String, AnyObject>, animated: Bool) {
        self.open(url: url, params: params, animated:animated, complete: nil)
    }
    
    public func open(url:String, params:Dictionary<String, AnyObject>?, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        self.open(url: url, params: params, animated:true, complete: complete)
    }
    
    public func open(url:String, params:Dictionary<String, AnyObject>?, animated: Bool, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        
        
        let rbPage = SMRBPage.parse(aUrl: url, aParams: params)
        let fromVC = self.currentViewController()
        
        if let toVC = self.createViewController(vcType: rbPage.urlType, aUrl: rbPage.url) {
            if toVC is SMBaseViewController {
                (toVC as! SMBaseViewController).receiveRoute(data: params)
            }
            if toVC is SMBaseViewController {
                (toVC as! SMBaseViewController).receiveRoute(data: params)
            }
            self.navigationController().pushViewController(toVC, animated: animated)
            
            if complete != nil {
                complete!(fromVC,toVC)
            }
        }
        else {
            self.classNotFound()
        }
        
    }
    
}
