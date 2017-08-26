//
//  Calculator.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import Foundation

struct Calculator {

    static func calculateGrounds(brew: Double, ratio: Int) -> Double {
        return brew / Double(ratio - 2)
    }

    static func calculateGrounds(water: Double, ratio: Int) -> Double {
        return water / Double(ratio)
    }

    static func calculateWater(grounds: Double, ratio: Int) -> Double {
        return grounds * Double(ratio)
    }

    static func calculateBrew(grounds: Double, water: Double) -> Double {
        return water - (2 * grounds)
    }

}
