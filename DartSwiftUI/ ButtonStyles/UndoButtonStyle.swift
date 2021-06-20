//
//  UndoButtonStyle.swift
//  DartSwiftUI
//
//  Created by Tejay Beckedorf on 19.06.21.
//

import SwiftUI

struct UndoButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(10)
                .overlay(RoundedRectangle(
                            cornerRadius: 5.0)
                         .stroke(lineWidth: 2.0
                         )
                )
                .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}
