//
//  SMRBMapping.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

/// page关系映射
class SMRBPageMapping: NSObject {
    
    /// page映射
    var pageMapping:Dictionary<String, String>
    
    override init() {
        pageMapping = Dictionary<String, String>()
        super.init()
    }
    
    
    /// 单例
    static var standard : SMRBPageMapping {
        struct Static {
            static let instance : SMRBPageMapping = SMRBPageMapping()
        }
        return Static.instance
    }
    
    
    /// 装载页面映射
    ///
    /// - Parameter pageMapping: 映射信息
    func loadPageMapData(pageMapping:Dictionary<String, String>){
        SMRBPageMapping.standard.pageMapping = pageMapping
    }
    
    
    /// 页面是否被支持
    ///
    /// - Parameter key: key
    /// - Returns: 是否存在
    func isExist(key:String) -> Bool {
        if pageMapping[key] != nil {
            return true
        }
        else {
            return false
        }
    }
    
    
    /// 根据id查找pageurl
    ///
    /// - Parameter key: id
    /// - Returns: 页面url
    func parse(key: String) -> String {
        return pageMapping.stringValue(key: key)
    }

    
}
