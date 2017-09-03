//
//  InputTextField.swift
//  Ratios
//
//  Created by Edward Wellbrook on 03/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class InputTextField: UITextField {

    override var inputViewController: UIInputViewController? {
        return KeyboardViewController.shared
    }

}
