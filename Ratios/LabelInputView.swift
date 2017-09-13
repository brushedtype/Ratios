//
//  LabelInputView.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit
import CoreText

fileprivate typealias FontFeature = [UIFontDescriptor.FeatureKey: Any]

fileprivate let fontFeatureSettings: [FontFeature] = [
    [.featureIdentifier: kNumberSpacingType, .typeIdentifier: kMonospacedNumbersSelector],
    [.featureIdentifier: kAllTypographicFeaturesType, .typeIdentifier: true]
]

fileprivate let descriptor = UIFontDescriptor(fontAttributes: [ .family: "Tofino Personal", .featureSettings: fontFeatureSettings ])
fileprivate let mediumWeightTraits = [ UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium ]

fileprivate let largeFont = UIFont(descriptor: descriptor, size: 42)
fileprivate let titleFont = UIFont(descriptor: descriptor.addingAttributes([ .traits: mediumWeightTraits ]), size: 13)


class LabelInputView: UIView, UITextFieldDelegate {

    let labelView = UILabel()
    let textField = InputTextField()
    let shadowLayer = ShadowLayer()


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
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 72).isActive = true

        self.textField.inputView = self.textField.inputViewController?.view

        self.layer.insertSublayer(self.shadowLayer, at: 0)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
    }

}
