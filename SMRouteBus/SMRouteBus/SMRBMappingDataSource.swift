//
//  SMRBMappingDataSource.swift
//  SMRouteBus
//
//  Created by smallsao on 2017/4/17.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit

public protocol SMRBPageMappingDataSource: NSObjectProtocol {
    func loadMapData() -> Dictionary<String, String>
}

public protocol SMRBServiceMappingDataSource: NSObjectProtocol {
    func loadMapData() -> Dictionary<String, String>
}

public protocol SMRBMessageMappingDataSource: NSObjectProtocol {
    func loadMapData() -> Dictionary<String, String>
}
