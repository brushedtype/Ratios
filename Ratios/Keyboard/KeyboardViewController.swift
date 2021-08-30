//
//  KeyboardViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {

    static let shared = KeyboardViewController()

    private lazy var hostingViewController = UIHostingController(rootView: KeyboardView(handleKeyPress: { [weak self] buttonValue in
        self?.handleButtonPress(buttonValue)
    }))


    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateBackgroundColor(Theme.backgroundColor)
        self.view.translatesAutoresizingMaskIntoConstraints = false

        self.addChildViewController(self.hostingViewController)

        let keyboardView = self.hostingViewController.view!
        keyboardView.backgroundColor = .clear

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

        keyboardView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true

        self.hostingViewController.didMove(toParent: self)
    }
    
    func updateBackgroundColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }


    private func handleButtonPress(_ buttonValue: KeyboardButtonValue) {
        switch buttonValue {
        case .delete:
            self.textDocumentProxy.deleteBackward()
        case .literal(let value):
            self.textDocumentProxy.insertText(value)
        }
    }

}
