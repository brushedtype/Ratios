//
//  AppDelegate.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/01/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let calculatorViewController = CalculatorViewController()
        calculatorViewController.persistenceStore = UserDefaults.standard

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: calculatorViewController)
        self.window?.makeKeyAndVisible()

        return true
    }

}
