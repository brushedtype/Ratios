//
//  NavigationController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

fileprivate let descriptor = UIFontDescriptor(fontAttributes: [ .family: "Tofino Personal" ])
fileprivate let regularWeightTraits = [ UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular ]
fileprivate let mediumWeightTraits = [ UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium ]

fileprivate let largeFont = UIFontMetrics.default.scaledFont(for: UIFont(descriptor: descriptor, size: 42))
fileprivate let titleFont = UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 13)

class NavigationController: UINavigationController {

    let shadowLayer = ShadowLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont(descriptor: descriptor.addingAttributes([ .traits: regularWeightTraits ]), size: 17),
        ], for: .normal)

        self.navigationBar.tintColor = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [
            .font: UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 17),
            .foregroundColor: UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
        ]

        self.view.layer.insertSublayer(self.shadowLayer, at: 0)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.shadowLayer.path = UIBezierPath(roundedRect: self.view.frame, cornerRadius: 8).cgPath
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
