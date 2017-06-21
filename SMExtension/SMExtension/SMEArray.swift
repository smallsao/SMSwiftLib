//
//  SMEArray.swift
//  SMExtension
//
//  Created by smallsao on 2016/10/31.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import Foundation


/// Array
extension Array {
    public func stringValue(index:Int) -> String {
        if index < self.count {
            let value = self[index]
            return obj2Str(obj: value as AnyObject)
        }
        else {
            return ""
        }
    }
}


