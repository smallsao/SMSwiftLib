//
//  SMTestView.swift
//  SMUIKit
//
//  Created by smallsao on 2016/12/12.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit


class testView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Base {
    var baseName:String
    
    init(baseName:String) {
        self.baseName = baseName
    }
}

class Test:Base {
    var name:String
    
    init(name:String) {
        self.name = name
        super.init(baseName: "")
    }
    
    convenience init(name2:String) {
        self.init(name:name2)
    }
    
}


class exTest1:Test {
    var title:String
    var kk:String?
    
    init(baseName:String) {
        self.title = ""
        super.init(name: "")
    }
    
    init() {
        self.title = ""
        super.init(name: "")
    }
    
    override init(name:String) {
        self.title  = ""
        super.init(name: name)
    }
    
    init(title:String) {
        self.title = title
        super.init(name:"")
    }
    
    
//    convenience init(age:Int) {
//        self.title = ""
//        
//        self.init(title:"")
//    }
    
    convenience init(sex:Int) {
        self.init(title:"")
        
        self.title = ""
    }
}


