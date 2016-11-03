//
//  SMButton.swift
//  SMUIKit
//
//  Created by smallsao on 16/7/19.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


extension UIButton {
    /**
     按钮文字跟图片上下居中
     
     - author: smallsao
     - date: 16-07-20 16:07:49
     
     - parameter space: 图片跟按钮间距
     */
    public func centerVImageAndTitle(space:CGFloat) {
        let padding = max(space, 0.0)
        let imageSize = (self.imageView?.frame.size)!
        var titleSize = CGSize.zero
        
        titleSize = (self.titleLabel?.frame.size)!
        
        let totalHeight = imageSize.height + titleSize.height + CGFloat(padding)
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0, 0, -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsetsMake(-6, -imageSize.width, -(totalHeight - titleSize.height), 0)
        
    }
    
    /**
     按钮文字与图片左右居中
     
     - author: smallsao
     - date: 16-07-20 16:07:25
     
     - parameter space: 图片与按钮间隔
     */
    public func centerHImageAndTitle(space:CGFloat) {
        let padding = max(space, 0.0)
        
        let imageSize = (self.imageView?.frame.size)!
        var titleSize = (self.titleLabel?.frame.size)!

        self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width - space / 2, 0, 0)
        self.imageView?.backgroundColor = UIColor.yellow
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, imageSize.width + space / 2, 0, 0)
        self.titleLabel?.backgroundColor = UIColor.red
    }
    
    // about image from url
    
}

public class SMButton: UIButton {
    /**
     根据UIControlState控制按钮背景颜色
     
     - author: smallsao
     - date: 16-07-20 16:07:54
     
     - parameter color: 颜色
     - parameter state: status
     */
    public func setBackgroundColor(_ color: UIColor?, for state: UIControlState) {
        let bounds = self.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, self.layer.contentsScale)
        let ctx = UIGraphicsGetCurrentContext()
        color?.setFill()
        ctx!.fill(bounds);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(image, for: state)
    }
}
