//
//  SMRBMappingDataSource.swift
//  SMRouteBus
//
//  Created by smallsao on 2017/4/17.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit


/// 页面映射数据源
public protocol SMRBPageMappingDataSource: NSObjectProtocol {
    
    /// 数据装载
    ///
    /// - Returns: 数据源
    func loadMapData() -> Dictionary<String, String>
}


/// 服务映射数据源
public protocol SMRBServiceMappingDataSource: NSObjectProtocol {
    /// 数据装载
    ///
    /// - Returns: 数据源
    func loadMapData() -> Dictionary<String, String>
}


/// 消息映射数据源
public protocol SMRBMessageMappingDataSource: NSObjectProtocol {
    /// 数据装载
    ///
    /// - Returns: 数据源
    func loadMapData() -> Dictionary<String, String>
}
