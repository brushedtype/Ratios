//
//  ShadowLayer.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.15
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }

}
