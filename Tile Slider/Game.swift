//
//  Game.swift
//  Tile Slider
//
//  Created by Albert Zheng on 5/29/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

class Game: ObservableObject {
    @Published var board: Board
    
    init (board: Board){
        self.board = board
    }
    
    func newGame(){
        self.board.board_state = self.board.winning_state
        self.board.tiles = []
        for row in 0..<self.board.num_rows {
            for col in 0..<self.board.num_cols {
                self.board.tiles.append(Tile(id: self.board.board_state[row][col], x: col, y: row))
            }
        }
    }
}
