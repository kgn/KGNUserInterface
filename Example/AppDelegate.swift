//
//  AppDelegate.swift
//  KGNUserInterfaceExample
//
//  Created by David Keegan on 1/17/16.
//  Copyright © 2016 David Keegan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Can't be lazy var due to a bug in swift 3
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window?.rootViewController = TextFieldViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

