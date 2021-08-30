//
//  KeyboardButtonStyle.swift
//  KeyboardButtonStyle
//
//  Created by Edward Wellbrook on 30/08/2021.
//  Copyright © 2021 Brushed Type. All rights reserved.
//

import Foundation
import SwiftUI

struct KeyboardButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        Group {
            configuration.label
                .font(.application(fixedSize: 22, weight: .medium))
                .foregroundColor(Color(Theme.accentColor))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color(configuration.isPressed ? Theme.keyboardButtonHighlightColor.withAlphaComponent(0.6) : Theme.keyboardButtonColor))
        .cornerRadius(5)
        .shadow(color: .black.opacity(0.15), radius: configuration.isPressed ? 0 : 3, x: 0, y: configuration.isPressed ? 0 : 1)
        .animation(.easeOut(duration: configuration.isPressed ? 0 : 0.125))
    }

}
