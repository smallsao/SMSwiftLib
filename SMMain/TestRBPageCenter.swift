//
//  SMRBPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/13.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit
import SMRouteBus

class TestRBPageCenter: NSObject, SMRBPageMappingDataSource{
    @objc func loadMapData() -> Dictionary<String, String> {
        return ["1":"PAGE::SMMain.Test2ViewController??k=a&p=2",
                "2":"HTTP::http://www.weidian.com?fwr=k??k=a&p=2",
                "3":"HTTPS::https://www.weidian.com?fwr=k??k=a&p=2",
                "4":"IMG::https//s.geilicdn.com/official/20174/images/pc/icon/head.cde799ee.png??k=a&p=2"]
    }
}
