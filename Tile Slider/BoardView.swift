//
//  BoardView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/10/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI
import AVFoundation


struct BoardView: View{
    @EnvironmentObject var game: Game
    @EnvironmentObject var settings: Settings
    @Environment(\.colorScheme) var colorScheme
    @State var draggedTileId: Int = 1000
    
    let soundId = [1155,1156]
    
    var body: some View{
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        let tile_width = Float(size.width)/Float(game.board.num_cols)
        let tile_height = Float(size.height)/Float(game.board.num_rows)
        let x_offset: Float = tile_width / 2
        let y_offset: Float = tile_height / 2
        
        //Identify the horizontal and vertical bounds for a tile to be dragged
        var min_drag_x: Float = 0.0
        var min_drag_y: Float = 0.0
        var max_drag_x: Float = 0.0
        var max_drag_y: Float = 0.0

        if draggedTileId != 1000 {
            var draggedTileIdx = 0
            for index in 0..<game.board.tiles.count {
                if game.board.tiles[index].id == draggedTileId {
                    draggedTileIdx = index
                }
            }
            
            let x = game.board.tiles[draggedTileIdx].x
            let y = game.board.tiles[draggedTileIdx].y
            
            if abs(game.board.tiles[game.board.empty_tile_idx].x - x) + abs(game.board.tiles[game.board.empty_tile_idx].y - y) == 1 {
                if game.board.tiles[game.board.empty_tile_idx].x - x == 1 {
                    min_drag_x = 0
                    max_drag_x = tile_width
                }else if game.board.tiles[game.board.empty_tile_idx].x - x == -1 {
                    min_drag_x = -tile_width
                    max_drag_x = 0
                }
                
                if game.board.tiles[game.board.empty_tile_idx].y - y == 1 {
                    min_drag_y = 0
                    max_drag_y = tile_height
                }else if game.board.tiles[game.board.empty_tile_idx].y - y == -1 {
                    min_drag_y = -tile_height
                    max_drag_y = 0
                }
            }
        }
        
        
        return ZStack{
            
            Rectangle()
               .foregroundColor(Color.gray)
               .zIndex(-2)
             
            ForEach(game.board.tiles) { tile in
                if tile.id > 0 {
                    TileView(tile: tile)
                        .frame(width: CGFloat(tile_width), height: CGFloat(tile_height))
                        .position(x: tile.id == self.draggedTileId ? CGFloat(Float(tile.x) * tile_width + x_offset +                    min(max(Float(self.gesturePanOffset.width),min_drag_x),max_drag_x)): CGFloat(Float(tile.x) * tile_width + x_offset),
                                  y: tile.id == self.draggedTileId ? CGFloat(Float(tile.y) * tile_height + y_offset + min(max(Float(self.gesturePanOffset.height),min_drag_y),max_drag_y)): CGFloat(Float(tile.y) * tile_height + y_offset))
                        .gesture(self.panGesture(tile: tile, tileWidth: tile_width, tileHeight: tile_height))
                        .onTapGesture {
                            print("Clicked")
                            let idx = self.game.board.tiles.firstIndex(matching: tile)!
                            withAnimation (.easeInOut(duration: 0.25)) {
                                self.game.moveTile(idx)
                                if self.settings.sound {
                                    AudioServicesPlaySystemSound(SystemSoundID(self.soundId.randomElement()!))
                                }
                                if self.settings.vibration {
                                    AudioServicesPlaySystemSound(1519)
                                }
                            }
                        }
                            
                            
                } else if tile.id < 0 {
                    Rectangle()
                        .frame(width: CGFloat(tile_width), height: CGFloat(tile_height))
                        .position(x: CGFloat(Float(tile.x) * tile_width + x_offset), y: CGFloat(Float(tile.y) * tile_height + y_offset))
                        .foregroundColor(self.colorScheme == .dark ? Color.black : Color.white)
                        .zIndex(-1)
                } else if (tile.id == 0) && (self.game.won){
                    TileView(tile: tile)
                        .frame(width: CGFloat(tile_width), height: CGFloat(tile_height))
                        .position(x: CGFloat(Float(tile.x) * tile_width + x_offset), y: CGFloat(Float(tile.y) * tile_height + y_offset))
                        .transition(
                            AnyTransition.scale
                            .combined(with: AnyTransition.offset(x: CGFloat(Float(tile.x) * tile_width - 2 * x_offset), y: CGFloat(Float(tile.y) * tile_height - 2 * y_offset)))
                    )
                }
            }
        }
    }
    
    @GestureState private var gesturePanOffset: CGSize = .zero
    
    private func panGesture(tile: Tile, tileWidth: Float, tileHeight: Float) -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation
                
        }
        .onChanged{ _ in self.draggedTileId = tile.id}
        .onEnded { finalDragGestureValue in
            var draggedTileIdx = 0
            for index in 0..<self.game.board.tiles.count {
                if self.game.board.tiles[index].id == self.draggedTileId {
                    draggedTileIdx = index
                }
            }
            
            
            let x = self.game.board.tiles[draggedTileIdx].x
            let y = self.game.board.tiles[draggedTileIdx].y
            
            if self.game.board.tiles[self.game.board.empty_tile_idx].x - x == 1 {
                if Float(finalDragGestureValue.predictedEndTranslation.width) > tileWidth/2 {
                    self.game.moveTile(draggedTileIdx)
                    if self.settings.sound {
                        AudioServicesPlaySystemSound(SystemSoundID(self.soundId.randomElement()!))
                    }
                    if self.settings.vibration {
                        AudioServicesPlaySystemSound(1519)
                    }
                }
            } else if self.game.board.tiles[self.game.board.empty_tile_idx].x - x == -1 {
                if Float(finalDragGestureValue.predictedEndTranslation.width) < -tileWidth/2 {
                    self.game.moveTile(draggedTileIdx)
                    if self.settings.sound {
                        AudioServicesPlaySystemSound(SystemSoundID(self.soundId.randomElement()!))
                    }
                    if self.settings.vibration {
                        AudioServicesPlaySystemSound(1519)
                    }
                }
            }
            if self.game.board.tiles[self.game.board.empty_tile_idx].y - y == 1 {
                if Float(finalDragGestureValue.predictedEndTranslation.height) > tileHeight/2 {
                    self.game.moveTile(draggedTileIdx)
                    if self.settings.sound {
                        AudioServicesPlaySystemSound(SystemSoundID(self.soundId.randomElement()!))
                    }
                    if self.settings.vibration {
                        AudioServicesPlaySystemSound(1519)
                    }
                }
            }else if self.game.board.tiles[self.game.board.empty_tile_idx].y - y == -1 {
                if Float(finalDragGestureValue.predictedEndTranslation.height) < -tileHeight/2 {
                    self.game.moveTile(draggedTileIdx)
                    if self.settings.sound {
                        AudioServicesPlaySystemSound(SystemSoundID(self.soundId.randomElement()!))
                    }
                    if self.settings.vibration {
                        AudioServicesPlaySystemSound(1519)
                    }
                }
            }
            self.draggedTileId = 1000
        }
    }
}



struct TileView: View {
    @EnvironmentObject var game: Game
    var tile: Tile
    
    var body: some View {
        Image(self.game.board.imageTitle + String(tile.id))
            .resizable()
            .overlay(Rectangle().stroke(lineWidth: 2).foregroundColor(Color.gray))
            .overlay(Rectangle().stroke(lineWidth: 1).foregroundColor(Color.black))
    }
}
