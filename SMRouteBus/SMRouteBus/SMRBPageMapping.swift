//
//  SMRBMapping.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

class SMRBPageMapping: NSObject {
    var pageMapping:Dictionary<String, String>
    
    override init() {
        pageMapping = Dictionary<String, String>()
        super.init()
    }
    
    static var standard : SMRBPageMapping {
        struct Static {
            static let instance : SMRBPageMapping = SMRBPageMapping()
        }
        return Static.instance
    }
    
    func loadPageMapData(pageMapping:Dictionary<String, String>){
        SMRBPageMapping.standard.pageMapping = pageMapping
    }
    
    func isExist(key:String) -> Bool {
        if pageMapping[key] != nil {
            return true
        }
        else {
            return false
        }
    }
    
    func parse(key: String) -> String {
        return pageMapping.stringValue(key: key)
    }

    
}
