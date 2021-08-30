//
//  SettingsViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 03/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit
import SafariServices
import SwiftUI

fileprivate struct Actions {
    private init() {}

    static let handleCloseButtonPress = #selector(SettingsViewController.handleCloseButtonPress(_:))
}

class SettingsViewController: UIViewController {

    private lazy var hostingViewController = UIHostingController(rootView: SettingsView(
        aboutRatiosButtonAction: { [weak self] in
            self?.handleGitHubButtonPress()
        },
        aboutFontButtonAction: { [weak self] in
            self?.handleFontButtonPress()
        },
        aboutFontAuthorButtonAction: { [weak self] in
            self?.handleFontAuthorButtonPress()
        }
    ))


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About"
        self.navigationItem.title = ""
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: Actions.handleCloseButtonPress)

        self.view.backgroundColor = Theme.backgroundColor

        self.addChildViewController(self.hostingViewController)

        self.hostingViewController.view.backgroundColor = .clear
        self.hostingViewController.view.frame = self.view.bounds
        self.hostingViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.hostingViewController.view)

        self.hostingViewController.didMove(toParent: self)
    }

    @objc func handleCloseButtonPress(_ sender: AnyObject?) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    private func handleReviewButtonPress() {
        let url = URL(string: "https://itunes.apple.com/us/app/ratios/id1286379929?ls=1&mt=8&action=write-review")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func handleGitHubButtonPress() {
        let url = URL(string: "https://github.com/brushedtype/Ratios")!
        let safariViewController = SFSafariViewController(url: url)
        self.navigationController?.present(safariViewController, animated: true, completion: nil)
    }

    private func handleFontButtonPress() {
        let url = URL(string: "http://tofino.losttype.com")!
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }

    private func handleFontAuthorButtonPress() {
        let url = URL(string: "https://alannamunro.com")!
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }

}
