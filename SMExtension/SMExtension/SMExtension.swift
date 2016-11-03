//
//  SMCommonUtil.swift
//  SMCommonUtil
//
//  Created by smallsao on 16/7/13.
//

import Foundation
import UIKit







/**
 AnyObject to String
 
 - author: smallsao
 - date: 16-07-19 15:07:20
 
 - parameter obj: AnyObject
 
 - returns: String
 */
public func obj2Str(obj: AnyObject) -> String {
    if obj is String {
        return obj as! String;
    }
    else if obj is Int {
        return String(obj as! Int)
    }
    else if obj is Float {
        return String(obj as! Float)
    }
    else if obj is Double {
        return String(obj as! Double)
    }
    else if obj is Array<AnyObject>{
        let array = obj as! Array<AnyObject>
        let k:String = array.description
        return k
    }
    else {
        return obj.description
    }
}


