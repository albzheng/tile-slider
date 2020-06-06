//
//  Board.swift
//  Tile Slider
//
//  Created by Albert Zheng on 5/29/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import Foundation
import AVFoundation


struct Board: Identifiable {
    var id: Int
    var title: String
    var imageTitle: String
    var num_rows: Int
    var num_cols: Int
    var board_state: [[Int]]
    let winning_state: [[Int]]
    
    var tiles: [Tile]
    
    //TO DO
    var empty_tile_idx: Int {
        tiles.count - 1
    }
    var won: Bool {
        board_state == winning_state
    }
    
    
    init (title: String, id: Int, imageTitle: String, num_rows: Int, num_cols: Int, board_state: [[Int]], winning_state: [[Int]]){
        self.title = title
        self.id = id
        self.imageTitle = imageTitle
        self.num_rows = num_rows
        self.num_cols = num_cols
        self.board_state = board_state
        self.winning_state = winning_state
        self.tiles = []
        
        for row in 0..<num_rows {
            for col in 0..<num_cols {
                self.tiles.append(Tile(id: board_state[row][col], x: col, y: row))
            }
        }
    }
    
    
    mutating func moveTile(_ idx: Int){
        print("Moving Tile " + String(tiles[idx].id))
        let x = tiles[idx].x
        let y = tiles[idx].y
        if (abs(tiles[empty_tile_idx].x - x) + abs(tiles[empty_tile_idx].y - y) == 1){
            swapTileWithEmpty(tile_idx: idx)
        }
    }
    
    
    mutating func swapTileWithEmpty(tile_idx idx: Int){
        board_state[tiles[empty_tile_idx].y][tiles[empty_tile_idx].x] = tiles[idx].id
        board_state[tiles[idx].y][tiles[idx].x] = tiles[empty_tile_idx].id
        
        let empty_x = tiles[empty_tile_idx].x
        let empty_y = tiles[empty_tile_idx].y
        tiles[empty_tile_idx].x = tiles[idx].x
        tiles[empty_tile_idx].y = tiles[idx].y
        tiles[idx].x = empty_x
        tiles[idx].y = empty_y
        
        let soundId = [1155,1156].randomElement()!
        AudioServicesPlaySystemSound (SystemSoundID(soundId))
    }
}


struct Tile : Identifiable {
    var id: Int
    var x: Int
    var y: Int
}

