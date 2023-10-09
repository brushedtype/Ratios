//
//  Calculator.swift
//  Ratios
//
//  Created by Edward Wellbrook on 26/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import Foundation

struct Calculator {

    static func calculateGrounds(brew: Double, ratio: Double) -> Double {
        guard ratio > 2 else {
            return 0
        }
        return brew / Double(ratio - 2)
    }

    static func calculateGrounds(water: Double, ratio: Double) -> Double {
        guard ratio > 0 else {
            return 0
        }
        return water / Double(ratio)
    }

    static func calculateWater(grounds: Double, ratio: Double) -> Double {
        return grounds * Double(ratio)
    }

    static func calculateBrew(grounds: Double, water: Double) -> Double {
        return max(water - (2 * grounds), 0)
    }

}
