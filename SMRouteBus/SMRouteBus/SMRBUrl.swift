//
//  SMRBUrl.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


public class SMRBUrlModel{
    var scheme:String = ""
    var host:String = ""
    var url:String = ""
    var originalUrl:String = ""
    var originalClass:String = ""
    var params:Dictionary<String, AnyObject>?

    
}

public class SMRBUrl {
    public static func parse(aUrl: String?, aParams: Dictionary<String, AnyObject>?) -> SMRBUrlModel?{
        if let k = aUrl {
            let urlComponents = k.components(separatedBy: CharacterSet(charactersIn: "?"))
            let url = urlComponents[0]
            
            let components = url.components(separatedBy: CharacterSet(charactersIn: "://"))
            var scheme:String = ""
            var host:String = ""
            if components.count == 2 {
                scheme = components[0]
                host = components[1]
            }
            
            // 合并参数
            var pp = aParams
            var query = ""
            if (pp == nil) {
                pp = Dictionary<String, AnyObject>()
            }
            if urlComponents.count > 1 {
                query = urlComponents[1]
                let params = self.urlParams(query: query)
                pp?.add(fromDictionary: params)
            }
            
            let model = SMRBUrlModel()
            model.scheme = scheme
            model.host = host
            model.url = url
            model.originalUrl = k
            model.params = pp
            
            return model
        }
        else {
            return nil
        }
    }
    
    static func urlParams(query: String) -> Dictionary<String, AnyObject> {
        var dict = Dictionary<String, AnyObject>()
        
        var records = query.components(separatedBy: CharacterSet(charactersIn: "&"))
        for record:String in records {
            let param = record.components(separatedBy: CharacterSet(charactersIn: "="))
            if param.count > 2 {
                dict[param[0]]  = param[1] as AnyObject?
            }
        }
        return dict
    }
}
