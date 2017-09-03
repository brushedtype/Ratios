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

fileprivate let largeFont = UIFontMetrics.default.scaledFont(for: UIFont(descriptor: descriptor, size: 42))
fileprivate let titleFont = UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 13)


class KeyboardButton: UIButton, UIInputViewAudioFeedback {

    var enableInputClicksWhenVisible: Bool {
        return true
    }

    private(set) var value: String? = nil

    var normalBackgroundColor = UIColor(red:0.72, green:0.65, blue:0.58, alpha:1.0)
    var activeBackgroundColor = UIColor(red:0.60, green:0.53, blue:0.46, alpha:1.0)


    convenience init(buttonValue: String) {
        self.init(type: .custom)
        self.value = buttonValue
        self.setTitle(buttonValue, for: .normal)
        self.setTitleColor(UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0), for: .normal)
        self.backgroundColor = self.normalBackgroundColor
        self.contentHorizontalAlignment = .center

        self.setAttributedTitle(NSAttributedString(string: buttonValue, attributes: [
            .font: UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 22),
            .foregroundColor: UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
        ]), for: .normal)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true

        self.layer.cornerRadius = 5
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.backgroundColor = self.activeBackgroundColor

        UIDevice.current.playInputClick()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        UIView.animate(withDuration: 0.125) {
            self.backgroundColor = self.normalBackgroundColor
        }
    }

}
