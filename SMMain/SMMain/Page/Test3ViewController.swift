//
//  Test3ViewController.swift
//  SMMain
//
//  Created by smallsao on 2017/4/18.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit
import SMExtension
import SMUIKit
import SMRouteBus
import SMTools

class Test3ViewController: TestBaseViewController, SMAutoScrollDelegate, SMAutoScrollDataSource {

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
        
        
        self.showAutoScrollView()

    }
    
    func tapped() {
        SMRoute.standard.pageCenter.open(url: "3")
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
    
    
    func showAutoScrollView() {
        let autoScrollView = SMAutoScrollView()
        
        autoScrollView.frame = CGRect(x: 0, y: 200, width: UIScreen().width(), height: 400)
        autoScrollView.backgroundColor = UIColor.lightGray
        autoScrollView.delegate = self
        autoScrollView.dataSource = self
        self.view.addSubview(autoScrollView)
        
        
        autoScrollView.reloadData()
    }
    
    func numberOfRows(in autoScrollView: SMAutoScrollView) -> Int {
        return autoScrollData.count * 1000
    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, heightForRowAt index: Int) -> CGFloat {
        return 78
    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, cellForRowAt index: Int) -> SMAutoScrollViewCell {
        let cellID = "SMAutoScrollViewCell"
        var cell = autoScrollView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = TestAutoScrollViewCell(reuseIdentifier: cellID)
        }
        let dict = autoScrollData[index%autoScrollData.count]

        cell?.updateData(data: dict as AnyObject)
        
        return cell!

    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, didSelectRowAt index: Int) {
        
    }
    
    deinit {
       print("sss")
    }
}

let autoScrollData = [
    
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ],
    [
        "image":"WDIMG_CRM_HTK",
        "title":"京津冀奥斯卡的骄傲看了就",
        "desc":"斯蒂芬破阿斯蒂芬跑商点发送咖啡破司法破",
        ]
    
]

