//
//  SMAutoScrollView.swift
//  SMUIKit
//
//  Created by smallsao on 2017/6/20.
//  Copyright © 2017年 smallsao. All rights reserved.
//

import UIKit
import Foundation



open class SMAutoScrollView: SMView, UITableViewDelegate, UITableViewDataSource {
    
    var table:SMTableView
    
    open var delegate:SMAutoScrollDelegate?
    
    open var dataSource:SMAutoScrollDataSource?
    
    override public init() {
        table = SMTableView()
        
        super.init(frame:.zero)
        
        table.delegate = self
        table.dataSource = self
        
        self.addSubview(table)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        table.frame = self.bounds
    }
    
    public func reloadData() {
        table.reloadData()
    }
    
    public func dequeueReusableCell(withIdentifier identifier: String) -> SMAutoScrollViewCell? {
        return table.dequeueReusableCell(withIdentifier: identifier) as? SMAutoScrollViewCell
    }

    // UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sDataSource = dataSource {
            if sDataSource.responds(to: #selector(SMAutoScrollDataSource.numberOfRows(in:))) {
                return sDataSource.numberOfRows(in: self)
            }
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sDataSource = dataSource {
            if sDataSource.responds(to: #selector(SMAutoScrollDataSource.autoScrollView(_:cellForRowAt:))) {
                return sDataSource.autoScrollView(self, cellForRowAt: indexPath.row)
            }
        }
        
        return UITableViewCell()
    }
    
    
    // UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:heightForRowAt:))) {
                return sDelegate.autoScrollView(self, heightForRowAt: indexPath.row)
            }
        }
        
        return 0.0;
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sDelegate = delegate {
            if sDelegate.responds(to: #selector(SMAutoScrollDelegate.autoScrollView(_:didSelectRowAt:))) {
                sDelegate.autoScrollView(self, didSelectRowAt: indexPath.row)
            }
        }
    }
    
    
    
    
    deinit {
        
    }
    
}


@objc public protocol SMAutoScrollDelegate:NSObjectProtocol {
    @objc func autoScrollView(_ autoScrollView: SMAutoScrollView, heightForRowAt index: Int) -> CGFloat
    
    @objc func autoScrollView(_ autoScrollView: SMAutoScrollView, didSelectRowAt index: Int)
}

@objc public protocol SMAutoScrollDataSource:NSObjectProtocol {
    @objc func numberOfRows(in autoScrollView: SMAutoScrollView) -> Int
    
    @objc func autoScrollView(_ autoScrollView: SMAutoScrollView, cellForRowAt index: Int) -> SMAutoScrollViewCell }


