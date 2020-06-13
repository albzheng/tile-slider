//
//  GameStore.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/4/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

class GameStore: ObservableObject{
    let boardCollection = [
        Board(title: "Bulbasaur", id: 1, imageTitle: "Bulb", num_rows: 4, num_cols: 4,
              board_state: [[-1,2,3,-2],[5,6,7,8],[9,10,11,12],[-3,0,14,-4]],
              initial_state: [[-1,2,3,-2],[5,6,7,8],[9,10,11,12],[-3,0,14,-4]],
              winning_state: [[-1,2,3,-2],[5,6,7,8],[9,10,11,12],[-3,14,0,-4]]),
        Board(title: "Charmandar", id: 2, imageTitle: "Charmandar", num_rows: 3, num_cols: 3,
              board_state: [[1,2,3],[4,5,6],[7,0,8]],
              initial_state: [[1,2,3],[4,5,6],[7,0,8]],
              winning_state: [[1,2,3],[4,5,6],[7,8,0]]),
        Board(title: "Squirtle", id: 3, imageTitle: "Squirtle", num_rows: 3, num_cols: 6,
              board_state: [[1,2,3,4,5,6],[7,8,9,10,11,12],[13,14,15,16,0,17]],
              initial_state: [[1,2,3,4,5,6],[7,8,9,10,11,12],[13,14,15,16,0,17]],
              winning_state: [[1,2,3,4,5,6],[7,8,9,10,11,12],[13,14,15,16,17,0]])
    ]
}
