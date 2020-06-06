//
//  GameChooserView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/3/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

struct GameChooserView: View {
    @EnvironmentObject var games: GameStore
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(games.boardCollection){ board in
                    NavigationLink(destination: GameView().environmentObject(Game(board: board))
                        .navigationBarTitle(board.title)
                    ){
                        GameSelectionView(board: board)
                    }
                }
            }
            .navigationBarTitle("Game Selection")
            //.environment(\.defaultMinListRowHeight, 80)
        }
    }
}

struct GameSelectionView: View {
    var board: Board
    
    var body: some View {
        HStack{
            Image(board.imageTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80).padding()
            Text(board.title)
        }
    }
}

struct GameChooserView_Previews: PreviewProvider {
    static var previews: some View {
        let games = GameStore()
        return GameChooserView().environmentObject(games)
    }
}
