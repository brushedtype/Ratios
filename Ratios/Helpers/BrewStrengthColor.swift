//
//  RatioColour.swift
//  Ratios
//
//  Created by Sasha Friedenberg on 03/17/2018.
//  Copyright © 2018 Brushed Type. All rights reserved.
//

import Foundation
import UIKit

struct BrewStrengthColor {

    static let weakBackgroundColor = UIColor(red: 0.90, green: 0.81, blue: 0.72, alpha: 1.0)
    static let strongBackgroundColor = UIColor(red: 0.80, green: 0.67, blue: 0.56, alpha: 1.0)
    
    static let minRatio: Int = 12
    static let maxRatio: Int = 20
    
    static func colorFor(_ ratio: Int) -> UIColor {
        guard ratio < maxRatio else {
            // a ratio of 1/maxRatio produces a weaker brew
            return BrewStrengthColor.weakBackgroundColor
        }
        
        guard ratio > minRatio else {
            // a ratio of 1/minRatio produces a stronger brew
            return BrewStrengthColor.strongBackgroundColor
        }
        
        let colorOffsetFraction = CGFloat(Double(ratio - minRatio) / Double(maxRatio - minRatio))
        
        var minRed: CGFloat = 0
        var maxRed: CGFloat = 0
        
        var minGreen: CGFloat = 0
        var maxGreen: CGFloat = 0
        
        var minBlue: CGFloat = 0
        var maxBlue: CGFloat = 0
        
        BrewStrengthColor.strongBackgroundColor.getRed(&minRed, green: &minGreen, blue: &minBlue, alpha: nil)
        BrewStrengthColor.weakBackgroundColor.getRed(&maxRed, green: &maxGreen, blue: &maxBlue, alpha: nil)
        
        let getNewColor = { (min: CGFloat, max: CGFloat) -> CGFloat in
            return ((max - min) * colorOffsetFraction) + min
        }
        
        let newRed = getNewColor(minRed, maxRed)
        let newGreen = getNewColor(minGreen, maxGreen)
        let newBlue = getNewColor(minBlue, maxBlue)
        
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }
    
    private init() {}
}
