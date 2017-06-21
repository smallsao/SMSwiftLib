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
    
    func numberOfComponents(in autoScrollView: SMAutoScrollView) -> Int {
        return 1;
    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, numberOfRowsInComponent component: Int) -> Int {
        return autoScrollData.count * 1000
    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, widthForComponent component: Int) -> CGFloat {
        return UIScreen().width()
    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, rowHeightForComponent component: Int) -> CGFloat {
        return 78
    }
    
    
    
    //    func autoScrollView(_ autoScrollView: SMAutoScrollView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return "\(component)"
    //    }
    
    func autoScrollView(_ autoScrollView: SMAutoScrollView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = SMView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen().width(), height: 78)
        
        let ivIcon = UIImageView()
        view.addSubview(ivIcon)
        ivIcon.frame = CGRect(x: 15, y: 15, width: 48, height: 48)
        ivIcon.layer.cornerRadius = 24
        ivIcon.clipsToBounds = true
        
        let lbTitle = SMLabel()
        lbTitle.frame = CGRect(x: 78, y: 15, width: UIScreen().width() - 78*2, height: 20)
        lbTitle.textAlignment = .center
        lbTitle.font = SMFont(16)
        view.addSubview(lbTitle)
        
        
        let lbDesc = SMLabel()
        lbDesc.frame = CGRect(x: 78, y: 43, width: UIScreen().width() - 78*2, height: 20)
        lbDesc.textAlignment = .center
        lbDesc.textColor = UIColor.gray
        lbDesc.font = SMFont(12)
        view.addSubview(lbDesc)
        
        
        
        let dict = autoScrollData[component%autoScrollData.count]
        
        ivIcon.image = UIImage(named: dict["image"]!)
        lbTitle.text = dict["title"]
        lbDesc.text = dict["desc"]
        
        return view
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

