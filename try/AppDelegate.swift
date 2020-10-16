//
//  AppDelegate.swift
//  try
//
//  Created by Natali on 07.03.2020.
//  Copyright © 2020 Redmadrobot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = MainViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
//        self.window!.rootViewController!.present(vc, animated: true, completion: nil)
    }

}

