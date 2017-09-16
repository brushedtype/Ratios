//
//  AppInfo.swift
//  Ratios
//
//  Created by Edward Wellbrook on 16/09/2017.
//  Copyright © 2017 Brushed Type. All rights reserved.
//

import Foundation

struct AppInfo {

    static let shared = AppInfo(bundle: Bundle.main)


    private let bundle: Bundle

    var name: String {
        return self.bundle.infoDictionary!["CFBundleName"] as! String
    }

    var version: String {
        return self.bundle.infoDictionary!["CFBundleShortVersionString"] as! String
    }

    var build: String {
        return self.bundle.infoDictionary!["CFBundleVersion"] as! String
    }

    private init(bundle: Bundle) {
        self.bundle = bundle
    }

}
