//
//  TestRBServiceCenter.swift
//  SMMain
//
//  Created by smallsao on 2017/4/18.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import Foundation
import SMRouteBus

class TestRBServiceCenter: NSObject, SMRBServiceMappingDataSource {
    @objc func loadMapData() -> Dictionary<String, String> {
        return ["1":"SERVICE::SMMain.Test3ViewController??k=a&p=2",
                "2":"SERVICE::SMMain.Test3ViewController",
                "3":"SERVICE::SMMain.Test3ViewController",
        ]
    }
}
