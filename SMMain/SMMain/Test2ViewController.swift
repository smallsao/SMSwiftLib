//
//  Test2ViewController.swift
//  SMMain
//
//  Created by smallsao on 16/9/12.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

import SMExtension
import SMUIKit

open class Test2ViewController: SMBaseViewController {

    var button:SMButton?
    
    var label:SMLabel?
    var smView:SMView?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button:SMButton = SMButton(type:.custom)
        button.frame = CGRect.init(x: 20, y: 20, width: 80, height: 80)
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
        label.frame = CGRect.init(x: 120, y: 20, width: 80, height: 80)
        label.backgroundColor = UIColor.green
        label.text = ""
        label.addTarget(self, action: #selector(tappedLabel), for: .touchUpInside)
        self.view.addSubview(label)
        label.addNumberDot(number: "100")
        
        
        
        let smView:SMView = SMView()
        self.view.addSubview(smView)
        smView.frame = CGRect(x: 220, y: 20, width: 80, height: 80)
        smView.backgroundColor = UIColor.yellow
        
        //        smView.addLine(style: .SMBorderStyleLeft, color: UIColor.red(), width: 1, padding: 10)
        //        smView.addBorder(styles: [.SMBorderStyleTop, .SMBorderStyleLeft, .SMBorderStyleRight, .SMBorderStyleBottom], color: UIColor.green(), width: 0.5)
        smView.addDashed(color: UIColor.gray, width: 0.5, space: 1)
        smView.addRedDot()
        
        
        
        self.button = button
        self.label = label
        self.smView = smView
        
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedLabel() {
        self.hideLoadingMask()
//        self.hideToast()
        
        //        self.button?.addNumberDot(number: "但是")
        //        self.label?.addRedDot()
        //        self.smView?.addRedDot()
        
        
//                print("label")
//                let testRequest = TestRequest()
//                testRequest.id = "111"
//                testRequest.name = "smallsao"
//                testRequest.sendRequest(success: {
//                    (data: AnyObject) in
//                    print("   .............  \(data)")
//        
//                    }, serviceException: {
//                        (error: NSError) in
//                        print("   .............  \(error.description)")
//                    }, networkException: {
//                        (error: NSError) in
//        
//                })
    }
    
    func tapped (){
        self.showLoadingMask()
        
        //        self.ArrayExtension()
        //
        //        self.stringExtension()
        //        self.dictExtension()
        //
        //        self.button?.hideRedDot()
        //        self.label?.hideRedDot()
        //        self.smView?.hideRedDot()
        
        //        self.showToast(tip: "ssssss", duration: Float(5.0))
        
        //        self.showLoadingToast()
//        self.showToast(view: self.view as! SMView, tip: "dsfjasldfjl", duration: 10, completion:
//            {
//                () in
//                
//                
//        })
        
    }
    
    func ArrayExtension() {
        let a = [
            "-17",
            "b-17.2aa",
            11,
            "130",
            ["1","2"],
            ["key1":"value1"],
            1.811,
            "22.222",
            0,
            1,
            -1
        ] as [Any]
        print(a.stringValue(index: 1))
        print(a.stringValue(index: 2))
        print(a.stringValue(index: 3))
        print(a.stringValue(index: 4))
        print(a.stringValue(index: 5))
        print(a.stringValue(index: 6))
        print(a.stringValue(index: 7))
        print(a.stringValue(index: 8))
        print(a.stringValue(index: 9))
        print(a.stringValue(index: 10))
        print(a.stringValue(index: 11))
        print(a.stringValue(index: 12))
        
        
    }
    
    func stringExtension() {
        let string = "  ABCDEFGHIJKLMnopqrstuvw  xyz  \n"
        print(string.delWhiteSpace())
        print(string.findString(from:2, to:3))
        print(" 2 \n".isEmpty())
        
        print("   ".isNumber())
        print(" .dsf.".isNumber())
        print(" 000  ".isNumber())
        print("  9.dj  ".isNumber())
        print("  00.0  ".isNumber())
        print("  9.22  ".isNumber())
        print("  9.3.2  ".isNumber())
        print("  932  ".isNumber())
        print("  93.2  ".isNumber())
        print("  0  ".isNumber())
        
        let size = CGSize(width: 10, height: 200)
        let rSize = "asdjflask sadfjaslkdj asdjfalsk".smSize(font: UIFont.systemFont(ofSize: 15), size:size)
        
        print(rSize.width, rSize.height)
        
        
        print("  师大附近路口时dsfadfl123大煞风景  ".chineseWords())
        print("  师大附近路口时dsfadfl123大煞风景s  ".chineseWordsLength())
        
        let k = "  师大附近路口时dsfadfl123大煞风景  ".base64Encode()
        print(k)
        
        print(k.base64Decode())
        
        
    }
    
    func dictExtension (){
        var dict = Dictionary<String, Any>()
        dict = [
            "String":"-17" ,
            "String2":"b-17.2aa",
            "Int":11,
            "IntString":"130",
            "Array":["1","2"],
            "Dictionary":["key1":"value1"],
            "Float":1.811,
            "FloatString":"22.222",
            "BOOL":0,
            "BOOL2":1,
            "BOOL3":-1
            ]
        
        print("\n\n\n=====================  String  =====================\n")
        print("String from String           :    \(dict.stringValue(key: "String"))")
        print("String from String2          :    \(dict.stringValue(key: "String2"))")
        print("String from Int              :    \(dict.stringValue(key: "Int"))")
        print("String from IntString        :    \(dict.stringValue(key: "IntString"))")
        print("String from Array            :    \(dict.stringValue(key: "Array"))")
        print("String from Dictionary       :    \(dict.stringValue(key: "Dictionary"))")
        print("String from Float            :    \(dict.stringValue(key: "Float"))")
        print("String from FloatString      :    \(dict.stringValue(key: "FloatString"))")
        print("String from BOOL             :    \(dict.stringValue(key: "BOOL"))")
        print("String from BOOL2            :    \(dict.stringValue(key: "BOOL2"))")
        print("String from BOOL3            :    \(dict.stringValue(key: "BOOL3"))")
        
        
        
        print("\n\n\n=====================  Int  =====================\n")
        print("Int from String              :    \(dict.intValue(key: "String"))")
        print("Int from String2             :    \(dict.intValue(key: "String2"))")
        print("Int from Int                 :    \(dict.intValue(key: "Int"))")
        print("Int from IntString           :    \(dict.intValue(key: "IntString"))")
        print("Int from Array               :    \(dict.intValue(key: "Array"))")
        print("Int from Dictionary          :    \(dict.intValue(key: "Dictionary"))")
        print("Int from Float               :    \(dict.intValue(key: "Float"))")
        print("Int from FloatString         :    \(dict.intValue(key: "FloatString"))")
        print("Int from BOOL                :    \(dict.intValue(key: "BOOL"))")
        print("Int from BOOL2               :    \(dict.intValue(key: "BOOL2"))")
        print("Int from BOOL3               :    \(dict.intValue(key: "BOOL3"))")
        
        print("\n\n\n=====================  Array  =====================\n")
        print("Array from String            :    \(dict.arrayValue(key: "String"))")
        print("Array from String2           :    \(dict.arrayValue(key: "String2"))")
        print("Array from Int               :    \(dict.arrayValue(key: "Int"))")
        print("Array from IntString         :    \(dict.arrayValue(key: "IntString"))")
        print("Array from Array             :    \(dict.arrayValue(key: "Array"))")
        print("Array from Dictionary        :    \(dict.arrayValue(key: "Dictionary"))")
        print("Array from Float             :    \(dict.arrayValue(key: "Float"))")
        print("Array from FloatString       :    \(dict.arrayValue(key: "FloatString"))")
        print("Array from BOOL              :    \(dict.arrayValue(key: "BOOL"))")
        print("Array from BOOL2             :    \(dict.arrayValue(key: "BOOL2"))")
        print("Array from BOOL3             :    \(dict.arrayValue(key: "BOOL3"))")
        
        
        print("\n\n\n=====================  Dictionary  =====================\n")
        print("Dictionary from String       :    \(dict.dictionaryValue(key: "String"))")
        print("Dictionary from String2      :    \(dict.dictionaryValue(key: "String2"))")
        print("Dictionary from Int          :    \(dict.dictionaryValue(key: "Int"))")
        print("Dictionary from IntString    :    \(dict.dictionaryValue(key: "IntString"))")
        print("Dictionary from Array        :    \(dict.dictionaryValue(key: "Array"))")
        print("Dictionary from Dictionary   :    \(dict.dictionaryValue(key: "Dictionary"))")
        print("Dictionary from Float        :    \(dict.dictionaryValue(key: "Float"))")
        print("Dictionary from FloatString  :    \(dict.dictionaryValue(key: "FloatString"))")
        print("Dictionary from BOOL         :    \(dict.dictionaryValue(key: "BOOL"))")
        print("Dictionary from BOOL2        :    \(dict.dictionaryValue(key: "BOOL2"))")
        print("Dictionary from BOOL3        :    \(dict.dictionaryValue(key: "BOOL3"))")
        
        
        print("\n\n\n=====================  Float  =====================\n")
        print("Float from String            :    \(dict.floatValue(key: "String"))")
        print("Float from String2           :    \(dict.floatValue(key: "String2"))")
        print("Float from Int               :    \(dict.floatValue(key: "Int"))")
        print("Float from IntString         :    \(dict.floatValue(key: "IntString"))")
        print("Float from Array             :    \(dict.floatValue(key: "Array"))")
        print("Float from Dictionary        :    \(dict.floatValue(key: "Dictionary"))")
        print("Float from Float             :    \(dict.floatValue(key: "Float"))")
        print("Float from FloatString       :    \(dict.floatValue(key: "FloatString"))")
        print("Float from BOOL              :    \(dict.floatValue(key: "BOOL"))")
        print("Float from BOOL2             :    \(dict.floatValue(key: "BOOL2"))")
        print("Float from BOOL3             :    \(dict.floatValue(key: "BOOL3"))")
        
        
        print("\n\n\n=====================  Double  =====================\n")
        print("Double from String            :    \(dict.doubleValue(key: "String"))")
        print("Double from String2           :    \(dict.doubleValue(key: "String2"))")
        print("Double from Int               :    \(dict.doubleValue(key: "Int"))")
        print("Double from IntString         :    \(dict.doubleValue(key: "IntString"))")
        print("Double from Array             :    \(dict.doubleValue(key: "Array"))")
        print("Double from Dictionary        :    \(dict.doubleValue(key: "Dictionary"))")
        print("Double from Float             :    \(dict.doubleValue(key: "Float"))")
        print("Double from FloatString       :    \(dict.doubleValue(key: "FloatString"))")
        print("Double from BOOL              :    \(dict.doubleValue(key: "BOOL"))")
        print("Double from BOOL2             :    \(dict.doubleValue(key: "BOOL2"))")
        print("Double from BOOL3             :    \(dict.doubleValue(key: "BOOL3"))")
        
        
        print("\n\n\n=====================  BOOL  =====================\n")
        print("BOOL from String            :    \(dict.boolValue(key: "String"))")
        print("BOOL from String2           :    \(dict.boolValue(key: "String2"))")
        print("BOOL from Int               :    \(dict.boolValue(key: "Int"))")
        print("BOOL from IntString         :    \(dict.boolValue(key: "IntString"))")
        print("BOOL from Array             :    \(dict.boolValue(key: "Array"))")
        print("BOOL from Dictionary        :    \(dict.boolValue(key: "Dictionary"))")
        print("BOOL from Float             :    \(dict.boolValue(key: "Float"))")
        print("BOOL from FloatString       :    \(dict.boolValue(key: "FloatString"))")
        print("BOOL from BOOL              :    \(dict.boolValue(key: "BOOL"))")
        print("BOOL from BOOL2             :    \(dict.boolValue(key: "BOOL2"))")
        print("BOOL from BOOL3             :    \(dict.boolValue(key: "BOOL3"))")
        
    }
    
}
