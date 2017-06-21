//
//  SMAutoScrollViewCell.swift
//  SMUIKit
//
//  Created by smallsao on 2017/6/21.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit

open class SMAutoScrollViewCell:UITableViewCell {
    public init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func updateData(data:AnyObject) {
        
    }
}
