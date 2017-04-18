//
//  SMRouteBusManager.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


//Route核心
public class SMRoute: NSObject {
    
    /// 页面中心
    public let pageCenter:SMRBPageCenter
    
    
    /// 页面数据源
    public var pageMappingDataSource:SMRBPageMappingDataSource?
    
    
    /// service数据源
    public var serviceMappingDataSource:SMRBServiceMappingDataSource?
    
    /// 消息数据源
    public var messageMappingDataSource:SMRBMessageMappingDataSource?
    
    
    /// 页面管理器
    public var navigation:UINavigationController? {
        willSet {
            self.pageCenter.navigation = newValue!
            self.navigation = newValue!
        }
    }
    
    
    /// 单例
    public static var standard : SMRoute {
        struct Static {
            static let instance : SMRoute = SMRoute()
        }
        return Static.instance
    }
    
    
    /// 初始化方法
    override init() {
        pageCenter = SMRBPageCenter()
        super.init()
    }
    
    
    
    /// 启动
    public func launch() {
        if let pd = self.pageMappingDataSource {
            let selector = Selector("loadMapData")
            if pd.responds(to: selector) {
                let pageMapping = pd.loadMapData()
                SMRoute.standard.pageCenter.loadPageMapping(pageMapping: pageMapping)
            }
        }
        
    }
}
