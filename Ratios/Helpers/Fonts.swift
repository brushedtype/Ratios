//
//  Fonts.swift
//  Ratios
//
//  Created by Edward Wellbrook on 16/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

extension UIFont {

    private static let monospaceFontSettings: [[UIFontDescriptor.FeatureKey: Any]] = [
        [.featureIdentifier: kNumberSpacingType, .typeIdentifier: kMonospacedNumbersSelector],
        [.featureIdentifier: kAllTypographicFeaturesType, .typeIdentifier: true]
    ]

    private static let standardFontDescriptor = UIFontDescriptor(fontAttributes: [ .family: "Tofino Personal" ])
    private static let monospaceFontDescriptor = standardFontDescriptor.addingAttributes([ .featureSettings: monospaceFontSettings ])


    static func applicationFont(ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let traits: [UIFontDescriptor.TraitKey: Any] = [ .weight: weight ]
        return UIFont(descriptor: UIFont.standardFontDescriptor.addingAttributes([ .traits: traits ]), size: ofSize)
    }

    static func monospacedApplicationFont(ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let traits: [UIFontDescriptor.TraitKey: Any] = [ .weight: weight ]
        return UIFont(descriptor: UIFont.monospaceFontDescriptor.addingAttributes([ .traits: traits ]), size: ofSize)
    }

}
