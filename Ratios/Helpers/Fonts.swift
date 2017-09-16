//
//  Fonts.swift
//  Ratios
//
//  Created by Edward Wellbrook on 16/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import UIKit

fileprivate struct Fonts {
    private init() {}

    private static let monospaceFontSettings: [[UIFontDescriptor.FeatureKey: Any]] = [
        [.featureIdentifier: kNumberSpacingType, .typeIdentifier: kMonospacedNumbersSelector],
        [.featureIdentifier: kAllTypographicFeaturesType, .typeIdentifier: true]
    ]

    fileprivate static let standardFontDescriptor = UIFontDescriptor(fontAttributes: [ .family: "Tofino Personal" ])
    fileprivate static let monospaceFontDescriptor = standardFontDescriptor.addingAttributes([ .featureSettings: monospaceFontSettings ])
}

extension UIFont {

    static func applicationFont(ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let traits: [UIFontDescriptor.TraitKey: Any] = [ .weight: weight ]
        return UIFont(descriptor: Fonts.standardFontDescriptor.addingAttributes([ .traits: traits ]), size: ofSize)
    }

    static func monospacedApplicationFont(ofSize: CGFloat) -> UIFont {
        return UIFont(descriptor: Fonts.monospaceFontDescriptor, size: ofSize)
    }

}
