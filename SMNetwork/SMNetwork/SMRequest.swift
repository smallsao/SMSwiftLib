//
//  SMRequest.swift
//  SMNetwork
//
//  Created by smallsao on 16/7/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import Foundation

public typealias SMRequestSuccessHandle = (URLResponse?, Data?) -> Void
public typealias SMRequestFailureHandle = (URLResponse?, NSError?) -> Void
internal var _requestOperationQueue: OperationQueue?



public class SMRequest: URLRequest {
    public var url:URL
    public var method = "GET"
    public var body: Data?
    public var headers: Dictionary<String, String> = Dictionary()
    public var parameters: Dictionary<String, String> = Dictionary()
    public var successHandler: SMRequestSuccessHandle
    public var failureHandler: SMRequestFailureHandle
    
    public var contentType: String? {
        set {
            headers["Content-Type"] = newValue
        }
        get {
            return headers["Content-Type"]
        }
    }
    
    public var userAgent: String? {
        set {
            headers["User-Agent"] = newValue
        }
        get {
            return headers["User-Agent"]
        }
    }
    
    public var response: URLResponse?
    public lazy var responseData = Data()
    
    internal var connection: NSURLConnection?
    
    public init(url: URL) {
        self.url = url
        self.successHandler = {response, data in}
        self.failureHandler = {response, error in}
    }
    
    
    
}
