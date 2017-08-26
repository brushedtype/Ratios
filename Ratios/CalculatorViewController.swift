//
//  CalculatorViewController.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/01/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    let totalLabel = UILabel()
    let totalTextField = UITextField()
    let waterLabel = UILabel()
    let waterTextField = UITextField()
    let groundsLabel = UILabel()
    let groundsTextField = UITextField()
    let ratioLabel = UILabel()
    let ratioSelection = UITextField()

    var bottomConstraint: NSLayoutConstraint? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Calculator"
        self.view.backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            self.totalLabel,
            self.totalTextField,
            self.waterLabel,
            self.waterTextField,
            self.groundsLabel,
            self.groundsTextField,
            self.ratioLabel,
            self.ratioSelection
        ])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing

        self.view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true

        self.bottomConstraint = stackView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        self.bottomConstraint?.isActive = true

        self.totalLabel.text = "Total Brew"

        self.totalTextField.font = UIFont.monospacedDigitSystemFont(ofSize: 45, weight: .regular)
        self.totalTextField.keyboardType = .decimalPad
        self.totalTextField.addTarget(self, action: #selector(self.handleFieldValueChange), for: .editingChanged)
        self.totalTextField.backgroundColor = .lightGray
        self.totalTextField.layer.cornerRadius = 8

        self.waterLabel.text = "Water"

        self.waterTextField.font = UIFont.monospacedDigitSystemFont(ofSize: 45, weight: .regular)
        self.waterTextField.keyboardType = .decimalPad
        self.waterTextField.addTarget(self, action: #selector(self.handleFieldValueChange), for: .editingChanged)
        self.waterTextField.backgroundColor = .lightGray
        self.waterTextField.layer.cornerRadius = 8

        self.groundsLabel.text = "Grounds"

        self.groundsTextField.font = UIFont.monospacedDigitSystemFont(ofSize: 45, weight: .regular)
        self.groundsTextField.keyboardType = .decimalPad
        self.groundsTextField.addTarget(self, action: #selector(self.handleFieldValueChange), for: .editingChanged)
        self.groundsTextField.backgroundColor = .lightGray
        self.groundsTextField.layer.cornerRadius = 8

        self.ratioLabel.text = "Ratio"

        self.ratioSelection.text = "16:1"
        self.ratioSelection.isEnabled = false
        self.ratioSelection.font = UIFont.monospacedDigitSystemFont(ofSize: 45, weight: .regular)
        self.ratioSelection.keyboardType = .decimalPad
        self.ratioSelection.addTarget(self, action: #selector(self.handleFieldValueChange), for: .editingChanged)
        self.ratioSelection.backgroundColor = .lightGray
        self.ratioSelection.layer.cornerRadius = 8
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main) { (notification) in
            guard
                let userInfo = notification.userInfo,
                let endFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
                let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
                let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
            else {
                return
            }

            self.bottomConstraint?.constant = -endFrame.height
            self.view.setNeedsLayout()

            UIView.animate(withDuration: animationDuration, delay: 0, options: UIViewAnimationOptions(rawValue: animationCurve), animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    @objc func handleFieldValueChange(_ sender: AnyObject) {
        let total = Double(self.totalTextField.text ?? "0") ?? 0
        let water = Double(self.waterTextField.text ?? "0") ?? 0
        let grounds = Double(self.groundsTextField.text ?? "0") ?? 0
        let ratio = 16

        guard let field = sender as? UITextField else {
            return
        }

        switch field {
        case self.totalTextField:
            let newGrounds = Calculator.calculateGrounds(brew: total, ratio: ratio)
            self.groundsTextField.text = CalculatorViewController.formatDoubleToString(newGrounds)

        case self.waterTextField:
            let newGrounds = Calculator.calculateGrounds(water: water, ratio: ratio)
            let newBrew = Calculator.calculateBrew(grounds: newGrounds, water: water)
            self.groundsTextField.text = CalculatorViewController.formatDoubleToString(newGrounds)
            self.totalTextField.text = CalculatorViewController.formatDoubleToString(newBrew)

        case self.groundsTextField:
            let newWater = Calculator.calculateWater(grounds: grounds, ratio: ratio)
            let newBrew = Calculator.calculateBrew(grounds: grounds, water: newWater)
            self.waterTextField.text = CalculatorViewController.formatDoubleToString(newWater)
            self.totalTextField.text = CalculatorViewController.formatDoubleToString(newBrew)

        default:
            break
        }
    }

    static func formatDoubleToString(_ value: Double) -> String? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0

        return formatter.string(from: NSNumber(value: value))
    }

}
