//
//  SMRBMapping.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

public class SMRBMapping: NSObject {
    static var standard : SMRBMapping {
        struct Static {
            static let instance : SMRBMapping = SMRBMapping()
        }
        Static.instance.configMapData()
        
        return Static.instance
    }
    
    func configMapData() {
        
    }

    
}
