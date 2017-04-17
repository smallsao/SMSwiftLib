//
//  SMRouteBusManager.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit



public class SMRoute: NSObject {
    public let pageCenter:SMRBPageCenter
    public var pageMappingDataSource:SMRBPageMappingDataSource?
    public var serviceMappingDataSource:SMRBServiceMappingDataSource?
    public var messageMappingDataSource:SMRBMessageMappingDataSource?
    public var navigation:UINavigationController? {
        willSet {
            self.pageCenter.navigation = newValue!
            self.navigation = newValue!
        }
    }
    
    public static var standard : SMRoute {
        struct Static {
            static let instance : SMRoute = SMRoute()
        }
        return Static.instance
    }
    
    override init() {
        pageCenter = SMRBPageCenter()
        super.init()
    }
    
    
    
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
