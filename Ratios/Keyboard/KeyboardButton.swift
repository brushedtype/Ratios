//
//  KeyboardButton.swift
//  Ratios
//
//  Created by Edward Wellbrook on 02/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

fileprivate let descriptor = UIFontDescriptor(fontAttributes: [ .family: "Tofino Personal" ])
fileprivate let mediumWeightTraits = [ UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium ]

fileprivate let largeFont = UIFont(descriptor: descriptor, size: 42)
fileprivate let titleFont = UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 13)



class KeyboardButton: UIButton {


    private(set) var value: String? = nil
    var animator: UIViewPropertyAnimator? = nil

    var normalBackgroundColor = UIColor.white
    var activeBackgroundColor = UIColor(red:0.60, green:0.53, blue:0.46, alpha:1.0)


    convenience init(buttonValue: String) {
        self.init(type: .custom)
        self.value = buttonValue

        if buttonValue == "<" {
            let image = UIImage(named: "backspace")?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
        } else {
            self.setAttributedTitle(NSAttributedString(string: buttonValue, attributes: [
                .font: UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 22),
                .foregroundColor: UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
            ]), for: .normal)
        }

        self.tintColor = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
        self.backgroundColor = self.normalBackgroundColor

        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.imageView?.contentMode = .center

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true

        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.15
    }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.animator?.stopAnimation(true)

        self.backgroundColor = self.activeBackgroundColor.withAlphaComponent(0.5)
        self.layer.shadowOpacity = 0
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        self.animator = UIViewPropertyAnimator(duration: 0.125, curve: .linear, animations: { [unowned self] in
            self.backgroundColor = self.normalBackgroundColor
            self.layer.shadowOpacity = 0.15
        })
        self.animator?.startAnimation()
    }

}
