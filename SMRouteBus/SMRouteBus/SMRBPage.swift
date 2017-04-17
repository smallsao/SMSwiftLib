//
//  SMRBPage.swift
//  SMRouteBus
//
//  Created by smallsao on 16/9/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


/// 跳转的URL类型
///
/// - HTTP: http
/// - HTTPS: https
/// - PAGE: native page
/// - IMG: img
public enum SMRBPageType {
    case None
    case HTTP
    case HTTPS
    case PAGE
    case IMG
}


public class SMRBPageModel:NSObject{
    var urlType:SMRBPageType
    var url:String
    var originalUrl:String
    var params:Dictionary<String, AnyObject>

    override init() {
        urlType = .None
        url = ""
        originalUrl = ""
        params = Dictionary<String, AnyObject>()
        
    }
}

class SMRBPage {
    
    static func parse(aUrl:String, aParams: Dictionary<String, AnyObject>?) -> SMRBPageModel {
        let model = SMRBPageModel()
        if SMRBPageMapping.standard.isExist(key: aUrl) {
            let dd = SMRBPage.dealUrl(aUrl: SMRBPageMapping.standard.parse(key: aUrl))
            model.urlType = dd.0
            model.url = dd.1
            model.originalUrl = aUrl
            model.params = dd.2
        }
        return model
    }
    
    
    static func dealUrl(aUrl:String) -> (SMRBPageType, String, Dictionary<String, AnyObject>) {
        let urlComponents = aUrl.components(separatedBy: "??")
        let url = urlComponents[0]
        
        let components = url.components(separatedBy: "::")
        var scheme:String = ""
        var pageType:SMRBPageType = .None
        var host:String = ""
        if components.count == 2 {
            scheme = components[0]
            host = components[1]
            if scheme == "PAGE" {
                pageType = .PAGE
            }
            else if scheme == "HTTP" {
                pageType = .HTTP
            }
            else if scheme == "HTTPS" {
                pageType = .HTTPS
            }
            else if scheme == "IMG" {
                pageType = .IMG
            }
            
        }
        // 合并参数
        var pp = Dictionary<String, AnyObject>()
        var query = ""
        if urlComponents.count > 1 {
            query = urlComponents[1]
            let params = self.urlParams(query: query)
            pp.add(fromDictionary: params)
        }
        
        return (pageType, host, pp)

    }
    
    static func urlParams(query: String) -> Dictionary<String, AnyObject> {
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
