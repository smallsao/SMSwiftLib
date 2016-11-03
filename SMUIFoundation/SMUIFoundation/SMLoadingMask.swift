//
//  SMLoadingMask.swift
//  SMUIFoundation
//
//  Created by smallsao on 2016/10/31.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit
import SMTools

// loadingMask
let kLoadingMaskBackTag = 11111110
let kLoadingMaskViewTag = 11111111
let kLoadingMaskIndicatorTag = 11111111
let kLoadingMaskLabelTag = 11111112

// loading
let kLoadingIndicatorTag = 22222220

// tip
let kTipMaskViewTag = 33333330
let kTipMaskLabelTag = 33333332

let kMaskModalTag = 7777777

public class SMLoadingMask:NSObject, CAAnimationDelegate {
    
    var animationView:UIView?
    
//    static var standard : SMLoadingMask {
//        struct Static {
//            static let instance : SMLoadingMask = SMLoadingMask()
//        }
//        return Static.instance
//    }
    
    public static func showLoadingMask(pV: UIView?, offsetXY:CGPoint) {
        if let v = pV{
            var tmp = v.viewWithTag(kLoadingMaskBackTag)
            var indicator:UIActivityIndicatorView
            var lbLoading:UILabel
            var vMask:UIView
            
            if let backView = tmp {
                // 已经存在
                
                vMask = backView.viewWithTag(kLoadingMaskViewTag)!
                indicator = vMask.viewWithTag(kLoadingMaskIndicatorTag) as! UIActivityIndicatorView
                lbLoading = vMask.viewWithTag(kLoadingMaskLabelTag) as! UILabel
                
                backView.frame = CGRect(x: 0, y: 0, width: v.width, height: v.height)
                vMask.frame = CGRect(x: (backView.width - 100)/2 + offsetXY.x, y: (backView.height - 100)*0.4, width: 100, height: 100)
                indicator.frame  = CGRect(x: (vMask.width - 34)/2, y: (vMask.height - 34)/2 - 8, width: 34, height: 34)
                lbLoading.frame = CGRect(x: 0, y: indicator.y + 36, width: vMask.width, height: 20)
            }
            else {
                
                tmp = UIView(frame: CGRect(x: 0, y: 0, width: v.width, height: v.height))
                let backView = tmp!
                backView.backgroundColor = UIColor.clear//SMRGBA(0xEAEAEA, 0.4)
                backView.tag = kLoadingMaskBackTag
                backView.layer.zPosition = CGFloat(NSIntegerMax)
                v.addSubview(backView)
                
                // 不存在
                tmp = UIView(frame: CGRect(x: (backView.width - 100)/2 + offsetXY.x, y: (backView.height - 100)*0.4 + offsetXY.y, width: 100, height:100));
                let vMask = tmp!

                vMask.backgroundColor = UIColor.gray
                vMask.tag = kLoadingMaskViewTag;
                vMask.layer.cornerRadius = 10
                backView.addSubview(vMask)
                
                
                indicator = UIActivityIndicatorView(frame: CGRect(x: (vMask.width - 34)/2, y: (vMask.height-34)/2 - 8, width: 34, height: 34))
                indicator.tag = kLoadingMaskIndicatorTag
                vMask.addSubview(indicator)
                indicator.startAnimating()
                
                lbLoading = UILabel(frame: CGRect(x: 0, y: indicator.y + 36, width: vMask.width, height: 20))
                lbLoading.tag = kLoadingMaskLabelTag
                lbLoading.text = "正在加载"
                lbLoading.textAlignment = .center
                lbLoading.textColor = UIColor.white
                lbLoading.font = SMFont(11.5)
                vMask.addSubview(lbLoading)
            }
        }
        
        else {
//            依托view不存在。什么都不干
        }
    }
    
    public static func hideLoadingMask(pV:UIView?) {
        if let v = pV {
            let tmp = v.viewWithTag(kLoadingMaskBackTag)
            if let vBack = tmp {
                DispatchQueue.main.async {
                    vBack.removeFromSuperview()
                }
            }
        }
    }
    
    
    
    public static func showLoading(pV:UIView?) {
        if let v = pV{
            var tmp = v.viewWithTag(kLoadingIndicatorTag)
            
            if let indicator = tmp {
                // indicator存在
                indicator.frame  = CGRect(x: (v.width - 34)/2, y: (v.height - 34)/2 - 8, width: 34, height: 34)
            }
            else {
                tmp = UIActivityIndicatorView(frame: CGRect(x: (v.width - 34)/2, y: (v.height - 34)/2 - 8, width: 34, height: 34))
                let indicator = tmp as! UIActivityIndicatorView
                indicator.tag = kLoadingIndicatorTag
                indicator.color = UIColor.green
                v.addSubview(indicator)
                indicator.startAnimating()
            }
        }
    }
    
    public static func hideLoading(pV:UIView?) {
        if let v = pV {
            let tmp = v.viewWithTag(kLoadingIndicatorTag)
            if let vBack = tmp {
                DispatchQueue.main.async {
                    vBack.removeFromSuperview()
                }
            }
        }
    }

    
    
    public func showTip(pV:UIView?, msg:String?, duration:CGFloat) {
        if let v = pV {
            if let tip = msg {
                
                let ml:CGFloat = 30
                let mt:CGFloat = 25
                let tw:CGFloat = 240 - 2*ml
                let font = SMFont(15)
                
                let size = tip.boundingRect(with: CGSize(width: tw, height:10000), options:  NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size
                
                let width = min(size.width, tw) + 2*ml;
                
                var vMask = UIView()
                var lbMsg = UILabel()
                
                lbMsg.frame = CGRect(x: ml, y: mt, width: min(size.width, tw), height: size.height)
                vMask.frame = CGRect(x: (v.width - width)/2, y: (v.height - size.height - 50)*0.4, width: width, height: size.height + 50)
                
                vMask.layer.backgroundColor = UIColor.black.cgColor
                vMask.layer.opacity = 0.6
                vMask.layer.cornerRadius = 10
                vMask.layer.zPosition = CGFloat(NSIntegerMax)
                vMask.tag = kTipMaskViewTag
                
                lbMsg.backgroundColor = UIColor.clear
                lbMsg.numberOfLines = 0
                lbMsg.text = tip
                lbMsg.font = font
                lbMsg.textColor = UIColor.white
                lbMsg.textAlignment = .center
                vMask.addSubview(lbMsg)
                
                v.addSubview(vMask)
                
                self.animationView = vMask
                SMLoadingMask.showTipAnimation(v: vMask, animationDelegate: self)
                
            }
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let pV = self.animationView {
            pV.removeFromSuperview()
        }
    }
    
    static func showTipAnimation(v:UIView, animationDelegate:CAAnimationDelegate) {
        let basic1 = CABasicAnimation(keyPath: "opacity")
        basic1.fromValue = 0
        basic1.toValue = 1
        basic1.duration = 0.5
        basic1.isRemovedOnCompletion = false
        basic1.fillMode = kCAFillModeForwards
        
        let basic2 = CABasicAnimation(keyPath: "opacity")
        basic2.fromValue = 1
        basic2.toValue = 0
        basic2.duration = 0.5
        basic2.beginTime = 2.5
        basic2.isRemovedOnCompletion = false
        basic2.fillMode = kCAFillModeForwards
        
        let group = CAAnimationGroup()
        group.animations = [basic1,basic2]
        group.delegate = animationDelegate
        group.duration = 3
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        v.layer.add(group, forKey: nil)
        
    }
    
    
//    public func showFadeInOutTipView(pV:UIView?, tip:String, duration:CGFloat) {
//        self.showFadeInOutTipView(pV: pV, tip: tip, offsetXY:CGPoint.zero, duration: duration)
//    }
    
    
//    public func showFadeInOutTipView(pV:UIView?, tip:String, offsetXY:CGPoint, duration:CGFloat) {
//        if let v = pV {
//            var modalView = v.viewWithTag(kMaskModalTag)
//            self.mView = modalView;
//            
//            modalView = SMLoadingMask.toastWithActivityIndicator(showIndicator: false, tip: tip)
//            modalView?.layer.zPosition = CGFloat(NSIntegerMax)
//            modalView?.tag = kMaskModalTag
//            v.addSubview(modalView!)
//            SMLoadingMask.fadeInOutTipView(modalView: modalView!, animationDelegate: self)
//        }
//        else {
//            return ;
//        }
//    }
//    
//    static func toastWithActivityIndicator(showIndicator:Bool, tip:String) -> UIView{
//        let ml:CGFloat = 30
//        let mt:CGFloat = 25
//        let tw:CGFloat = 240 - 2*ml
//        let font = SMFont(15)
//        let size = tip.boundingRect(with: CGSize(width: tw, height:10000), options:  NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size
//        let width:CGFloat = min(size.width, tw) + 2 * ml
//        
//        let modalView = UIView(frame: CGRect.zero)
//        let layer = CALayer()
//        layer.backgroundColor = UIColor.black.cgColor
//        layer.opacity = 0.6
//        layer.cornerRadius = 10
//        modalView.layer.addSublayer(layer)
//        
//        var offsetY = mt
//        
//        if showIndicator {
//            let iw:CGFloat = 22
//            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
//            indicator.center = CGPoint(x: width/2, y: mt+iw/2)
//            modalView.addSubview(indicator)
//            
//            offsetY = offsetY + iw + 10
//        }
//        
//        // tip
//        let label = UILabel(frame: CGRect(x: ml, y: offsetY, width: min(size.width,tw), height: size.height))
//        label.backgroundColor = UIColor.clear
//        label.numberOfLines = 0
//        label.text = tip
//        label.font = font
//        label.textColor = UIColor.white
//        label.textAlignment = .center
//        modalView.addSubview(label)
//        
//        offsetY += CGFloat(ceilf(Float(size.height)))
//        offsetY += mt
//        layer.frame = CGRect(x: 0, y: 0, width: width, height: offsetY)
//        modalView.frame = CGRect(x: 0, y: 0, width: width, height: offsetY)
//        
//        return modalView
//        
//    }
    
    

    
    

    
    
//    CAAnimationDelegate

    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    

    
    
}
