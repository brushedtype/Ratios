//
//  KeyboardButton.swift
//  Ratios
//
//  Created by Edward Wellbrook on 02/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

enum KeyboardButtonValue {
    case literal(String)
    case delete
}

class KeyboardButton: UIButton {

    private(set) var buttonValue: KeyboardButtonValue

    var animator: UIViewPropertyAnimator? = nil

    var normalBackgroundColor = Theme.keyboardButtonColor
    var activeBackgroundColor = Theme.keyboardButtonHighlightColor


    init(buttonValue: KeyboardButtonValue) {
        self.buttonValue = buttonValue

        super.init(frame: .zero)

        switch self.buttonValue {
        case .delete:
            let image = UIImage(named: "backspace")?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
        case .literal(let value):
            let attributedString = NSAttributedString(string: value, attributes: [
                .font: UIFont.applicationFont(ofSize: 22, weight: .medium),
                .foregroundColor: Theme.accentColor
            ])
            self.setAttributedTitle(attributedString, for: .normal)
        }

        self.tintColor = Theme.accentColor
        self.backgroundColor = self.normalBackgroundColor

        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.imageView?.contentMode = .center

        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true

        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowColor = Theme.shadowColor.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.15
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.animator?.stopAnimation(true)

        self.backgroundColor = self.activeBackgroundColor
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
