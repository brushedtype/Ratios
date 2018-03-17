//
//  RatioColour.swift
//  Ratios
//
//  Created by Sasha Friedenberg on 03/17/2018.
//  Copyright © 2018 Brushed Type. All rights reserved.
//

import Foundation
import UIKit

struct BrewStrengthColour {
    static let strongBackgroundColour = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let weakBackgroundColour   = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    static let minRatio: Int = 12
    static let maxRatio: Int = 20
    
    static func colourFor(_ ratio: Int) -> UIColor {
        guard ratio < maxRatio else {
            //a ratio of 1/maxRatio produces a weaker brew
            return weakBackgroundColour
        }
        
        guard ratio > minRatio else {
            //a ratio of 1/minRatio produces a stronger brew
            return strongBackgroundColour
        }
        
        let colourOffsetFraction = CGFloat(Double(ratio - minRatio) / Double(maxRatio - minRatio))
        
        var minRed: CGFloat = 0
        var maxRed: CGFloat = 0
        
        var minGreen: CGFloat = 0
        var maxGreen: CGFloat = 0
        
        var minBlue: CGFloat = 0
        var maxBlue: CGFloat = 0
        
        strongBackgroundColour.getRed(&minRed, green: &minGreen, blue: &minBlue, alpha: nil)
        weakBackgroundColour.getRed(&maxRed, green: &maxGreen, blue: &maxBlue, alpha: nil)
        
        let getNewColour = { (min: CGFloat, max: CGFloat) -> CGFloat in
            return ((max - min) * colourOffsetFraction) + min
        }
        
        let newRed      = getNewColour(minRed,   maxRed)
        let newGreen    = getNewColour(minGreen, maxGreen)
        let newBlue     = getNewColour(minBlue,  maxBlue)
        
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }
    
    private init() {}
}
