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
typealias kkBlock = (String) -> Void


class ViewController: SMBaseViewController {
    
    var a:String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button:SMButton = SMButton(type:.custom)
        button.frame = CGRect(x: 20, y: 100, width: 80, height: 80)
        button.setTitle("按钮", for:UIControlState.normal)
        self.view.addSubview(button);
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self,action:#selector(tapped),for:.touchUpInside)
        button.setBackgroundColor(UIColor.yellow, for: .normal)
        button.setBackgroundColor(UIColor.blue, for: .highlighted)
        
        button.setImage(UIImage(named: "remove_item"), for: .normal)
        button.centerVImageAndTitle(space: 10)
        button.addNumberDot(number: "48")
        
        let label:SMLabel = SMLabel()
        label.frame = CGRect(x: 120, y: 100, width: 80, height: 80)
        label.backgroundColor = UIColor.green
        label.text = ""
        label.addTarget(self, action: #selector(tappedLabel), for: .touchUpInside)
        self.view.addSubview(label)
        label.addNumberDot(number: "100")
        
        let label1:SMLabel = SMLabel()
        label1.frame = CGRect(x: 220, y: 100, width: 80, height: 80)
        label1.backgroundColor = UIColor.green
        label1.text = ""
        label1.addTarget(self, action: #selector(tappedLabel1), for: .touchUpInside)
        self.view.addSubview(label1)
        label1.addNumberDot(number: "10")
        
        let label2:SMLabel = SMLabel()
        label2.frame = CGRect(x: 320, y: 100, width: 80, height: 80)
        label2.backgroundColor = UIColor.green
        label2.text = ""
        label2.addTarget(self, action: #selector(tappedLabel2), for: .touchUpInside)
        self.view.addSubview(label2)
        label2.addNumberDot(number: "2")
        
        self.view.addSubview(button)
        
        
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

    func service_getSystemInfo(_ data:NSDictionary,completion: @escaping (Dictionary<String, Any>) -> ()) {
        let res:Dictionary<String,Any> = ["1":"2","a":"B"]
        completion(res)
    }
    func tappedLabel1() {
        SMRoute.standard.pageCenter.open(url: "2")
    }
    
    func tappedLabel2() {
        SMRoute.standard.pageCenter.open(url: "3")
    }
    
    func tappedLabel() {
        SMRoute.standard.pageCenter.open(url:"1")

        
        let service_command = String(format: "service_xx:completion:")
        let selector : Selector = Selector(service_command)
        if self.responds(to: selector) {
            typealias swiftBlock = (Dictionary<String, Any>) ->Void
//            let xxx : swiftBlock = {(result) in
//                print("\(result)")
//            }
            
//            let resultBlock = {(result: Dictionary<String, Any>) in
//                print("\(result)")
//            }
            let kk:kkBlock = {
                (st:String) in
                print(st)
            }
            
//            let pp = {
//                () in
//                print("aaa")
//            }
            let map = ["ss":kk]
            
            
//            self.perform(selector, with: false, with: map)
            
            self.perform(#selector(service_xx(_:completion:)), with: 1, with: map)
        }
    }
    func ppaa(_ dat:String) {
        print("ppaa")
    }
    func service_xx(_ data:Int, completion:Dictionary<String, Any>) {
        print(data)
        (completion["ss"] as! kkBlock)("ssdhsafdhasdjks")
    }

}



@objc protocol HttpRequestDelegate {
    // @optional 说明这个代理方法是可选方法，
    @objc optional func requestFinished(request: HttpRequestDelegate!, downloadData: NSMutableData!)

}




class A {
    func f1() {
        
    }
}

class B: A {
    func f2() {
        
    }
}

class C: B {
    override func f1() {
        
    }
}




