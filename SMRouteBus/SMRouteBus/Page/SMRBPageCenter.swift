//
//  SMPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit

/// 页面管理中心
public class SMRBPageCenter: SMBaseCenter {
    private var pages:Array<SMRBPage> = Array<SMRBPage>()

    /// page映射表
    var pageMapping = SMRBPageMapping()
    
    
    /// 加载page映射表
    ///
    /// - Parameter pageMapping: 映射表
    public func loadPageMapping(pageMapping:Dictionary<String,String>) {
        self.pageMapping.loadPageMapData(pageMapping: pageMapping)
    }
    
    //MARK: open
    /// 打开页面
    ///
    /// - Parameter url: 页面url
    public func open(url: String) {
        self.open(url: url, params: nil, animated:true, complete: nil)
    }
    
    
    /// 打开页面
    ///
    /// - Parameters:
    ///   - url: 页面url
    ///   - animated: 是否需要动画
    public func open(url: String, animated: Bool) {
        self.open(url: url, params: nil, animated:animated, complete: nil)
    }
    
    
    /// 打开页面
    ///
    /// - Parameters:
    ///   - url: 页面url
    ///   - params: 参数
    public func open(url: String, params:Dictionary<String, AnyObject>) {
        self.open(url: url, params: params, animated:true, complete: nil)
    }
    
    
    /// 打开页面
    ///
    /// - Parameters:
    ///   - url: 页面url
    ///   - params: 参数
    ///   - animated: 是否需要动画
    public func open(url: String, params: Dictionary<String, AnyObject>, animated: Bool) {
        self.open(url: url, params: params, animated:animated, complete: nil)
    }
    
    
    /// 打开页面
    ///
    /// - Parameters:
    ///   - url: 页面地址
    ///   - params: 参数
    ///   - complete: 结束回调block
    public func open(url:String, params:Dictionary<String, AnyObject>?, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        self.open(url: url, params: params, animated:true, complete: complete)
    }
    
    
    /// 打开页面
    ///
    /// - Parameters:
    ///   - url: 页面url
    ///   - params: 参数
    ///   - animated: 是否需要动画
    ///   - complete: 结束回调block
    public func open(url:String, params:Dictionary<String, AnyObject>?, animated: Bool, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        
        
        let rbPage = SMRBPage().parse(aUrl: url, aParams: params)
        let fromVC = self.currentViewController()
        
        if let toVC = self.createViewController(vcType: rbPage.urlType, aUrl: rbPage.url) {
            rbPage.viewController = toVC
            rbPage.addr = Unmanaged.passUnretained(toVC).toOpaque().debugDescription
            
            self.pages.append(rbPage)
            
            
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
    
    
    //MARK: close
    
    /// 关闭
    public func close() {
        close(animate: true)
    }
    
    
    /// 带动画关闭
    ///
    /// - Parameter animate: 动画
    public func close(animate:Bool) {
        if self.pages.count > 0 {
            self.pages.removeLast()
            self.navigationController().popViewController(animated: animate)
        }
    }
    
    
    
    /// 关闭至
    ///
    /// - Parameter 
    ///     - byPUrl: 地址
    public func close(byPUrl:String) {
        close(byPUrl: byPUrl, animated: true)
    }
    
    
    /// 关闭至
    ///
    /// - Parameters:
    ///   - byPUrl: 地址
    ///   - animated: 动画
    public func close(byPUrl:String, animated:Bool) {
        let rbPage = SMRBPage().parse(aUrl: byPUrl, aParams: nil)
        var count = 0
        var isFindPage:Bool = false
        for (_, page) in self.pages.enumerated().reversed() {
            if rbPage.equal(page: page) {
                // 到这儿
                isFindPage = true
                self.navigationController().popToViewController(page.viewController, animated: animated)
            }
            
            count += 1;
        }
        if isFindPage {
            self.pages.removeLast(self.pages.count - count - 1)
        }
    }
    
    
    
    /// 关闭至
    ///
    /// - Parameter byAddr: 内存地址
    public func close(byAddr:String) {
        close(byAddr: byAddr, animated: true)
    }
    
    
    /// 关闭至
    ///
    /// - Parameters:
    ///   - byAddr: 内存地址
    ///   - animated: 动画
    public func close(byAddr:String, animated:Bool) {
        var count = 0
        var isFindPage:Bool = false
        for (_, page) in self.pages.enumerated().reversed() {
            if page.addr == byAddr {
                // 到这儿
                isFindPage = true
                self.navigationController().popToViewController(page.viewController, animated: animated)
            }
            
            count += 1;
        }
        if isFindPage {
            self.pages.removeLast(self.pages.count - count - 1)
        }
    }
    
    
    /// 关闭至
    ///
    /// - Parameter byIndex: 位置
    public func close(byIndex:Int) {
        close(byCount: byIndex, animated: true)
    }
    
    /// 关闭至
    ///
    /// - Parameters:
    ///   - byIndex: 位置
    ///   - animated: 动画
    public func close(byIndex:Int, animated:Bool) {
        if byIndex < self.pages.count && byIndex > 0 && self.pages.count - byIndex - 1 > 0  {
            let rbPage = self.pages[byIndex]
            self.pages.removeLast(self.pages.count - byIndex - 1)
            self.navigationController().popToViewController(rbPage.viewController, animated: animated)
        }
    }
    
    
    /// 关闭最后几个
    ///
    /// - Parameter byCount: 个数
    public func close(byCount:Int) {
        close(byCount:byCount, animated:true)
    }
    
    
    /// 关闭最后价格
    ///
    /// - Parameters:
    ///   - byCount: 个数
    ///   - animated: 是否需要动画
    public func close(byCount:Int, animated:Bool) {
        if byCount < self.pages.count && byCount > 0{
            let rbPage = self.pages[self.pages.count - byCount - 1]
            self.pages.removeLast(byCount)
            self.navigationController().popToViewController(rbPage.viewController, animated: animated)
        }
    }
    
    
    /// 关闭至锚点
    public func closeToAnchor() {
        closeToAnchor(animated:true)
    }
    
    
    /// 关闭至锚点
    ///
    /// - Parameter animated: 动画
    public func closeToAnchor(animated:Bool) {
        for (index, page) in self.pages.enumerated().reversed() {
            if page.isAnchor && index > 0{
                self.pages.removeLast(index)
                self.navigationController().popToViewController(page.viewController, animated: animated)
            }
        }
    }
    
}
