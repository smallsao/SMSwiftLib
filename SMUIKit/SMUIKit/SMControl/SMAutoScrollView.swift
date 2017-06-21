//
//  SMAutoScrollView.swift
//  SMUIKit
//
//  Created by smallsao on 2017/6/20.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit
import Foundation

open class SMAutoScrollView: SMView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView:UIPickerView
    
    open var delegate:SMAutoScrollDelegate?
    
    open var dataSource:SMAutoScrollDataSource?
    
    override public init() {
        pickerView = UIPickerView()
        
        super.init(frame:.zero)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.addSubview(pickerView)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        pickerView.frame = self.bounds
        
        
    }
    
    
    public func reloadData() {
        pickerView.reloadAllComponents()
    }

    
    //// DataSource
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if let sDataSource = dataSource {
            return sDataSource.numberOfComponents(in: self)
        }
        else {
            return 0
        }
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let sDataSource = dataSource {
            return sDataSource.autoScrollView(self, numberOfRowsInComponent: component)
        }
        else {
            return 0
        }
    }
    
    
    ///// Delegate
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:widthForComponent:))) {
                return sDelegate.autoScrollView!(self, widthForComponent: component)
            }
        }
        return 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:rowHeightForComponent:))) {
                return sDelegate.autoScrollView!(self, rowHeightForComponent: component)
            }
        }
        return 0.0
    }
    

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:titleForRow:forComponent:))) {
                return sDelegate.autoScrollView!(self, titleForRow: row, forComponent: component)
            }
        }
        return ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:attributedTitleForRow:forComponent:))) {
                return sDelegate.autoScrollView!(self, attributedTitleForRow: row, forComponent: component)
            }
        }
        return NSAttributedString()
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:viewForRow:forComponent:reusing:))) {
                return sDelegate.autoScrollView!(self, viewForRow: row, forComponent: component, reusing: view)
            }
        }
        return UIView()
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:didSelectRow:inComponent:))) {
                sDelegate.autoScrollView!(self, didSelectRow: row, inComponent: component)
            }
        }
    }
    
    
    deinit {
        
    }
    
}


@objc public protocol SMAutoScrollDataSource : NSObjectProtocol {
    func numberOfComponents(in autoScrollView: SMAutoScrollView) -> Int
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, numberOfRowsInComponent component: Int) -> Int
}

@objc public protocol SMAutoScrollDelegate : NSObjectProtocol {
    @objc optional func autoScrollView(_ autoScrollView: SMAutoScrollView, widthForComponent component: Int) -> CGFloat
    
    @objc optional func autoScrollView(_ autoScrollView: SMAutoScrollView, rowHeightForComponent component: Int) -> CGFloat
    
    @objc optional func autoScrollView(_ autoScrollView: SMAutoScrollView, titleForRow row: Int, forComponent component: Int) -> String?
    
    @objc optional func autoScrollView(_ autoScrollView: SMAutoScrollView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    
    @objc optional func autoScrollView(_ autoScrollView: SMAutoScrollView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    
    @objc optional func autoScrollView(_ autoScrollView: SMAutoScrollView, didSelectRow row: Int, inComponent component: Int)
}


