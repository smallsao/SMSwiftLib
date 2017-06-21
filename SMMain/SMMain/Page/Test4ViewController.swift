//
//  Test4ViewController.swift
//  SMMain
//
//  Created by smallsao on 2017/4/18.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit
import SMExtension
import SMUIKit
import SMRouteBus

class Test4ViewController: TestBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button:SMButton = SMButton(type:.custom)
        button.frame = CGRect.init(x: 20, y: 120, width: 80, height: 80)
        button.setTitle("按钮", for:UIControlState.normal)
        self.view.addSubview(button);
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self,action:#selector(tapped),for:.touchUpInside)
        button.setBackgroundColor(UIColor.yellow, for: .normal)
        button.setBackgroundColor(UIColor.blue, for: .highlighted)
        
        button.setImage(UIImage.init(named: "remove_item"), for: .normal)
        button.centerVImageAndTitle(space: 10)
        button.addNumberDot(number: "48")
    }
    
    func tapped() {
        SMRoute.standard.pageCenter.open(url: "4")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
