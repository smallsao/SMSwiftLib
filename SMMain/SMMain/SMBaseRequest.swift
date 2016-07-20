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
    
    
    override init() {
        self.url = URL(string: "")!
        super.init()
    }

    func assembleParameter() {
        
    }

    func validateParameter() -> Bool{
        return true
        
    }
    
    func parseResponseData(respData: Dictionary<String,AnyObject>) -> AnyObject{
        
        return ""
    }
    
    func handleErrror(error: NSError) {
        
    }
    
    func checkResponseCode(respData:Dictionary<String, AnyObject>) -> NSError {
        
        
        return NSError()
    }
    
    public func sendRequest(success:(AnyObject) -> Void, serviceException:(NSError) -> Void, networkException: (NSError) -> Void ) {
        let rStatus = Reachability().connectionStatus()
        if rStatus.description == ReachabilityStatus.Offline.description || rStatus.description == ReachabilityStatus.Unknown.description {
            //网络不通
            var userInfo = Dictionary<String, AnyObject>()
            userInfo["status"] = ["status_reason":"网络似乎存在问题"]
            let error = NSError(domain: "network not reachable", code: 100000, userInfo: userInfo)
            
            networkException(error)
            
            
            NotificationCenter().post(name: "NOTIFICATION_NETWWORK_NOT_REACHABLE" as NSNotification.Name, object: nil)
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
            let data:NSData = try JSONSerialization.data(withJSONObject: self.params, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = data as Data
        }catch{
            
        }
        request.httpMethod = "POST"

        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        session.dataTask(with: request, completionHandler:{
            (data: Data?, response: URLResponse?, err: NSError?) -> Void in
            var error = err
            if error == nil{
                let rString = String(data: data!, encoding: .utf8)
                print(rString)

                let dict = Dictionary<String, AnyObject>()
                error = self.checkResponseCode(respData: dict as Dictionary<String, AnyObject>)
                if error == nil {
                    serviceException(error!)
                }
                else {
                    let result = self.parseResponseData(respData: dict)
                    if result is NSError {
                        serviceException(result as! NSError)
                    }
                    else {
                        success(result)
                    }
                }
            }
            else {
                networkException(error!)
            }
        }).resume()
//        print(task.state)
//        task.resume()
//        print(task.state)
        
    }
    
    
    
//
}
