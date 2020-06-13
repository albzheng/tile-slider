//
//  ContentView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 5/28/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI
import Combine


struct GameView: View {
    @EnvironmentObject var game: Game
    @EnvironmentObject var albumManager: AlbumManager
    
    @State var newGame: Bool = false
    @State var winGamePublisher: AnyCancellable? = nil
    
    
    var body: some View {
        VStack(spacing: 10){
            Text(game.board.title).font(.title)
            BoardView()
                .aspectRatio(CGFloat(game.board.num_cols/game.board.num_rows), contentMode: .fit)
                .padding(.horizontal, 50)
                .alert(isPresented: self.$game.won){
                    return Alert(title: Text("Congratulations!"),
                          message: Text("You solved the puzzle! It has been added to your Collection."),
                          dismissButton: .default(Text("Done")))
                }
            Button(action: {
                self.newGame = true
                self.albumManager.addItem(item: self.game.board.imageTitle)
            }, label: {
                Text("New Game").font(.system(.body, design: .rounded))
            })
            .alert(isPresented: self.$newGame) {
                Alert(
                    title: Text("Restart Game"),
                    message: Text("Are you sure you want to restart the game?"),
                    primaryButton: .default(Text("Yes")) {withAnimation {self.game.newGame()}},
                    secondaryButton: .cancel()
                )
            }
        }
        .onAppear(perform: {
            self.winGamePublisher = self.game.$won.sink{ won in
                if won {
                    self.albumManager.addItem(item: self.game.board.imageTitle)
                }
            }
        })
    }
}



