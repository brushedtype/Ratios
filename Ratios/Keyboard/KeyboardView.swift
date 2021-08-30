//
//  KeyboardView.swift
//  KeyboardView
//
//  Created by Edward Wellbrook on 30/08/2021.
//  Copyright © 2021 Brushed Type. All rights reserved.
//

import Foundation
import SwiftUI

enum KeyboardButtonValue {
    case literal(String)
    case delete
}

extension KeyboardButtonValue: Equatable, Hashable {

    static func == (lhs: KeyboardButtonValue, rhs: KeyboardButtonValue) -> Bool {
        switch (lhs, rhs) {
        case (.delete, .delete):
            return true
        case (.literal(let lhs), .literal(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .delete:
            hasher.combine("delete")
        case .literal(let value):
            hasher.combine(value)
        }
    }

}

private let keyboardRows: [[KeyboardButtonValue]] = [
    [.literal("1"), .literal("2"), .literal("3")],
    [.literal("4"), .literal("5"), .literal("6")],
    [.literal("7"), .literal("8"), .literal("9")],
    [.literal("."), .literal("0"), .delete]
]

struct KeyboardView: View {

    let handleKeyPress: (KeyboardButtonValue) -> Void

    var body: some View {
        VStack(spacing: 6) {
            ForEach(keyboardRows, id: \.self) { columns in
                HStack(alignment: .top, spacing: 6) {
                    ForEach(columns, id: \.self) { buttonValue in
                        KeyboardView.buttonView(for: buttonValue, action: self.handleKeyPress)
                    }
                }
            }
        }
    }

}

extension KeyboardView {

    fileprivate static func buttonView(for buttonValue: KeyboardButtonValue, action: @escaping (KeyboardButtonValue) -> Void) -> some View {
        Button(action: { action(buttonValue) }) {
            switch buttonValue {
            case .literal(let value):
                Text(verbatim: value)
            case .delete:
                Image("backspace")
            }
        }
        .buttonStyle(KeyboardButtonStyle())
    }

}
