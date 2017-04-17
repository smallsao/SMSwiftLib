//
//  SMTools.swift
//  SMTools
//
//  Created by smallsao on 2016/10/31.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

class SMTools: NSObject {
    
}



/// rgb 转换成颜色
///
/// - parameter rgbValue: rgb
///
/// - returns: color
public func SMRGB(_ rgbValue:UInt) -> UIColor{
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


public func SMRGBA(_ rgbValue:UInt, _ alpha:Float) -> UIColor{
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


/// 根据字号返回字体
///
/// - parameter size: 字体大小
///
/// - returns: font
public func SMFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}


/// 根据字号返回粗体
///
/// - parameter size: 字号大小
///
/// - returns: 字体
public func SMBFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}

