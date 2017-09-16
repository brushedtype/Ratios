//
//  SettingsViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 03/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit
import SafariServices

fileprivate struct Actions {
    private init() {}

    static let handleCloseButtonPress = #selector(SettingsViewController.handleCloseButtonPress(_:))
    static let handleReviewButtonPress = #selector(SettingsViewController.handleReviewButtonPress(_:))
    static let handleGitHubButtonPress = #selector(SettingsViewController.handleGitHubButtonPress(_:))
    static let handleFontButtonPress = #selector(SettingsViewController.handleFontButtonPress(_:))
    static let handleFontAuthorButtonPress = #selector(SettingsViewController.handleFontAuthorButtonPress(_:))
}

class SettingsViewController: UIViewController {

    let scrollView = UIScrollView(frame: .zero)

    let iconImageView = UIImageView(image: UIImage(named: "AppIcon"))

    let aboutTextView = UITextView(frame: .zero)
    let reviewButton = RoundedButton(title: "Leave Review")
    let aboutButton = RoundedButton(title: "Open GitHub")

    let fontTextView = UITextView(frame: .zero)
    let fontButton = RoundedButton(title: "About Tofino")
    let fontAuthorButton = RoundedButton(title: "About Alanna")

    let versionLabel = UILabel(frame: .zero)


    override func loadView() {
        self.view = self.scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About"

        self.scrollView.alwaysBounceVertical = true

        self.aboutTextView.text = """
        Ratios is free and open source. If you enjoy using the app, please leave a review or contibute on GitHub.
        """
        self.aboutTextView.font = UIFont.applicationFont(ofSize: 16)
        self.aboutTextView.textColor = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
        self.aboutTextView.isScrollEnabled = false
        self.aboutTextView.isEditable = false
        self.aboutTextView.isSelectable = false
        self.aboutTextView.textAlignment = .center
        self.aboutTextView.backgroundColor = .clear

        self.reviewButton.addTarget(self, action: Actions.handleReviewButtonPress, for: .touchUpInside)
        self.aboutButton.addTarget(self, action: Actions.handleGitHubButtonPress, for: .touchUpInside)

        let aboutButtonsStackView = UIStackView(arrangedSubviews: [
            self.reviewButton,
            self.aboutButton
        ])

        aboutButtonsStackView.axis = .horizontal
        aboutButtonsStackView.alignment = .top
        aboutButtonsStackView.distribution = .fillEqually
        aboutButtonsStackView.spacing = 8

        let aboutStackView = UIStackView(arrangedSubviews: [
            self.aboutTextView,
            aboutButtonsStackView
        ])

        aboutStackView.axis = .vertical
        aboutStackView.alignment = .fill
        aboutStackView.distribution = .equalSpacing
        aboutStackView.spacing = 8

        self.fontTextView.text = """
        Ratios uses the wonderful Tofino typeface by Alanna Munro.
        If you think the font is as fantastic as we do, consider using Tofino in your own projects.
        """
        self.fontTextView.font = UIFont.applicationFont(ofSize: 16)
        self.fontTextView.textColor = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
        self.fontTextView.isScrollEnabled = false
        self.fontTextView.isEditable = false
        self.fontTextView.isSelectable = false
        self.fontTextView.textAlignment = .center
        self.fontTextView.backgroundColor = .clear

        self.fontButton.addTarget(self, action: Actions.handleFontButtonPress, for: .touchUpInside)
        self.fontAuthorButton.addTarget(self, action: Actions.handleFontAuthorButtonPress, for: .touchUpInside)

        let fontButtonsStackView = UIStackView(arrangedSubviews: [
            self.fontButton,
            self.fontAuthorButton
        ])

        fontButtonsStackView.axis = .horizontal
        fontButtonsStackView.alignment = .top
        fontButtonsStackView.distribution = .fillEqually
        fontButtonsStackView.spacing = 8

        let fontStackView = UIStackView(arrangedSubviews: [
            self.fontTextView,
            fontButtonsStackView
        ])

        fontStackView.axis = .vertical
        fontStackView.alignment = .fill
        fontStackView.distribution = .equalSpacing
        fontStackView.spacing = 8

        self.versionLabel.text = "\(AppInfo.shared.name) v\(AppInfo.shared.version) (\(AppInfo.shared.build))"
        self.versionLabel.font = UIFont.monospacedApplicationFont(ofSize: 13, weight: .medium)
        self.versionLabel.textColor = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0).withAlphaComponent(0.8)
        self.versionLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [
            self.iconImageView,
            aboutStackView,
            fontStackView,
            self.versionLabel
        ])

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 32

        self.view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -32).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8).isActive = true

        self.view.backgroundColor = UIColor(red: 0.87256, green: 0.79711, blue: 0.71713, alpha: 1)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: Actions.handleCloseButtonPress)
    }

    @objc func handleCloseButtonPress(_ sender: AnyObject?) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func handleReviewButtonPress(_ sender: AnyObject?) {
        let url = URL(string: "https://itunes.apple.com/us/app/ratios/id1286379929?ls=1&mt=8&action=write-review")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @objc func handleGitHubButtonPress(_ sender: AnyObject?) {
        let url = URL(string: "https://github.com/brushedtype/Ratios")!
        let safariViewController = SFSafariViewController(url: url)
        self.navigationController?.present(safariViewController, animated: true, completion: nil)
//        self.present(safariViewController, animated: true, completion: nil)
    }

    @objc func handleFontButtonPress(_ sender: AnyObject?) {
        let url = URL(string: "http://tofino.losttype.com")!
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }

    @objc func handleFontAuthorButtonPress(_ sender: AnyObject?) {
        let url = URL(string: "https://alannamunro.com")!
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }

}
