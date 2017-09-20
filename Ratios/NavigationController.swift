//
//  NavigationController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont.applicationFont(ofSize: 17),
        ], for: .normal)

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont.applicationFont(ofSize: 17),
        ], for: .highlighted)

        self.navigationBar.tintColor = Theme.accentColour
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [
            .font: UIFont.applicationFont(ofSize: 17, weight: .medium),
            .foregroundColor: Theme.accentColour
        ]
    }

}

extension NavigationController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(transition: .presenting)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimator(transition: .dismissing)
    }

}
