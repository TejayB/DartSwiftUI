//
//  Trow.swift
//  DartSwiftUI
//
//  Created by Tejay Beckedorf on 18.06.21.
//

import Foundation

struct Throw{
    let pointsScored: Int;
    let throwNumber: Int;
    let thrownBy: Player
    
    init(_ points: Int, _ tNumber: Int, _ thrownBy: Player){
        self.pointsScored = points
        self.throwNumber = tNumber
        self.thrownBy = thrownBy
    }
    
    
}
