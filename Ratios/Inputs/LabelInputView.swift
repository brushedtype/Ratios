//
//  LabelInputView.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class LabelInputView: UIView, UITextFieldDelegate {

    let labelView = UILabel()
    let textField = InputTextField()


    init(label: String, initialValue: String? = nil) {
        super.init(frame: .zero)

        self.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            self.labelView,
            self.textField
        ])

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.alignment = .fill

        self.textField.text = initialValue
        self.textField.font = UIFont.monospacedApplicationFont(ofSize: 36, weight: .light)
        self.textField.keyboardType = .decimalPad
        self.textField.backgroundColor = .clear

        self.labelView.text = label
        self.labelView.font = UIFont.applicationFont(ofSize: 13, weight: .medium)

        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true

        self.textField.inputView = self.textField.inputViewController?.view

        self.layer.cornerRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.15
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
