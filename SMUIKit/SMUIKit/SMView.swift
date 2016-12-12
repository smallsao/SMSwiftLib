//
//  SMView.swift
//  SMUIKit
//
//  Created by smallsao on 16/7/20.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


public enum SMBorderStyle:Int {
    case SMBorderStyleTop = 1
    case SMBorderStyleLeft = 2
    case SMBorderStyleBottom = 3
    case SMBorderStyleRight = 4
}

/**
 红点未读数类型
 
 - author: smallsao
 - date: 16-09-14 18:09:21
 
 - redDot: 红点
 - number: 未读数
 */
public enum SMRedDotType {
    case redDot
    case number
}

extension UIView {
    /// frame.origin.x
    public var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var rect = self.frame
            rect.origin.x = x
            self.frame = rect
        }
    }
    /// frame.origin.y
    public var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var rect = self.frame
            rect.origin.y = y
            self.frame = rect
        }
    }
    
    /// frame.width
    public var width:CGFloat {
        get {
            return self.frame.width
        }
        set {
            var rect = self.frame
            rect.size.width = width
            self.frame = rect
        }
    }
    
    /// frame.height
    public var height:CGFloat {
        get {
            return self.frame.height
        }
        set {
            var rect = self.frame
            rect.size.height = height
            self.frame = rect
        }
    }
    
    /**
     增加框线
     
     - author: smallsao
     - date: 16-09-14 18:09:46
     
     - parameter style:   框线类型
     - parameter color:   颜色
     - parameter width:   大小
     - parameter padding: 偏移
     */
    public func addLine(style: SMBorderStyle, color: UIColor, width: CGFloat, padding:CGFloat) {
        let size = self.bounds.size
        let layer = CALayer()
        layer.backgroundColor = color.cgColor
        
        if style == .SMBorderStyleTop {
            layer.frame = CGRect(x: padding, y: 0, width: size.width - 2*padding, height: width)
        }
        else if style == .SMBorderStyleLeft {
            layer.frame = CGRect(x: 0, y: padding, width: width, height: size.width - 2*padding)
        }
        else if style == .SMBorderStyleBottom {
            layer.frame = CGRect(x: padding, y: size.width - width, width: size.width - 2*padding, height: width)
        }
        else if style == .SMBorderStyleRight {
            layer.frame = CGRect(x: size.width - width, y: padding, width: width, height: size.width - 2*padding)
        
        }
        layer.zPosition = 100
        self.layer.addSublayer(layer)
    }
    
    
    /**
     增加边框
     
     - author: smallsao
     - date: 16-09-14 18:09:46
     
     - parameter styles: 边框类型
     - parameter color:  颜色
     - parameter width:  宽度
     */
    public func addBorder(styles: [SMBorderStyle], color: UIColor, width: CGFloat) {
        for style:SMBorderStyle in styles {
            addLine(style: style, color: color, width: width, padding: 0)
        }
    }
    
    /**
     增加边框虚线
     
     - author: smallsao
     - date: 16-09-14 18:09:20
     
     - parameter color: 颜色
     - parameter width: 宽度
     - parameter space: 间隔
     */
    public func addDashed(color: UIColor, width: CGFloat, space:Float) {
        var border = CAShapeLayer()
        border.strokeColor = color.cgColor
        border.fillColor = nil
        border.path = UIBezierPath(rect: self.bounds).cgPath
        border.frame = self.bounds
        border.lineWidth = width
        border.lineCap = "square"
        let numSpace = NSNumber(value:space)
        border.lineDashPattern = [numSpace,numSpace]
        self.layer.addSublayer(border)
    }

    /**
     增加红点
     
     - author: smallsao
     - date: 16-09-14 18:09:03
     */
    public func addRedDot() {
        var temp = self.viewWithTag(999) as? UILabel
        if temp == nil {
            //不存在redDot 需要创建
            temp = UILabel()
            temp?.tag = 999
            temp?.backgroundColor = UIColor.red
            self.addSubview(temp!)
        }
        else {
            // 已经存在redDot 可以直接使用
        }
        let redDot:UILabel = temp!

        redDot.text = ""
        redDot.isHidden = false
        redDot.frame = CGRect(x: self.width - 6, y: -4, width: 10, height: 10)
        redDot.layer.cornerRadius = 5;
        redDot.clipsToBounds = true
    }
    
    /**
     增加未读数
     
     - author: smallsao
     - date: 16-09-14 18:09:14
     
     - parameter number: 未读数
     */
    public func addNumberDot(number: String) {
        var redDot = self.viewWithTag(999) as? UILabel
        if redDot == nil {
            //不存在redDot 需要创建
            redDot = UILabel()
            redDot?.tag = 999
            redDot?.backgroundColor = UIColor.red
            self.addSubview(redDot!)

        }
        else {
            // 已经存在redDot 可以直接使用
        }
        
        redDot?.text = ""
        redDot?.isHidden = false
        var s = number
        //根据文本计算长度，只显示到99+
        if number.characters.count > 2 {
            s = "99+"
        }
        redDot?.textColor = UIColor.white
        let font = UIFont.systemFont(ofSize: 10)
        
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions(rawValue: 1)
        let rect:CGRect = s.boundingRect(with: CGSize(width: 100, height: 16), options:option, attributes: attributes, context: nil)
        
        var width = rect.width + 8
        if width < 16 {
            width = 16
        }
        redDot?.layer.cornerRadius = 8
        redDot?.clipsToBounds = true
        redDot?.font = font
        redDot?.textAlignment = .center
        redDot?.frame = CGRect(x: self.width - width * 0.6, y: -6, width: width, height: 16)
        
        redDot?.text = s
        self.bringSubview(toFront: redDot!)
        
    }
    
    /**
     隐藏红点
     
     - author: smallsao
     - date: 16-09-14 18:09:30
     */
    public func hideRedDot() {
        let redDot = self.viewWithTag(999)
        if redDot != nil {
            redDot?.isHidden = true
        }
    }
    


}






open class SMView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SMView {
//    public var kkkkkk:String?
//    public var _hhh:String?
//    public var hhh:String? {
//        get {
//            return self._hhh
//        }
//        
//        set {
////            
//            self._hhh = newValue;
//        }
//    }
}
