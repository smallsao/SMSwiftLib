//
//  SMRBServiceMapping.swift
//  SMRouteBus
//
//  Created by smallsao on 2017/4/18.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit

class SMRBServiceMapping: NSObject {
    
    var serviceMapping:Dictionary<String, String>
    
    override init() {
        serviceMapping = Dictionary<String,String>()
        super.init()
    }
    
    static var standard:SMRBServiceMapping {
        struct Static {
            static let instance:SMRBServiceMapping = SMRBServiceMapping()
        }
        return Static.instance
    }
    
    func loadServiceMapData(serviceMapping:Dictionary<String,String>) {
        SMRBServiceMapping.standard.serviceMapping = serviceMapping
    }
    
    func isExist(key:String) -> Bool {
        if serviceMapping.stringValue(key: key) != "" {
            return true
        }
        else {
            return false
        }
    }
    
    func parse(key:String) -> String {
        return serviceMapping.stringValue(key: key)
    }
}
