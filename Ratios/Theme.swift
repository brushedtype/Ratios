//
//  Theme.swift
//  Ratios
//
//  Created by Edward Wellbrook on 20/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

struct Theme {
    private init() {}

    static let keyboardButtonColour = UIColor(red:0.98, green:0.96, blue:0.93, alpha:1.0)
    static let keyboardButtonHighlightColour = UIColor(red:0.77, green:0.70, blue:0.63, alpha:1.0)
    static let backgroundColour = UIColor(red: 0.87256, green: 0.79711, blue: 0.71713, alpha: 1.0)
    static let accentColour = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)
    static let subtleAccentColour = Theme.accentColour.withAlphaComponent(0.8)
    static let buttonHighlightColour = Theme.accentColour.withAlphaComponent(0.4)
    static let shadowColour = UIColor.black
}
