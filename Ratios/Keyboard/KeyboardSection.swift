//
//  KeyboardSection.swift
//  Ratios
//
//  Created by Edward Wellbrook on 03/09/2017.
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

        for view in sectionSubviews {
            self.addArrangedSubview(view)
        }
    }

}
