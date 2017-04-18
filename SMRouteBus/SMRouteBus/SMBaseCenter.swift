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


/// 基础中心
public class SMBaseCenter: NSObject {
    /// 当前Navigation
    public var navigation:UINavigationController = UINavigationController()
    
    
    /// 当前ViewController
    ///
    /// - Returns: ViewController
    public func currentViewController() -> UIViewController {
        return self.navigationController().topViewController!
    }
    
    
    /// 当前导航
    ///
    /// - Returns: NavigationController
    public func navigationController() -> UINavigationController {
        return self.navigation
    }
    
    
    /// 创建ViewController
    ///
    /// - Parameters:
    ///   - viewControllerType: vcType
    ///   - aUrl: url
    /// - Returns: ViewController
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
    
    
    /// 字符串转换成Class
    ///
    /// - Parameter className: 字符串
    /// - Returns: Class
    func convert(className:String) -> AnyClass? {
        return NSClassFromString(className)
    }
    
    
    /// 没有查找到相关类
    public func classNotFound(){
        UIApplication.shared.endIgnoringInteractionEvents()
        showErrorMsg()
    }
    
    
    /// 提示错误
    open func showErrorMsg() {
        //FIXME: 不存在页面
    }
    
}
