//
//  KeyboardViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class KeyboardSection: UIStackView {

    private static func emptyView() -> UIView {
        return UIView(frame: .zero)
    }

    convenience init(sectionSubviews: [UIView], direction: UILayoutConstraintAxis) {
        self.init(frame: .zero)
        self.alignment = .fill
        self.distribution = .fillEqually
        self.axis = direction
        self.spacing = 4

//        self.addArrangedSubview(KeyboardSection.emptyView())

        for view in sectionSubviews {
            self.addArrangedSubview(view)
        }

//        self.addArrangedSubview(KeyboardSection.emptyView())
    }

}

class KeyboardViewController: UIViewController {

    let rows = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "<"]
    ]

    override func loadView() {
        let keyboardRows = self.rows.map { (values) -> UIView in
            let buttons = values.map({ KeyboardButton(buttonValue: $0) })
            return KeyboardSection(sectionSubviews: buttons, direction: .horizontal)
        }

        self.view = KeyboardSection(sectionSubviews: keyboardRows, direction: .vertical)
    }

}
