//
//  NavigationController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont.applicationFont(ofSize: 17),
        ], for: .normal)

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont.applicationFont(ofSize: 17),
        ], for: .highlighted)

        self.navigationBar.tintColor = Theme.accentColor
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [
            .font: UIFont.applicationFont(ofSize: 17, weight: .medium),
            .foregroundColor: Theme.accentColor
        ]
    }

}
