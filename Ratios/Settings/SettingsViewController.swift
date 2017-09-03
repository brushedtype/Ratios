//
//  SettingsViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 03/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

fileprivate struct Actions {
    private init() {}

    static let handleCloseButtonPress = #selector(SettingsViewController.handleCloseButtonPress(_:))
}

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        self.view.backgroundColor = .white

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: Actions.handleCloseButtonPress)
    }

    @objc func handleCloseButtonPress(_ sender: AnyObject?) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
