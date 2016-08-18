//
//  TestRequest.swift
//  SMMain
//
//  Created by smallsao on 16/7/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import Foundation

public class TestRequest: SMBaseRequest {
    
    public var id: String = ""
    public var name: String = ""
    
    override init() {
        super.init()
        self.urlSting = "http://hangge.com/"
        self.url = URL(string: self.urlSting)!
    }
    
    override func assembleParameter() {
        super.assembleParameter()
        self.params["user"] = self.id
        self.params["score"] = self.name
    }
    

    override func parseResponseData(respData: Dictionary<String, AnyObject>) -> (error: NSError?, data: AnyObject?) {
        
        return (nil,nil)
    }
    
}
