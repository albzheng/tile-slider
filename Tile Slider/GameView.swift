//
//  ContentView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 5/28/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: Game

    var body: some View {
        VStack{
            Text(game.board.title).font(.title)
            BoardView()
            .padding(50)
            .aspectRatio(1, contentMode: .fit)
            Button(action: {
                self.game.newGame()
            }, label: {
                Text("New Game").font(.system(.body, design: .rounded))
            })
        }
    }
}


struct BoardView: View{
    @EnvironmentObject var game: Game
    
    var body: some View{
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
        //.overlay(Rectangle().stroke(lineWidth: 2))
        //.shadow(radius: 3)
    }
    
    private func body(for size: CGSize) -> some View {
        let tile_width = Float(size.width)/Float(game.board.num_cols)
        let tile_height = Float(size.height)/Float(game.board.num_rows)
        let x_offset = tile_width / 2
        let y_offset = tile_height / 2
        
        return ZStack{
            Rectangle()
               .foregroundColor(Color.gray)
               .zIndex(-2)
            Rectangle()
                .stroke(lineWidth: 4)
                .foregroundColor(Color.gray)
                .zIndex(-2)
            ForEach(game.board.tiles) { tile in
                if tile.id > 0 {
                    Image(self.game.board.imageTitle + String(tile.id))
                        .resizable()
                        .overlay(Rectangle().stroke(lineWidth: 2).foregroundColor(Color.gray))
                        .overlay(Rectangle().stroke(lineWidth: 1).foregroundColor(Color.black))
                        .frame(width: CGFloat(tile_width), height: CGFloat(tile_height))
                        .position(x: CGFloat(Float(tile.x) * tile_width + x_offset), y: CGFloat(Float(tile.y) * tile_height + y_offset))
                        .onTapGesture {
                            print("Clicked")
                            let idx = self.game.board.tiles.firstIndex(matching: tile)!
                            self.game.board.moveTile(idx)
                    }
                    .animation(.easeInOut(duration: 0.5))
                } else if tile.id < 0 {
                    Rectangle()
                        .frame(width: CGFloat(tile_width), height: CGFloat(tile_height))
                        .position(x: CGFloat(Float(tile.x) * tile_width + x_offset), y: CGFloat(Float(tile.y) * tile_height + y_offset))
                        .foregroundColor(Color.white)
                        .zIndex(-1)
                }
            }
        }
    }
}

