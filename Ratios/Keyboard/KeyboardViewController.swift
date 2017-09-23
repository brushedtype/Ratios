//
//  KeyboardViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

fileprivate struct Actions {
    private init() {}

    static let handleKeyPress = #selector(KeyboardViewController.handleKeyPress(_:))
}

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

        let keyboardRows = self.rows.map({ [unowned self] buttonValues in
            return KeyboardViewController.createKeyboardRow(buttonValues: buttonValues, keyPressHandler: self)
        })

        let keyboardView = KeyboardSection(sectionSubviews: keyboardRows, direction: .vertical)

        self.view.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        keyboardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        if UIDevice.current.userInterfaceIdiom == .pad {
            keyboardView.heightAnchor.constraint(equalToConstant: 280).isActive = true
            keyboardView.widthAnchor.constraint(equalToConstant: 580).isActive = true
        } else {
            keyboardView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true
            keyboardView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -16).isActive = true
        }

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

    static func createKeyboardButton(buttonValue: KeyboardButtonValue, keyPressHandler: Any) -> KeyboardButton {
        let button = KeyboardButton(buttonValue: buttonValue)
        button.addTarget(keyPressHandler, action: Actions.handleKeyPress, for: .touchUpInside)

        return button
    }

    static func createKeyboardRow(buttonValues: [KeyboardButtonValue], keyPressHandler: Any) -> KeyboardSection {
        let buttons = buttonValues.map({ value in
            return KeyboardViewController.createKeyboardButton(buttonValue: value, keyPressHandler: keyPressHandler)
        })

        return KeyboardSection(sectionSubviews: buttons, direction: .horizontal)
    }

}
