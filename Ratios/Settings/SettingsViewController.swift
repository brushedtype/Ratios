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

fileprivate struct TableViewSection {
    let items: [String]
}

class SettingsViewController: UIViewController {

    let aboutTextView = UITextView(frame: .zero)
    let reviewButton = UIButton(type: .system)
    let aboutButton = UIButton(type: .system)

    let fontTextView = UITextView(frame: .zero)
    let fontButton = UIButton(type: .system)
    let fontAuthorButton = UIButton(type: .system)

    let versionLabel = UILabel(frame: .zero)


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About"

        self.aboutTextView.text = """
        Ratios is free and open source. If you enjoy using the app, please leave a review or contibute on GitHub.
        """
        self.aboutTextView.font = UIFont.applicationFont(ofSize: 16)
        self.aboutTextView.isScrollEnabled = false
        self.aboutTextView.textAlignment = .center
        self.aboutTextView.backgroundColor = .clear

        self.reviewButton.setTitle("Leave Review", for: .normal)
        self.aboutButton.setTitle("Open GitHub", for: .normal)

        let aboutButtonsStackView = UIStackView(arrangedSubviews: [
            self.reviewButton,
            self.aboutButton
        ])

        aboutButtonsStackView.axis = .horizontal
        aboutButtonsStackView.alignment = .fill
        aboutButtonsStackView.distribution = .fillEqually

        let aboutStackView = UIStackView(arrangedSubviews: [
            self.aboutTextView,
            aboutButtonsStackView
        ])

        aboutStackView.axis = .vertical
        aboutStackView.alignment = .fill
        aboutStackView.distribution = .fillProportionally


        self.fontTextView.text = """
        Ratios uses the wonderful Tofino typeface by Alanna Munro.
        If you think the font is as fantastic as we do, consider using Tofino in your own projects.
        """
        self.fontTextView.font = UIFont.applicationFont(ofSize: 16)
        self.fontTextView.isScrollEnabled = false
        self.fontTextView.textAlignment = .center
        self.fontTextView.backgroundColor = .clear

        self.fontButton.setTitle("About Tofino", for: .normal)
        self.fontAuthorButton.setTitle("About Alanna", for: .normal)

        let fontButtonsStackView = UIStackView(arrangedSubviews: [
            self.fontButton,
            self.fontAuthorButton
        ])

        fontButtonsStackView.axis = .horizontal
        fontButtonsStackView.alignment = .fill
        fontButtonsStackView.distribution = .fillEqually

        let fontStackView = UIStackView(arrangedSubviews: [
            self.fontTextView,
            fontButtonsStackView
        ])

        fontStackView.axis = .vertical
        fontStackView.alignment = .fill
        fontStackView.distribution = .fillProportionally

        self.versionLabel.text = "\(AppInfo.shared.name) v\(AppInfo.shared.version) (\(AppInfo.shared.build))"
        self.versionLabel.font = UIFont.monospacedApplicationFont(ofSize: 13, weight: .medium)
        self.versionLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            aboutStackView,
            fontStackView
        ])

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 24

        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 8).isActive = true

        self.view.addSubview(self.versionLabel)
        self.versionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.versionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.versionLabel.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -16).isActive = true

        self.view.backgroundColor = UIColor(red: 0.87256, green: 0.79711, blue: 0.71713, alpha: 1)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: Actions.handleCloseButtonPress)
    }

    @objc func handleCloseButtonPress(_ sender: AnyObject?) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
