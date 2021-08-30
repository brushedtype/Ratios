//
//  RoundedSettingsButtonStyle.swift
//  RoundedSettingsButtonStyle
//
//  Created by Edward Wellbrook on 30/08/2021.
//  Copyright © 2021 Brushed Type. All rights reserved.
//

import Foundation
import SwiftUI

struct RoundedSettingsButtonStyle: ButtonStyle {

    var corderRadius: CGFloat = 8


    func makeBody(configuration: Configuration) -> some View {
        Group {
            configuration.label
                .font(.application(size: 15, weight: .medium))
                .foregroundColor(Color(Theme.accentColor))
                .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(configuration.isPressed ? Theme.buttonHighlightColor : .clear))
        .overlay(RoundedRectangle(cornerRadius: self.corderRadius, style: .continuous)
                    .stroke(Color(Theme.buttonHighlightColor), lineWidth: 1)
                    .opacity(configuration.isPressed ? 0 : 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: self.corderRadius, style: .continuous))
        .animation(.easeOut(duration: configuration.isPressed ? 0 : 0.125))
    }

}
