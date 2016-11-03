//
//  SMViewController.swift
//  SMUIKit
//
//  Created by smallsao on 16/8/17.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMExtension
import SMUIFoundation

open class SMViewController: UIViewController,CAAnimationDelegate {
    
    var callback:(()->Void )?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func showLoadingMask() {
        SMLoadingMask.showLoadingMask(pV: self.view, offsetXY: CGPoint(x:0, y:0))
    }
    
    public func hideLoadingMask() {
        SMLoadingMask.hideLoadingMask(pV: self.view)
    }
    
    
    public func showLoading() {
        SMLoadingMask.showLoading(pV: self.view)
    }
    
    public func hideLoading() {
        SMLoadingMask.hideLoading(pV: self.view)
    }
    
    
    
    public func showTip() {
        SMLoadingMask().showTip(pV: self.view, msg: "sadasdad", duration: 5)
    }
    
}
