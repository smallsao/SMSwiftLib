//
//  AppDelegate.swift
//  SMMain
//
//  Created by smallsao on 16/7/13.
//  Copyright © 2016 smallsao. All rights reserved.
//

import UIKit

import SMRouteBus

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        
        let nav = UINavigationController(rootViewController: vc)
        
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        self.window?.backgroundColor = .white

        let smRoute = SMRoute.standard
        SMRoute.standard.navigation = nav;
        smRoute.pageMappingDataSource = TestRBPageCenter()
        SMRoute.standard.launch()
        
        
        return true
    }
}

