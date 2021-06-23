//
//  ContentView.swift
//  DartSwiftUI
//
//  Created by Tejay Beckedorf on 18.06.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("What variant do you want to play?")
                    .padding()
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: GameView(currentGame: Game(301)),
                        label: {
                            Text("301")
                        })
                    Spacer()
                    NavigationLink(
                        destination: GameView(currentGame: Game(501)),
                        label: {
                            Text("501")
                        })
                    Spacer()
                }.buttonStyle(MenuButtonStyle())
                .navigationTitle("New Game")
                
                Spacer()
            }
        }
    }
}

//Debug and Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
