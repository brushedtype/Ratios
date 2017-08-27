//
//  PersistenceStore.swift
//  Ratios
//
//  Created by Edward Wellbrook on 27/08/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import Foundation

protocol PersistenceStore {
    func save(grounds: Double, ratio: Int)
    func getValues() -> (grounds: Double, ratio: Int)
}

extension UserDefaults: PersistenceStore {

    private static let ratiosPersistenceGroundsKey = "co.brushedtype.ratios.grounds"
    private static let ratiosPersistenceRatioKey = "co.brushedtype.ratios.ratio"


    func save(grounds: Double, ratio: Int) {
        self.set(grounds, forKey: UserDefaults.ratiosPersistenceGroundsKey)
        self.set(ratio, forKey: UserDefaults.ratiosPersistenceRatioKey)
    }

    func getValues() -> (grounds: Double, ratio: Int) {
        let grounds = self.double(forKey: UserDefaults.ratiosPersistenceGroundsKey)
        let ratio = self.integer(forKey: UserDefaults.ratiosPersistenceRatioKey)

        return (grounds: grounds, ratio: ratio > 0 ? ratio : 16)
    }

}
