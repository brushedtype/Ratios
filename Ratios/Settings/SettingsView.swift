//
//  SettingsView.swift
//  SettingsView
//
//  Created by Edward Wellbrook on 30/08/2021.
//  Copyright © 2021 Brushed Type. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingsView: View {

    let aboutRatiosButtonAction: () -> Void
    let aboutFontButtonAction: () -> Void
    let aboutFontAuthorButtonAction: () -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 48) {
                Text("Ratios")
                    .font(.application(size: 48, weight: .thin))
                    .foregroundColor(Color(Theme.accentColor))

                VStack(spacing: 16) {
                    Text(
                        """
                        Ratios is free and open source. If there's a feature that you think is missing, \
                        or something doesn't work right, you can help improve the app on GitHub.
                        """
                    )
                        .multilineTextAlignment(.center)
                        .font(.application(size: 16, weight: .light))
                        .foregroundColor(Color(Theme.accentColor))

                    Button(action: self.aboutRatiosButtonAction) {
                        Text("Contribute on GitHub")
                    }.buttonStyle(RoundedSettingsButtonStyle())
                }

                VStack(spacing: 16) {
                    Text(
                        """
                        Ratios uses the wonderful Tofino typeface by Alanna Munro. \
                        Support Alanna's work, and consider using Tofino in your own projects.
                        """
                    )
                        .multilineTextAlignment(.center)
                        .font(.application(size: 16, weight: .light))
                        .foregroundColor(Color(Theme.accentColor))

                    HStack(spacing: 8) {
                        Button(action: self.aboutFontButtonAction) {
                            Text("About Tofino")
                        }.buttonStyle(RoundedSettingsButtonStyle())

                        Button(action: self.aboutFontAuthorButtonAction) {
                            Text("About Alanna")
                        }.buttonStyle(RoundedSettingsButtonStyle())
                    }
                }

                Text("\(AppInfo.shared.name) v\(AppInfo.shared.version) (\(AppInfo.shared.build))")
                    .font(.application(size: 13, weight: .medium))
                    .foregroundColor(Color(Theme.subtleAccentColor))

                Spacer()
            }
            .frame(maxWidth: 480)
            .padding()
        }
    }

}
