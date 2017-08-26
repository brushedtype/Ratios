//
//  KeyboardViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {

    override func loadView() {
        let rows = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            [".", "0", "<"]
            ].map { (values) -> UIView in

                let buttons = values.map({ (value) -> UIView in
                    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 120))
                    button.setTitle(value, for: .normal)
                    button.backgroundColor = .gray
                    button.contentHorizontalAlignment = .center

                    return button
                })

                let row = UIStackView(arrangedSubviews: buttons)
                row.alignment = .fill
                row.distribution = .fillEqually
                row.axis = .horizontal
                row.spacing = 8

                return row
        }

        let keyboardView = UIStackView(arrangedSubviews: rows)
        keyboardView.alignment = .fill
        keyboardView.distribution = .fillEqually
        keyboardView.axis = .vertical
        keyboardView.spacing = 8

        self.view = keyboardView
    }

}
