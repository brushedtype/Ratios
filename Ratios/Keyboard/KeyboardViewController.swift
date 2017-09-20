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

    let rows: [[KeyboardButtonValue]] = [
        [.literal("1"), .literal("2"), .literal("3")],
        [.literal("4"), .literal("5"), .literal("6")],
        [.literal("7"), .literal("8"), .literal("9")],
        [.literal("."), .literal("0"), .delete]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Theme.backgroundColour
        self.view.translatesAutoresizingMaskIntoConstraints = false

        let keyboardRows = self.rows.map({ KeyboardViewController.createKeyboardRow(buttonValues: $0) })
        let keyboardView = KeyboardSection(sectionSubviews: keyboardRows, direction: .vertical)

        self.view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        keyboardView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true
        keyboardView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true

        if #available(iOS 11.0, *) {
            keyboardView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        } else {
            keyboardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true
        }
    }

    @objc func handleKeyPress(_ sender: AnyObject?) {
        guard let button = sender as? KeyboardButton else {
            return
        }

        switch button.buttonValue {
        case .delete:
            self.textDocumentProxy.deleteBackward()
        case .literal(let value):
            self.textDocumentProxy.insertText(value)
        }
    }

    static func createKeyboardButton(buttonValue: KeyboardButtonValue) -> KeyboardButton {
        let button = KeyboardButton(buttonValue: buttonValue)
        button.addTarget(self, action: #selector(self.handleKeyPress(_:)), for: .touchUpInside)

        return button
    }

    static func createKeyboardRow(buttonValues: [KeyboardButtonValue]) -> KeyboardSection {
        let buttons = buttonValues.map({ value in
            return KeyboardViewController.createKeyboardButton(buttonValue: value)
        })

        return KeyboardSection(sectionSubviews: buttons, direction: .horizontal)
    }

}
