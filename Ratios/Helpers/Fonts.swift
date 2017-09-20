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

    private static let standardFontDescriptor = UIFontDescriptor(fontAttributes: [:])
    private static let monospaceFontDescriptor = standardFontDescriptor.addingAttributes([ .featureSettings: monospaceFontSettings ])

    private static func fontName(for weight: UIFont.Weight) -> String {
        switch weight {
        case .regular:
            return "TofinoPersonal-Regular"
        case .medium:
            return "TofinoPersonal-Medium"
        case .light:
            return "TofinoPersonal-Book"
        case .thin:
            return "TofinoPersonal-Light"
        default:
            return "TofinoPersonal-Regular"
        }
    }


    static func applicationFont(ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let descriptor = UIFont.standardFontDescriptor.addingAttributes([
            .name: UIFont.fontName(for: weight)
        ])

        return UIFont(descriptor: descriptor, size: ofSize)
    }

    static func monospacedApplicationFont(ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let descriptor = UIFont.monospaceFontDescriptor.addingAttributes([
            .name: UIFont.fontName(for: weight)
        ])

        return UIFont(descriptor: descriptor, size: ofSize)
    }

}
