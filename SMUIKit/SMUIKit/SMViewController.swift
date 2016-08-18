//
//  SMViewController.swift
//  SMUIKit
//
//  Created by smallsao on 16/8/17.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit
import SMExtension

public class SMViewController: UIViewController,CAAnimationDelegate {
    
    let kLoadingToastViewTag = 8888888
    let kToastViewTag = 9999999
    let kLoadingToastModalTag = 7777777
    
    
    
    var callback:(()->Void )?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    public func showLoadingToast() {
        self.hideLoadingToast()
        
        var loadingToastView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        loadingToastView.layer.zPosition = 100000
        loadingToastView.tag = kLoadingToastViewTag
        self.view .addSubview(loadingToastView)
        
        let isHidden = SMUIKitUtils.currentNavigationController()?.isNavigationBarHidden
        
        var statusFrame = UIApplication.shared().statusBarFrame
        var navBarMaxY = statusFrame.height
        
        if false == isHidden {
            statusFrame = (SMUIKitUtils.currentNavigationController()?.navigationBar.frame)!
            navBarMaxY += statusFrame.maxY
        }
        
        var center = CGPoint(x: self.view.frame.width/2, y: 0)
        var viewHeight = self.view.height
        
        let window = UIApplication.shared().delegate?.window!
        var windowHeight = window?.bounds.height
        
        if viewHeight == windowHeight! - navBarMaxY {
            center.y = viewHeight / 2
        }
        else {
            center.y = viewHeight / 2 - max(navBarMaxY - (windowHeight! - viewHeight), 0)
        }
        
        loadingToastView.center = center
        
        var semi = UIView(frame: CGRect(x: 0, y: 0, width: loadingToastView.width, height: loadingToastView.height))
        semi.backgroundColor = UIColor.black()
        semi.alpha = 0.6
        semi.layer.cornerRadius = 10
        loadingToastView.addSubview(semi)
        
        let offX = (loadingToastView.width - 34) / 2
        let offY = (loadingToastView.height - 34) / 2 - 8
        var indicator = UIActivityIndicatorView(frame: CGRect(x: offX, y: offY, width: 34, height: 34))
        
        let offsetY = indicator.y + 36
        var loadingLabel = SMLabel(frame: CGRect(x: 0, y: offsetY, width: semi.width, height: 20))
        loadingLabel.backgroundColor = UIColor.clear()
        loadingLabel.text = "正在加载"
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = UIColor.white()
        loadingLabel.font = UIFont.systemFont(ofSize:10)
        
        loadingToastView.addSubview(loadingLabel)
        loadingToastView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    public func hideLoadingToast() {
        self.view.viewWithTag(kLoadingToastViewTag)?.removeFromSuperview()
    }
    
    public func showToast(view:SMView, tip:String, duration:Float, completion:()->Void) {
        self.callback = completion
        self.showToast(tip: tip, duration: duration)
    }
    
    public func showToast(tip:String, duration:Float) {
        var toastView = self.view.viewWithTag(kToastViewTag)
        if let k = toastView {
            return
        }
     
        toastView = self.toastWithActivityIndicator(showIndicator: false, tip: tip)
        var toast:SMView = toastView as! SMView
        toast.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        toast.layer.zPosition = 1000000
        toast.tag = kToastViewTag
        self.view.addSubview(toast)
        
        var ba1 = CABasicAnimation(keyPath: "opacity")
        ba1.fromValue = 0.0
        ba1.toValue = 1.0
        ba1.duration = 0.5
        ba1.isRemovedOnCompletion = false;
        ba1.fillMode = kCAFillModeForwards
        
        var ba2 = CABasicAnimation(keyPath: "opacity")
        ba2.fromValue = 1.0
        ba2.toValue = 0.0
        ba1.duration = 0.5
        ba2.beginTime = 2.5
        ba2.isRemovedOnCompletion = false
        ba2.fillMode = kCAFillModeForwards
        
        var baGroup = CAAnimationGroup()
        baGroup.animations = [ba1,ba2]
        baGroup.delegate = self
        baGroup.duration = 3
        baGroup.fillMode = kCAFillModeForwards
        baGroup.isRemovedOnCompletion = false
        
        toast.layer.add(baGroup, forKey: "")
    }
    
    public func hideToast() {
        self.view.viewWithTag(kToastViewTag)?.removeFromSuperview()
    }
    
    func toastWithActivityIndicator(showIndicator:Bool, tip:String) -> SMView! {
        let ml:CGFloat = 30
        let mt:CGFloat = 25
        let tw:CGFloat = 180
        
        let font = UIFont.systemFont(ofSize:15)
        let size = tip.smSize(font: font, size: CGSize(width: tw, height: 10000))
        let width = min(size.width, tw) + 2 * ml
        
        var toast = SMView(frame: .zero)
        
        // 半透明
        var semiLayer = CALayer()
        semiLayer.backgroundColor = UIColor.blue().cgColor
        semiLayer.opacity = 0.6
        semiLayer.cornerRadius = 10
        toast.layer.addSublayer(semiLayer)
        
        var offsetY = mt
        // 菊花
        if showIndicator {
            let indicatorWidth:CGFloat = 22
            
            var indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
            indicator.center = CGPoint(x: width/2, y: mt + indicatorWidth/2)
            toast.addSubview(indicator)
            indicator.startAnimating()
            
            offsetY = indicatorWidth + 10
        }
        
        var label = SMLabel(frame: CGRect(x: ml, y: offsetY, width: min(size.width, tw), height: ceil(size.height)))
        label.backgroundColor = UIColor.clear()
        label.numberOfLines = 0
        label.text = tip
        label.font = font
        label.textColor = UIColor.white()
        label.textAlignment = .center
        toast.addSubview(label)
        
        // update frame
        offsetY = offsetY + ceil(size.height)
        offsetY = offsetY + mt
        semiLayer.frame = CGRect(x: 0, y: 0, width: width, height: offsetY)
        toast.frame = CGRect(x: 0, y: 0, width: width, height: offsetY)
        
        return toast
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim is CAAnimationGroup {
            let av = self.view.viewWithTag(kToastViewTag)
            av?.removeFromSuperview()
        }
//        self.removeModalView()
        if let k = self.callback {
            k()
        }
    }
    
//    func removeModalView() {
//        self.view.viewWithTag(kLoadingToastModalTag)?.removeFromSuperview()
//    }
//
//    public func finishedToast() {
//        
//    }
    
}
