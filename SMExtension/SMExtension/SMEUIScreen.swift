//
//  SMEUIScreen.swift
//  SMExtension
//
//  Created by smallsao on 2017/6/21.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit

extension UIScreen {
    public func width() -> CGFloat{
        let screenBounds:CGRect = UIScreen.main.bounds
        
        return screenBounds.width
    }
}
