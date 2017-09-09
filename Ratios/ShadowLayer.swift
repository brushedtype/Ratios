//
//  ShadowLayer.swift
//  Ratios
//
//  Created by Edward Wellbrook on 09/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

class ShadowLayer: CAShapeLayer {

    override init() {
        super.init()

        self.fillColor = UIColor.white.cgColor
        self.shadowColor = UIColor.black.cgColor
        self.shadowRadius = 3
        self.shadowOffset = CGSize(width: 0, height: 1)
        self.shadowOpacity = 0.15
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
