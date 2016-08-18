//
//  SMUIKitUtils.swift
//  SMUIKit
//
//  Created by smallsao on 16/8/17.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

public class SMUIKitUtils: NSObject {
    public static func currentNavigationController() -> UINavigationController? {
        let keyWindow = UIApplication.shared().delegate?.window!
        let naviCtrl = keyWindow?.rootViewController
        
        if naviCtrl is UINavigationController {
            return naviCtrl as! UINavigationController
        }
        else {
            return nil
        }
    }
}
