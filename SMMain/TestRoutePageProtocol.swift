//
//  SMRoutePageProtocol.swift
//  SMMain
//
//  Created by smallsao on 16/9/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

public protocol TestRoutePageProtocol:NSObjectProtocol {
    func open(pageId:String, params:Dictionary<String, AnyObject>?, complete:()->Void)
    func service(serviceId:String, params:Dictionary<String, AnyObject>, complete:()->Void)
    func message(serviceId:String, source:String, params:Dictionary<String, AnyObject>, complete:()->Void)
}
