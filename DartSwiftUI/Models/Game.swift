//
//  Game.swift
//  DartSwiftUI
//
//  Created by Tejay Beckedorf on 18.06.21.
//

import Foundation

class Game {
    private var players:[Player] = []
    private var startingPoints: Int = 0
    private var currentNumberOfThrows: Int = 0
    private var throwHistory: [Throw] = []
    private var currentPlayerIndex: Int
    
    
    init(_ startingPoints: Int) {
        self.players.append(Player("Player 1", startingPoints, 0))
        self.players.append(Player("Player 2", startingPoints, 1))
        self.currentPlayerIndex = players[0].getPlayerIndex()
        self.startingPoints = self.players[0].getRemainingPoints()
    }
    
    
    func tryThrow(_ pointsHit:Int) -> Bool{
        if(pointsHit < 75){
            let currentPlayer:Player = getCurrentPlayer()
            
            if (currentPlayer.getRemainingPoints() - pointsHit >= 0){
                currentPlayer.setRemainingPoints(currentPlayer.getRemainingPoints() - pointsHit)
                throwHistory.append(Throw(pointsHit, currentNumberOfThrows, currentPlayer))
                if (currentPlayer.getRemainingPoints() == 0) {
                    return true
                }
                currentNumberOfThrows = (currentNumberOfThrows % 3) + 1
                if (currentNumberOfThrows == 3){
                    setNextPlayer()
                }
            }
            else {
                if (self.currentNumberOfThrows == 0){
                    setNextPlayer()
                }else if (self.currentNumberOfThrows == 1){
                    undoThrow()
                    setNextPlayer()
                }else if (self.currentNumberOfThrows == 2){
                    undoThrow()
                    undoThrow()
                    setNextPlayer()
                }else if (self.currentNumberOfThrows == 3){
                    setNextPlayer()
                }
            }
        }
        return false
    }
    
    func undoThrow(){
        let lastThrow: Throw = self.throwHistory.popLast() ?? Throw(-1, 0, players[0])
        let lastThrowPoints = lastThrow.pointsScored
        currentNumberOfThrows = lastThrow.throwNumber
        currentPlayerIndex = lastThrow.thrownBy.getPlayerIndex()
        
        if lastThrowPoints >= 0 {
            let currentRemainingPoints: Int = self.getCurrentPlayer().getRemainingPoints()
            self.getCurrentPlayer().setRemainingPoints(currentRemainingPoints + lastThrowPoints)
        }
    }
    
    
    func getCurrentPlayerIndex() -> Int{
        return currentPlayerIndex
    }
    
    
    func setNextPlayer(){
        currentPlayerIndex = (getCurrentPlayer().getPlayerIndex()+1) % 2
    }
    
    func getPlayer(_ playerIndex: Int) -> Player{
        return players[playerIndex]
    }
    
    func getCurrentPlayer() -> Player{
        return players[currentPlayerIndex]
    }
    
    func setCurrentPlayer(_ currentPlayer: Player){
        currentPlayerIndex = currentPlayer.getPlayerIndex()
    }
    
    func getCurrentNumberOfThrows() -> Int{
        return currentNumberOfThrows
    }
}
