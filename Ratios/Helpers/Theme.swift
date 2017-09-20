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


    /// The normal keyboard button colour
    static let keyboardButtonColour = UIColor(red:0.99, green:0.99, blue:0.98, alpha:1.0)

    /// The active/highlighted keyboard button colour
    static let keyboardButtonHighlightColour = UIColor(red:0.77, green:0.70, blue:0.63, alpha:1.0)

    /// The application background colour
    static let backgroundColour = UIColor(red: 0.87256, green: 0.79711, blue: 0.71713, alpha: 1.0)

    /// The application tint and text colour
    static let accentColour = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)

    /// A subtle version of the application text colour
    static let subtleAccentColour  = Theme.accentColour.withAlphaComponent(0.8)

    /// The bordered button colour
    static let buttonHighlightColour = Theme.accentColour.withAlphaComponent(0.4)

    /// The application shadow colour
    static let shadowColour = UIColor.black

}
