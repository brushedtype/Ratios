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

fileprivate func formatDoubleToString(_ value: Double) -> String? {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 0
    formatter.minimumIntegerDigits = 1

    return formatter.string(from: NSNumber(value: value))
}

class CalculatorViewController: UIViewController {

    enum InputType {
        case ratio
        case totalBrew
        case grounds
        case water
    }

    override var disablesAutomaticKeyboardDismissal: Bool {
        return true
    }

    var persistenceStore: PersistenceStore?

    let ratioInputView = LabelInputView(label: "RATIO", initialValue: "16")
    let totalInputView = LabelInputView(label: "TOTAL BREW (ML)", initialValue: "315")
    let waterInputView = LabelInputView(label: "WATER (ML)", initialValue: "0")
    let groundsInputView = LabelInputView(label: "GROUNDS (G)", initialValue: "0")

    var stackView: UIStackView? = nil
    var stackViewWidthConstraint: NSLayoutConstraint? = nil

    private var currentInput: InputType = .totalBrew


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Ratios"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Assets.settingsCog, style: .plain, target: self, action: Actions.handleSettingsButtonPress)

        self.view.backgroundColor = Theme.backgroundColor

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
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        self.stackView = stackView
        self.updateWidthConstraint()

        self.totalInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: [.editingChanged, .editingDidBegin])
        self.waterInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: [.editingChanged, .editingDidBegin])
        self.groundsInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: [.editingChanged, .editingDidBegin])
        self.ratioInputView.textField.addTarget(self, action: Actions.handleFieldValueChange, for: [.editingChanged, .editingDidBegin])

        if let values = self.persistenceStore?.getValues() {
            let water = Calculator.calculateWater(grounds: values.grounds, ratio: values.ratio)
            let brew = Calculator.calculateBrew(grounds: values.grounds, water: water)

            self.ratioInputView.textField.text = String(values.ratio)
            self.groundsInputView.textField.text = formatDoubleToString(values.grounds)
            self.waterInputView.textField.text = formatDoubleToString(water)
            self.totalInputView.textField.text = formatDoubleToString(brew)
            
            self.updateBackgroundColor(values.ratio)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.beginInput()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // increment use every time screen appears
            ReviewHelper.shared.incrementUse(.low)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.updateWidthConstraint()
    }

    private func beginInput() {
        switch self.currentInput {
        case .totalBrew:
            self.totalInputView.textField.becomeFirstResponder()
        case .grounds:
            self.groundsInputView.textField.becomeFirstResponder()
        case .ratio:
            self.ratioInputView.textField.becomeFirstResponder()
        case .water:
            self.waterInputView.textField.becomeFirstResponder()
        }
    }

    func updateWidthConstraint() {
        self.stackViewWidthConstraint?.isActive = false

        if self.traitCollection.horizontalSizeClass == .compact {
            self.stackViewWidthConstraint = self.stackView?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1, constant: -16)
        } else {
            self.stackViewWidthConstraint = self.stackView?.widthAnchor.constraint(equalToConstant: 580)
        }

        self.stackViewWidthConstraint?.isActive = true
    }
    
    func updateBackgroundColor(_ ratio: Int, duration: TimeInterval = 0.15) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            let newBackgroundColor = BrewStrengthColor.colorFor(ratio)
            self.view.backgroundColor = newBackgroundColor
            KeyboardViewController.shared.updateBackgroundColor(newBackgroundColor)
        }, completion: nil)
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
            self.currentInput = .totalBrew

            grounds = Calculator.calculateGrounds(brew: total, ratio: ratio)
            water = Calculator.calculateWater(grounds: grounds, ratio: ratio)
            self.groundsInputView.textField.text = formatDoubleToString(grounds)
            self.waterInputView.textField.text = formatDoubleToString(water)

        case self.waterInputView.textField:
            self.currentInput = .water

            grounds = Calculator.calculateGrounds(water: water, ratio: ratio)
            total = Calculator.calculateBrew(grounds: grounds, water: water)
            self.groundsInputView.textField.text = formatDoubleToString(grounds)
            self.totalInputView.textField.text = formatDoubleToString(total)

        case self.groundsInputView.textField:
            self.currentInput = .grounds

            water = Calculator.calculateWater(grounds: grounds, ratio: ratio)
            total = Calculator.calculateBrew(grounds: grounds, water: water)
            self.waterInputView.textField.text = formatDoubleToString(water)
            self.totalInputView.textField.text = formatDoubleToString(total)

        case self.ratioInputView.textField:
            self.currentInput = .ratio

            water = Calculator.calculateWater(grounds: grounds, ratio: ratio)
            total = Calculator.calculateBrew(grounds: grounds, water: water)
            self.waterInputView.textField.text = formatDoubleToString(water)
            self.totalInputView.textField.text = formatDoubleToString(total)

        default:
            break
        }

        self.updateBackgroundColor(ratio)
        self.persistenceStore?.save(grounds: grounds, ratio: ratio)
    }

    @objc func handleSettingsButtonPress(_ sender: AnyObject?) {
        let settingsViewController = SettingsViewController(nibName: nil, bundle: nil)
        let navigationController = NavigationController(rootViewController: settingsViewController)
        navigationController.presentationController?.delegate = self

        self.present(navigationController, animated: true, completion: nil)
    }

}

extension CalculatorViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.beginInput()
    }

}
