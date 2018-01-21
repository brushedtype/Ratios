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
    static let strongBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let weakBackgroundColor   = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    static let minRatio: Int = 12
    static let maxRatio: Int = 20
    
    static func colorFor(_ ratio: Int) -> UIColor {
        guard ratio < maxRatio else {
            //a ratio of 1/maxRatio produces a weaker brew
            return weakBackgroundColor
        }
        
        guard ratio > minRatio else {
            //a ratio of 1/minRatio produces a stronger brew
            return strongBackgroundColor
        }
        
        let colorOffsetFraction = CGFloat(Double(ratio - minRatio) / Double(maxRatio - minRatio))
        
        var minRed: CGFloat = 0
        var maxRed: CGFloat = 0
        
        var minGreen: CGFloat = 0
        var maxGreen: CGFloat = 0
        
        var minBlue: CGFloat = 0
        var maxBlue: CGFloat = 0
        
        strongBackgroundColor.getRed(&minRed, green: &minGreen, blue: &minBlue, alpha: nil)
        weakBackgroundColor.getRed(&maxRed, green: &maxGreen, blue: &maxBlue, alpha: nil)
        
        let getNewColor = { (min: CGFloat, max: CGFloat) -> CGFloat in
            return ((max - min) * colorOffsetFraction) + min
        }
        
        let newRed      = getNewColor(minRed,   maxRed)
        let newGreen    = getNewColor(minGreen, maxGreen)
        let newBlue     = getNewColor(minBlue,  maxBlue)
        
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }
    
    private init() {}
}
