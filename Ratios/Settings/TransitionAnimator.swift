//
//  TransitionAnimator.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    enum Transistion {
        case presenting
        case dismissing
    }

    private let transition: Transistion

    init(transition: Transistion) {
        self.transition = transition
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.450
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let duration = self.transitionDuration(using: transitionContext)

        switch self.transition {
        case .presenting:
            self.animatePresentingTransition(using: transitionContext, duration: duration)
        case .dismissing:
            self.animateDismissingTransition(using: transitionContext, duration: duration)
        }
    }

    private func animatePresentingTransition(using transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else {
            return transitionContext.completeTransition(false)
        }

        let entryFrame = transitionContext.containerView.frame.insetBy(dx: 30, dy: 90)

        toVC.view.alpha = 0
        toVC.view.frame = entryFrame.offsetBy(dx: 0, dy: entryFrame.height)
        toVC.view.layer.cornerRadius = 8
        toVC.view.clipsToBounds = true

        let overlayView = UIView(frame: fromVC.view.frame)
        overlayView.backgroundColor = .black
        overlayView.alpha = 0

        if let snapshotView = fromVC.view.snapshotView(afterScreenUpdates: true) {
            snapshotView.addSubview(overlayView)
            transitionContext.containerView.addSubview(snapshotView)
        }

        let shadowView = ShadowView(frame: toVC.view.frame)
        shadowView.backgroundColor = toVC.view.backgroundColor
        shadowView.layer.cornerRadius = toVC.view.layer.cornerRadius

        transitionContext.containerView.addSubview(shadowView)
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.bringSubview(toFront: toVC.view)

        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.centerYAnchor.constraint(equalTo: toVC.view.centerYAnchor).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: toVC.view.centerXAnchor).isActive = true
        shadowView.heightAnchor.constraint(equalTo: toVC.view.heightAnchor).isActive = true
        shadowView.widthAnchor.constraint(equalTo: toVC.view.widthAnchor).isActive = true

        UIView.animate(withDuration: duration) {
            overlayView.alpha = 0.6
        }

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 5, options: [], animations: {
            shadowView.alpha = 1
            shadowView.frame = entryFrame
            toVC.view.alpha = 1
            toVC.view.frame = entryFrame
        }) { isComplete in
            transitionContext.completeTransition(isComplete)
        }
    }

    private func animateDismissingTransition(using transitionContext: UIViewControllerContextTransitioning, duration: TimeInterval) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
        else {
            return transitionContext.completeTransition(false)
        }

        let exitFrame = fromVC.view.frame
        let viewsToRemove = transitionContext.containerView.subviews

        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.sendSubview(toBack: toVC.view)

        UIView.animate(withDuration: duration) {
            for view in viewsToRemove {
                view.alpha = 0
            }
        }

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 5, options: [], animations: {
            fromVC.view.frame = exitFrame.offsetBy(dx: 0, dy: exitFrame.height)
            transitionContext.containerView.layoutSubviews()
        }) { isComplete in
            transitionContext.completeTransition(isComplete)
        }
    }

}
