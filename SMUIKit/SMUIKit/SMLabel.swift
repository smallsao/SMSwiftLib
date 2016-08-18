//
//  SMLabel.swift
//  SMUIKit
//
//  Created by smallsao on 16/7/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//
import Foundation
import UIKit

extension UILabel {
    /**
     给Lable 增加点击事件
     
     - author: smallsao
     - date: 16-07-20 16:07:10
     
     - parameter target:        target
     - parameter action:        selector
     - parameter controlEvents: UIControlEvents
     */
    public func addTarget(_ target: AnyObject?, action: Selector, for controlEvents: UIControlEvents) {
        var control:UIControl? = self.viewWithTag(999) as? UIControl
        if control != nil {
            control?.frame = self.bounds
        }
        else {
            control = UIControl.init(frame: self.bounds)
            control?.tag = 999
            self.addSubview(control!)
        }
        
        self.bringSubview(toFront: control!)
        control?.addTarget(target, action: action, for: controlEvents)
        
        self.isUserInteractionEnabled = true;
    }
}

public class SMLabel: UILabel {

}


