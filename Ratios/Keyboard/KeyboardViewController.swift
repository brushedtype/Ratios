//
//  KeyboardViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    static let shared = KeyboardViewController()

    let rows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "<"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 0.87256, green: 0.79711, blue: 0.71713, alpha: 1)

        let keys = KeyboardSection(sectionSubviews: self.rows.map { (values) -> UIView in
            let buttons = values.map({ buttonValue -> KeyboardButton in
                let button = KeyboardButton(buttonValue: buttonValue)
                button.addTarget(self, action: #selector(self.handleKeyPress(_:)), for: .touchUpInside)
                return button
            })
            return KeyboardSection(sectionSubviews: buttons, direction: .horizontal)
        }, direction: .vertical)

        self.view.addSubview(keys)
        keys.translatesAutoresizingMaskIntoConstraints = false
        keys.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        keys.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        keys.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        if #available(iOS 11.0, *) {
            keys.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        } else {
            keys.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true
        }

        self.view.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc func handleKeyPress(_ sender: AnyObject?) {
        guard let button = sender as? KeyboardButton, let buttonValue = button.value else {
            return
        }

        if buttonValue == "<" {
            self.textDocumentProxy.deleteBackward()
        } else {
            self.textDocumentProxy.insertText(buttonValue)
        }
    }

}
