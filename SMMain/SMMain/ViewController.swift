//
//  ViewController.swift
//  SMMain
//
//  Created by smallsao on 16/7/13.
//  Copyright © 2016 smallsao. All rights reserved.
//

import UIKit

import SMExtension
import SMUIKit
import SMRouteBus

class ViewController: SMBaseViewController {
    
    var a:String?


    override func viewDidLoad() {
        super.viewDidLoad()
//        SMRoute.standard.route(pageId: "page://xxxx", params: Dictionary<String, AnyObject>())
        
        
        
        
        let button:SMButton = SMButton(type:.custom)
        button.frame = CGRect.init(x: 20, y: 100, width: 80, height: 80)
        button.setTitle("按钮", for:UIControlState.normal)
        self.view.addSubview(button);
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self,action:#selector(tapped),for:.touchUpInside)
        button.setBackgroundColor(UIColor.yellow, for: .normal)
        button.setBackgroundColor(UIColor.blue, for: .highlighted)
        
        button.setImage(UIImage.init(named: "remove_item"), for: .normal)
        button.centerVImageAndTitle(space: 10)
        button.addNumberDot(number: "48")
        
        let label:SMLabel = SMLabel()
        label.frame = CGRect.init(x: 120, y: 100, width: 80, height: 80)
        label.backgroundColor = UIColor.green
        label.text = ""
        label.addTarget(self, action: #selector(tappedLabel), for: .touchUpInside)
        self.view.addSubview(label)
        label.addNumberDot(number: "100")
        
        self.view.addSubview(button)
        self.view.addSubview(label)
        
        
        let pp = SMViewController()
        pp.hhh = 1
        
        
    }

    
    func tapped() {
        self.showTip()
        let testRequest = TestRequest()
        testRequest.id = "111"
        testRequest.name = "smallsao"
        
        testRequest.sendRequest(success: {
            (data: AnyObject) in
            self.hideLoading()
            
        }, serviceException: {
            (error: Error) in
            self.hideLoading()
            
        }, networkException: {
            (error: Error) in
            self.hideLoading()
            
        })
        
//        testRequest.sendRequest(success: {
//            (data: AnyObject) in
//            print("   .............  \(data)")
//            self.hideLoadingMask()
//
//            
//        }, serviceException: {
//            (error: NSError) in
//            print("   .............  \(error.description)")
//        } as! (Error) -> Void,
//        
//        networkException: {
//            (error: NSError) in
//            
//        } as! (Error) -> Void)
//    }
    }


    func tappedLabel() {
        
    }

}



@objc protocol HttpRequestDelegate {
    // @optional 说明这个代理方法是可选方法，
    @objc optional func requestFinished(request: HttpRequestDelegate!, downloadData: NSMutableData!)

}






