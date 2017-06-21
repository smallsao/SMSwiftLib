//
//  SMRBService.swift
//  SMRouteBus
//
//  Created by smallsao on 2017/4/18.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit


public enum SMRBServiceType {
    case None
    case SERVICE
}


class SMRBService: NSObject {
    var name:String
    var params:Dictionary<String,Any>
    
    override init() {
        name = ""
        params = Dictionary<String,AnyObject>()

        super.init()
    }
    
    
    
}


class SMRBServiceTools: NSObject {
    static func parse(aUrl:String, aParam:Dictionary<String, Any>?) -> SMRBService {
        let service = SMRBService()
        if SMRBServiceMapping.standard.isExist(key: aUrl) {
            let dd = SMRBServiceTools.dealService(aUrl:SMRBServiceMapping.standard.parse(key: aUrl))
            service.name = dd.1
            service.params = dd.2
        }
        
        return service
    }
    
    static func dealService(aUrl:String) ->(SMRBServiceType, String, Dictionary<String, Any>) {
        let urlComponents = aUrl.components(separatedBy: "??")
        let url = urlComponents[0]
        
        let components = url.components(separatedBy: "::")
        var scheme:String = ""
        var serviceType:SMRBServiceType = .None
        var host:String = ""
        if components.count == 2 {
            scheme = components[0]
            host = components[1]
            if scheme == "SERVICE" {
                serviceType = .SERVICE
            }
        }
        // 合并参数
        var pp = Dictionary<String, Any>()
        var query = ""
        if urlComponents.count > 1 {
            query = urlComponents[1]
            let params = SMRBServiceTools.urlParams(query: query)
            pp.add(fromDictionary: params)
        }
        
        return (serviceType,host, pp)

    }
    
    static func urlParams(query:String) -> Dictionary<String,Any> {
        var dict = Dictionary<String, AnyObject>()
        
        let records = query.components(separatedBy: CharacterSet(charactersIn: "&"))
        for record:String in records {
            let param = record.components(separatedBy: CharacterSet(charactersIn: "="))
            if param.count == 2 {
                dict[param[0]]  = param[1] as AnyObject?
            }
        }
        return dict
    }
}


extension SMRBService {
    public func equal(service:SMRBService) -> Bool {
        if self.name == service.name {
            return true
        }
        else {
            return false
        }
    }
}
