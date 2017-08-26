//
//  LabelInputView.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit


fileprivate let descriptor = UIFontDescriptor(fontAttributes: [ .family: "Tofino Personal" ])
fileprivate let mediumWeightTraits = [ UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium ]

fileprivate let largeFont = UIFontMetrics.default.scaledFont(for: UIFont(descriptor: descriptor, size: 42))
fileprivate let titleFont = UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 13)


class LabelInputView: UIView {

    let labelView = UILabel()
    let textField = UITextField()

    init(label: String, initialValue: String? = nil) {
        super.init(frame: .zero)

        self.backgroundColor = .white
        self.layer.cornerRadius = 3

        let stackView = UIStackView(arrangedSubviews: [
            self.labelView,
            self.textField
        ])

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.alignment = .fill

        self.textField.font = largeFont
        self.textField.keyboardType = .decimalPad
        self.textField.backgroundColor = .clear

        self.labelView.font = titleFont

        self.labelView.text = label
        self.textField.text = initialValue

        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraintEqualToSystemSpacingAfter(self.leftAnchor, multiplier: 1).isActive = true
        stackView.topAnchor.constraintEqualToSystemSpacingBelow(self.topAnchor, multiplier: 1).isActive = true
        self.rightAnchor.constraintEqualToSystemSpacingAfter(stackView.rightAnchor, multiplier: 1).isActive = true
        self.bottomAnchor.constraintEqualToSystemSpacingBelow(stackView.bottomAnchor, multiplier: 1).isActive = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
