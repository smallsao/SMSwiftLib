//
//  SMRBServiceCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 2017/4/17.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit

class SMRBServiceCenter: NSObject {
    func service(aUrl:String, aParams:Dictionary<String, AnyObject>, complete:()->Void) {
        let rbService = SMRBServiceTools.parse(aUrl: aUrl, aParam: aParams)
        
    }
}
