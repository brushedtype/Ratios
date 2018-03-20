//
//  ReviewHelper.swift
//  Ratios
//
//  Created by Edward Wellbrook on 19/03/2018.
//  Copyright © 2018 Brushed Type. All rights reserved.
//

import Foundation
import StoreKit

fileprivate struct DefaultsKeys {
    private init() {}

    static let currentValue = "co.brushedtype.ratios-review-currentValue"
    static let nextReviewDate = "co.brushedtype.ratios-review-next"
}

final class ReviewHelper {

    enum UseAmount: Int {
        case low    = 1
        case medium = 3
        case high   = 5
    }

    static let shared = ReviewHelper(userDefaults: .standard)

    private let userDefaults: UserDefaults

    private var allowRequest = false
    private var threshold = 5

    private var currentValue = 0 {
        didSet {
            self.checkAlertValue()
        }
    }

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.currentValue = self.userDefaults.integer(forKey: DefaultsKeys.currentValue)

        guard let nextReviewDate = self.userDefaults.value(forKey: DefaultsKeys.nextReviewDate) as? Date else {
            // set initial review timeout to be 3 days
            let nextReviewDate = Date().addingTimeInterval(60 * 60 * 24 * 3)
            self.userDefaults.set(nextReviewDate, forKey: DefaultsKeys.nextReviewDate)

            return
        }

        self.allowRequest = Date() > nextReviewDate
    }

    func incrementUse(_ amount: UseAmount) {
        self.currentValue += amount.rawValue
    }

    private func checkAlertValue() {
        self.userDefaults.set(self.currentValue, forKey: DefaultsKeys.currentValue)

        guard self.currentValue > self.threshold, self.allowRequest else {
            return
        }

        // disallow any further requests this session
        self.allowRequest = false

        SKStoreReviewController.requestReview()

        // set next review timeout for ~about 3 months time
        let nextReviewDate = Date().addingTimeInterval(60 * 60 * 24 * 30 * 3)
        self.userDefaults.set(nextReviewDate, forKey: DefaultsKeys.nextReviewDate)
    }

}
