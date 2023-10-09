//
//  PersistenceStore.swift
//  Ratios
//
//  Created by Edward Wellbrook on 27/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import Foundation

protocol PersistenceStore {
    func save(grounds: Double, ratio: Double)
    func getValues() -> (grounds: Double, ratio: Double)
}

extension UserDefaults: PersistenceStore {

    private static let ratiosPersistenceGroundsKey = "co.brushedtype.ratios.grounds"
    private static let ratiosPersistenceRatioKey = "co.brushedtype.ratios.ratio"

    func save(grounds: Double, ratio: Double) {
        self.set(grounds, forKey: UserDefaults.ratiosPersistenceGroundsKey)
        self.set(ratio, forKey: UserDefaults.ratiosPersistenceRatioKey)
    }

    func getValues() -> (grounds: Double, ratio: Double) {
        let grounds = self.double(forKey: UserDefaults.ratiosPersistenceGroundsKey)
        let ratio = self.double(forKey: UserDefaults.ratiosPersistenceRatioKey)

        let groundsOrFallback = grounds > 0 ? grounds : 12
        let ratioOrFallback = ratio > 0 ? ratio : 16

        return (grounds: groundsOrFallback, ratio: ratioOrFallback)
    }

}
