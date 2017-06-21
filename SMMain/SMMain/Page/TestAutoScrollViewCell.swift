//
//  TestAutoScrollViewCell.swift
//  SMMain
//
//  Created by smallsao on 2017/6/21.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit
import SMUIKit
import SMTools

public class TestAutoScrollViewCell: SMAutoScrollViewCell {
    
    
    let ivIcon:UIImageView
    let lbTitle:SMLabel
    let lbDesc:SMLabel
    
    
    public override init(reuseIdentifier: String?) {
        ivIcon = UIImageView()
        lbTitle = SMLabel()
        lbDesc = SMLabel()


        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(ivIcon)
        ivIcon.frame = CGRect(x: 15, y: 15, width: 48, height: 48)
        ivIcon.layer.cornerRadius = 24
        ivIcon.clipsToBounds = true
        
        
        lbTitle.frame = CGRect(x: 78, y: 15, width: UIScreen().width() - 78*2, height: 20)
        lbTitle.textAlignment = .center
        lbTitle.font = SMFont(16)
        self.addSubview(lbTitle)
        
        
        lbDesc.frame = CGRect(x: 78, y: 43, width: UIScreen().width() - 78*2, height: 20)
        lbDesc.textAlignment = .center
        lbDesc.textColor = UIColor.gray
        lbDesc.font = SMFont(12)
        self.addSubview(lbDesc)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override public func updateData(data:AnyObject) {
        let dict = data as! Dictionary<String, String>
        ivIcon.image = UIImage(named: dict["image"]!)
        lbTitle.text = dict["title"]
        lbDesc.text = dict["desc"]
    }

}
