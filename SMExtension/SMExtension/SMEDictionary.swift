//
//  SMEDictionary.swift
//  SMExtension
//
//  Created by smallsao on 2016/10/31.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import Foundation



/// Dictionary
extension Dictionary {
    
    /**
     从字典中获取String类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:32
     
     - parameter key: key
     
     - returns: value
     */
    public func stringValue(key:Key) -> String {
        let value = self[key]
        if value == nil {
            return ""
        }
        else {
            return obj2Str(obj: value as AnyObject)
        }
    }
    
    /**
     从字典中获取Int类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:13
     
     - parameter key: key
     
     - returns: value
     */
    public func intValue(key:Key) -> Int {
        let value:String! = self.stringValue(key:key)
        if value != "" {
            return value.intValue()
        }
        else {
            return 0
        }
    }
    
    
    /**
     从字典中获取Array类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:20
     
     - parameter key: key
     
     - returns: value
     */
    public func arrayValue(key:Key) -> Array<AnyObject> {
        let value = self[key]
        if value == nil {
            return Array()
        }
        else if value is Array<AnyObject> {
            return value as! Array<AnyObject>;
        }
        else {
            return Array()
        }
    }
    
    /**
     从字典中获取Dictionary类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:39
     
     - parameter key: key
     
     - returns: value
     */
    public func dictionaryValue(key:Key) -> Dictionary {
        let value = self[key]
        if value == nil {
            return Dictionary()
        }
        else if value is Dictionary {
            return value as! Dictionary
        }
        else {
            return Dictionary()
        }
    }
    
    /**
     从字典中获取Float类型的value
     
     - author: smallsao
     - date: 16-07-13 13:07:02
     
     - parameter key: key
     
     - returns: value
     */
    public func floatValue(key:Key) -> Float {
        let value:String! = self.stringValue(key: key)
        if value != "" {
            return value.floatValue()
        }
        else {
            return 0.0
        }
    }
    
    /**
     从字典中获取Double类型的数据
     
     - author: smallsao
     - date: 16-07-13 13:07:18
     
     - parameter key: key
     
     - returns: value
     */
    public func doubleValue(key:Key) -> Double {
        let value:String! = self.stringValue(key: key)
        if value != "" {
            return value.doubleValue()
        }
        else {
            return 0.0
        }
    }
    
    /**
     从字典中获取Bool类型的数据
     
     - author: smallsao
     - date: 16-07-13 13:07:28
     
     - parameter key: key
     
     - returns: value
     */
    public func boolValue(key:Key) -> Bool {
        if self.intValue(key: key) > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    public mutating func add(fromDictionary: Dictionary){
        for (key, value) in fromDictionary {
            self[key] = value
        }
    }
}
