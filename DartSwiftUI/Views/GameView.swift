//
//  GameView.swift
//  DartSwiftUI
//
//  Created by Tejay Beckedorf on 18.06.21.
//

import SwiftUI



struct GameView: View {
    @StateObject var currentGame: Game

    @State private var counterPlayer1Color: Color = .green
    @State private var counterPlayer2Color: Color = .red
    
    @State private var selectedMultiplierIndex = 0
    @State private var button25Opacity: Double = 1.0
    
    @State private var throwIndicator1Opacity = 1.0
    @State private var throwIndicator2Opacity = 0.25
    @State private var throwIndicator3Opacity = 0.25
    
    @State private var showingWinnigAlert = false
    @State private var showingWelcomeAlert = true
    @State private var gameOver = false
    
    
    var body: some View {
        let textCounterPlayer1: Text = Text("\(currentGame.getPlayer(0).getRemainingPoints())")
        let textCounterPlayer2: Text = Text("\(currentGame.getPlayer(1).getRemainingPoints())")
    
        VStack {
            // Player Label
            HStack {
                VStack {
                    Text("Player 1")
                        .padding(10)
                    
                    textCounterPlayer1
                        .foregroundColor(counterPlayer1Color)
                }.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                VStack {
                    Text("Player 2")
                        .padding(10)
                    textCounterPlayer2
                        .foregroundColor(counterPlayer2Color)
                }.font(.title)
            }.padding(10)
            
            // Undo
            Button("Undo", action: undo)
                .buttonStyle(UndoButtonStyle())
            
            //ThrowIndicator
            HStack {
                Text("🎯").padding(20)
                    .opacity(throwIndicator1Opacity)
                Text("🎯").padding(20)
                    .opacity(throwIndicator2Opacity)
                Text("🎯").padding(20)
                    .opacity(throwIndicator3Opacity)
            }.padding(10)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            //MultiplierPicker
            Picker("MultiplierPicker", selection: $selectedMultiplierIndex, content: {
                Text("1").tag(0)
                Text("2").tag(1)
                Text("3").tag(2)
            }).pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedMultiplierIndex, perform: { value in
                if (value == 2) {
                    button25Opacity = 0.2
                } else {
                    button25Opacity = 1
                }
            })
            
            VStack {
                HStack {
                    Spacer()
                    Button("1", action: {
                            onThrowButtonPressed(1)
                    })
                    Spacer()
                    Button("2", action: {
                        onThrowButtonPressed(2)
                    })
                    Spacer()
                    Button("3", action: {
                            onThrowButtonPressed(3)
                    })
                    Spacer()
                    Button("4", action: {
                            onThrowButtonPressed(4)
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("5", action: {
                        onThrowButtonPressed(5)
                    })
                    Spacer()
                    Button("6", action: {
                        onThrowButtonPressed(6)
                    })
                    Spacer()
                    Button("7", action: {
                        onThrowButtonPressed(7)
                    })
                    Spacer()
                    Button("8", action: {
                        onThrowButtonPressed(8)
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("9", action: {
                        onThrowButtonPressed(9)
                    })
                    Spacer()
                    Button("10", action: {
                        onThrowButtonPressed(10)
                    })
                    Spacer()
                    Button("11", action: {
                        onThrowButtonPressed(11)
                    })
                    Spacer()
                    Button("12", action: {
                        onThrowButtonPressed(12)
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("13", action: {
                        onThrowButtonPressed(13)
                    })
                    Spacer()
                    Button("14", action: {
                        onThrowButtonPressed(14)
                        
                    })
                    Spacer()
                    Button("15", action: {
                        onThrowButtonPressed(15)
                    })
                    Spacer()
                    Button("16", action: {
                        onThrowButtonPressed(16)
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("17", action: {
                        onThrowButtonPressed(17)
                    })
                    Spacer()
                    Button("18", action: {
                        onThrowButtonPressed(18)
                    })
                    Spacer()
                    Button("19", action: {
                        onThrowButtonPressed(19)
                    })
                    Spacer()
                    Button("20", action: {
                        onThrowButtonPressed(20)
                    })
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("25", action: {
                        onThrowButtonPressed(25)
                    }).disabled(selectedMultiplierIndex == 2)
                    .opacity(button25Opacity)
                    
                    Spacer()
                    Button("Miss", action: {
                        onThrowButtonPressed(0)
                    })
                    Spacer()
                }
            }.buttonStyle(GameButtonStyle())
            .alert(isPresented: $showingWinnigAlert, content: {
                Alert(
                    title: Text("🏆 You won! 🏆"),
                    message: Text(currentGame.getCurrentPlayer().getName() + " wins!"),
                    dismissButton: .default(Text("Dismiss")) {
                        gameOver = true
                        showingWinnigAlert = false
                        refreshUI()
                    }
                )
            })
            
            //Bottom Spacer
            Spacer()
        }
    }
    
    func onThrowButtonPressed(_ points: Int) {
        if (!gameOver) {
            var currentMultiplier: Int = selectedMultiplierIndex + 1
            showingWinnigAlert = currentGame.tryThrow(points * currentMultiplier)
            
            if ((points * currentMultiplier) == 75){
                currentMultiplier = 3
                selectedMultiplierIndex = 2
            }else{
                refreshUI();
            }
        }
    }
    
    func undo() {
        gameOver = false
        currentGame.undoThrow()
        refreshUI()
    }
    
    func refreshUI() {
        resetMulitiplier()
        changeColorPoints()
        toogleThrowIndicators()
    }
    
    func resetMulitiplier() {
        selectedMultiplierIndex = 0
    }
    
    func changeColorPoints() {
        if (currentGame.getCurrentPlayerIndex() == 0){
            counterPlayer1Color = .green
            counterPlayer2Color = .red
        } else {
            counterPlayer1Color = .red
            counterPlayer2Color = .green
        }
    }
    
    func toogleThrowIndicators() {
        switch currentGame.getCurrentNumberOfThrows()+1 {
        
        case 1:
            throwIndicator1Opacity = 1
            throwIndicator2Opacity = 0.25
            throwIndicator3Opacity = 0.25
            
        case 2:
            throwIndicator1Opacity = 1
            throwIndicator2Opacity = 1
            throwIndicator3Opacity = 0.25
            
        case 3:
            throwIndicator1Opacity = 1
            throwIndicator2Opacity = 1
            throwIndicator3Opacity = 1
 
        default:
            throwIndicator1Opacity = 1
            throwIndicator2Opacity = 0.25
            throwIndicator3Opacity = 0.25
        }
    }
}

struct GameView301_Previews: PreviewProvider {
    static var previews: some View {
        GameView(currentGame: Game(301))
    }
}

