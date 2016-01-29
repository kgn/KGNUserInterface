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

    lazy var window: UIWindow? = UIWindow(frame: UIScreen.mainScreen().bounds)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window?.rootViewController = TextFieldViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

