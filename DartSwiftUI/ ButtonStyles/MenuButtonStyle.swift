//
//  MenuButtonStyle.swift
//  DartSwiftUI
//
//  Created by Tejay Beckedorf on 18.06.21.
//

import Foundation
import SwiftUI

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .padding(15)
                .overlay(RoundedRectangle(
                            cornerRadius: 20.0)
                         .stroke(lineWidth: 2.0
                         )
                )
                .scaleEffect(configuration.isPressed ? 1.2 : 1.5)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}
