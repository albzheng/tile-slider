//
//  MainView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/6/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var games: GameStore
    @EnvironmentObject var albumManager: AlbumManager
    @EnvironmentObject var settings: Settings
    
    @State var selection: String = "Main"
    
    var body: some View {
        return TabView(selection:$selection) {
            GameChooserView()
                .tabItem {
                    Image(systemName: "gamecontroller").font(.title)
                    Text("Puzzles")
                }
                .tag("Game Chooser")
            HomeView()
                .tabItem {
                    Image(systemName: "house").font(.title)
                    Text("Home")
                }
                .tag("Main")
            CollectionView()
                .tabItem {
                    Image(systemName: "rosette").font(.title)
                    Text("Collection")
                }
                .tag("Collection")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

