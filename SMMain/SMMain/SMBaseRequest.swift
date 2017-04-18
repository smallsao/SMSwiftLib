//
//  SMBaseRequest.swift
//  SMMain
//
//  Created by smallsao on 16/7/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import Foundation
import UIKit


public class SMBaseRequest: NSObject, NSURLConnectionDataDelegate {
//    
    var url: URL
    var urlSting: String = ""
    public var params: Dictionary<String, String> = Dictionary()
    
    /**
     初始化
     
     - author: smallsao
     - date: 16-07-20 16:07:53
     
     - returns:
     */
    override init() {
        url = URL(string: "test")!
        super.init()
    }

    /**
     组装数据，组装一些默认值
     
     - author: smallsao
     - date: 16-07-20 16:07:12
     */
    func assembleParameter() {
        
    }
    
    /**
     参数是否合法
     
     - author: smallsao
     - date: 16-07-20 16:07:32
     
     - returns: bool
     */
    func validateParameter() -> Bool{
        return true
        
    }
    
    /**
      解析返回数据
     
     - author: smallsao
     - date: 16-07-20 16:07:03
     
     - parameter respData: 解析数据
     
     - returns: (失败对象，成功数据包)
     */
    func parseResponseData(respData: Dictionary<String,AnyObject>) ->  (error: NSError?, data: AnyObject?){
        
        return (nil,nil)
    }
    
    func handleErrror(error: NSError) {
        
    }
    
    func checkResponseCode(respData:Dictionary<String, AnyObject>) -> NSError {
        
        
        return NSError()
    }
    
    public func sendRequest(success:@escaping (AnyObject) -> Void, serviceException:@escaping (Error) -> Void, networkException: @escaping (Error) -> Void ) {
        let rStatus = Reachability().connectionStatus()
        if rStatus.description == ReachabilityStatus.Offline.description || rStatus.description == ReachabilityStatus.Unknown.description {
            //网络不通
            var userInfo = Dictionary<String, Any>()
            userInfo["status"] = ["status_reason":"网络似乎存在问题"]
            let error = NSError(domain: "network not reachable", code: 100000, userInfo: userInfo)
            
            networkException(error)
            
            
            NotificationCenter.default.post(name: Notification.Name("NOTIFICATION_NETWWORK_NOT_REACHABLE"), object: nil)
            return
        }
        else if !validateParameter() {
            print("not validateParameter ------ \(self.url.absoluteString)  \(self.params.description) ")
            let error = NSError(domain: "domain error", code: -1, userInfo: nil)
            serviceException(error)
            
            return
        }
        else {
            assembleParameter()
        }
        
        if self.params.description.length() > 0{
            
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        do{
            let data:Data = try JSONSerialization.data(withJSONObject: self.params, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = data
        }catch{
            
        }
        request.httpMethod = "POST"

        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request, completionHandler: {
            data, response, err in
            var error = err
            if error == nil {
                let rString = String(data: data!, encoding: .utf8)
                print(rString)
                
                let dict = Dictionary<String, AnyObject>()
                error = self.checkResponseCode(respData: dict as Dictionary<String, AnyObject>)
                if let e = error {
                    serviceException(e)
                }
                else {
                    let (dataErr, rData) = self.parseResponseData(respData: dict)
                    if let de = dataErr {
                        serviceException(de)
                    }
                    else {
                        success(rData!)
                    }
                }
            }
            else {
                networkException(error!)
            }
        }).resume()
    }
    
    
    
//
}
