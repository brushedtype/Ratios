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


    /// The normal keyboard button color
    static let keyboardButtonColor = UIColor(red:0.99, green:0.99, blue:0.98, alpha:1.0)

    /// The active/highlighted keyboard button color
    static let keyboardButtonHighlightColor = UIColor(red:0.77, green:0.70, blue:0.63, alpha:1.0)

    /// The application background color
    static let backgroundColor = UIColor(red:0.90, green:0.81, blue:0.72, alpha:1.0)

    /// The application tint and text color
    static let accentColor = UIColor(red:0.31, green:0.28, blue:0.25, alpha:1.0)

    /// A subtle version of the application text color
    static let subtleAccentColor  = Theme.accentColor.withAlphaComponent(0.8)

    /// The bordered button color
    static let buttonHighlightColor = Theme.accentColor.withAlphaComponent(0.4)

    /// The application shadow color
    static let shadowColor = UIColor.black

}
