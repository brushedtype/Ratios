//
//  CalculatorViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/01/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

fileprivate struct Actions {
    private init() {}

    static let handleSettingsButtonPress = #selector(CalculatorViewController.handleSettingsButtonPress(_:))
    static let handleFieldValueChange = #selector(CalculatorViewController.handleFieldValueChange(_:))
}

fileprivate struct Assets {
    private init() {}

    static let settingsCog = UIImage(named: "settings-cog")
}

fileprivate func formatDoubleToString(_ value: Double) -> String? {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 0
    formatter.minimumIntegerDigits = 1

    return formatter.string(from: NSNumber(value: value))
}

class CalculatorViewController: UIViewController {

    var persistenceStore: PersistenceStore?

    let ratioInputView = LabelInputView(label: "RATIO", initialValue: "16")
    let totalInputView = LabelInputView(label: "TOTAL BREW (ML)", initialValue: "315")
    let waterInputView = LabelInputView(label: "WATER (ML)", initialValue: "0")
    let groundsInputView = LabelInputView(label: "GROUNDS (G)", initialValue: "0")


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Ratios"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Assets.settingsCog, style: .plain, target: self, action: Actions.handleSettingsButtonPress)

        self.view.backgroundColor = UIColor(red: 0.87256, green: 0.79711, blue: 0.71713, alpha: 1)

        let topView = UIStackView(arrangedSubviews: [
            self.ratioInputView,
            self.totalInputView
        ])

        topView.alignment = .fill
        topView.axis = .horizontal
        topView.distribution = .fillEqually
        topView.spacing = 4

        let stackView = UIStackView(arrangedSubviews: [
            topView,
            self.groundsInputView,
            self.waterInputView
        ])

        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4

        self.view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 8).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8).isActive = true

        self.totalInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: .editingChanged)
        self.waterInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: .editingChanged)
        self.groundsInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: .editingChanged)
        self.ratioInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: .editingChanged)

        if let values = self.persistenceStore?.getValues() {
            let water = Calculator.calculateWater(grounds: values.grounds, ratio: values.ratio)
            let brew = Calculator.calculateBrew(grounds: values.grounds, water: water)

            self.ratioInputView.textField.text = String(values.ratio)
            self.groundsInputView.textField.text = formatDoubleToString(values.grounds)
            self.waterInputView.textField.text = formatDoubleToString(water)
            self.totalInputView.textField.text = formatDoubleToString(brew)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.totalInputView.textField.becomeFirstResponder()
    }

    @objc func handleFieldValueChange(_ sender: AnyObject) {
        let ratio = Int(self.ratioInputView.textField.text ?? "16") ?? 16
        var total = Double(self.totalInputView.textField.text ?? "0") ?? 0
        var water = Double(self.waterInputView.textField.text ?? "0") ?? 0
        var grounds = Double(self.groundsInputView.textField.text ?? "0") ?? 0

        guard let field = sender as? UITextField else {
            return
        }

        switch field {
        case self.totalInputView.textField:
            grounds = Calculator.calculateGrounds(brew: total, ratio: ratio)
            water = Calculator.calculateWater(grounds: grounds, ratio: ratio)
            self.groundsInputView.textField.text = formatDoubleToString(grounds)
            self.waterInputView.textField.text = formatDoubleToString(water)

        case self.waterInputView.textField:
            grounds = Calculator.calculateGrounds(water: water, ratio: ratio)
            total = Calculator.calculateBrew(grounds: grounds, water: water)
            self.groundsInputView.textField.text = formatDoubleToString(grounds)
            self.totalInputView.textField.text = formatDoubleToString(total)

        case self.groundsInputView.textField, self.ratioInputView.textField:
            water = Calculator.calculateWater(grounds: grounds, ratio: ratio)
            total = Calculator.calculateBrew(grounds: grounds, water: water)
            self.waterInputView.textField.text = formatDoubleToString(water)
            self.totalInputView.textField.text = formatDoubleToString(total)

        default:
            break
        }

        self.persistenceStore?.save(grounds: grounds, ratio: ratio)
    }

    @objc func handleSettingsButtonPress(_ sender: AnyObject?) {
        self.ratioInputView.textField.resignFirstResponder()
        self.totalInputView.textField.resignFirstResponder()
        self.groundsInputView.textField.resignFirstResponder()
        self.waterInputView.textField.resignFirstResponder()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            let settingsViewController = SettingsViewController(style: .grouped)
            let navigationController = NavigationController(rootViewController: settingsViewController)
            navigationController.transitioningDelegate = navigationController

            self.present(navigationController, animated: true, completion: nil)
        }
    }

}
