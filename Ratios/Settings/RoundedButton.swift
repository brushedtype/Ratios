//
//  RoundedButton.swift
//  Ratios
//
//  Created by Edward Wellbrook on 16/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    var animator: UIViewPropertyAnimator? = nil

    init(title: String) {
        super.init(frame: .zero)

        self.setTitle(title, for: .normal)
        self.setTitleColor(Theme.accentColour, for: .normal)

        self.backgroundColor = .clear
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 12, right: 0)
        self.titleLabel?.font = UIFont.applicationFont(ofSize: 15, weight: .medium)

        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.5
        self.layer.borderColor = Theme.buttonHighlightColour.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        self.animator?.stopAnimation(true)

        self.backgroundColor = Theme.buttonHighlightColour
        self.layer.borderWidth = 0
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        self.animator = UIViewPropertyAnimator(duration: 0.125, curve: .linear, animations: { [unowned self] in
            self.backgroundColor = .clear
            self.layer.borderWidth = 0.5
        })
        self.animator?.startAnimation()
    }

}
