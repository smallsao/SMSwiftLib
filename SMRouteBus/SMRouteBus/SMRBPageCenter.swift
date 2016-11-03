//
//  SMPageCenter.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

public class SMRBPageCenter: NSObject {
    
    var pageMapping:Dictionary<String, String> = [:]
    
    static var standard : SMRBPageCenter {
        struct Static {
            static let instance : SMRBPageCenter = SMRBPageCenter()
        }
        
        
//        Static.instance.configMapData()
        
        return Static.instance
    }
    
    public func open(url: String) {
        self.open(url: url, params: nil, animated:true, complete: nil)
    }
    
    public func open(url: String, animated: Bool) {
        self.open(url: url, params: nil, animated:animated, complete: nil)
    }
    
    public func open(url: String, params:Dictionary<String, AnyObject>) {
        self.open(url: url, params: params, animated:true, complete: nil)
    }
    
    public func open(url: String, params: Dictionary<String, AnyObject>, animated: Bool) {
        self.open(url: url, params: params, animated:animated, complete: nil)
    }
    
    public func open(url:String, params:Dictionary<String, AnyObject>?, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        self.open(url: url, params: params, animated:true, complete: complete)
    }
    
    public func open(url:String, params:Dictionary<String, AnyObject>?, animated: Bool, complete:((_ fromViewController:UIViewController, _ toViewController:UIViewController)->Void)?) {
        
        
        /**
        url -> url
        http:// -> http://
        
        url -> classname
        http:// -> cn
        
        pageid -> url
        page:// -> http://
        
        pageid -> classname
        page:// -> cn
        **/

        // 先解析url， 去除URL中的？以后的数据，或者直接url
        let urlModel = SMRBUrl.parse(aUrl: url, aParams: params)
        if let model = urlModel {
            // 只接受有前缀，并且前缀为 page、http、https的协议
            // 1. 查找model.url 是否在字典表中有转义
            var original = ""
            if "page" == model.scheme {
                let pageMap = pageMapping[model.host]
                if let k = pageMap {
                    original = k
                }
                else {
                    print("page not found: \(url)")
                    return
                }
            }
            else if "http" == model.scheme || "https" == model.scheme {
                let pageMap = pageMapping[model.url]
                if let k = pageMap {
                    original = k
                }
                else {
                    original = model.url
                }
            }
            else {
                // 其他不予考虑
                print("page ignore: \(url)")
                return
            }
            
            // 对 original 进行处理
            
            
        }
        else {
            // url 为空
            print("page is empty: \(url)")
            return
        }
        
    }
    
    
    
}
