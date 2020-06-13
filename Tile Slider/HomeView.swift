//
//  HomeView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/6/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var showSettings = false
    @EnvironmentObject var settings: Settings
    
    var body: some View{
        GeometryReader {geometry in
            ZStack() {
                Image("background").resizable().aspectRatio(contentMode: .fill).edgesIgnoringSafeArea(.all)
                
                Text("Tile Slider")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.white)
                    .background(TitleBackground())

                if geometry.size.height > geometry.size.width {
                    VStack {
                        Image(systemName: "gear")
                            .font(.system(size: 40))
                            .foregroundColor(Color.blue)
                            .offset(x: geometry.size.width/2 - 50,y:0)
                            .onTapGesture{
                                self.showSettings.toggle()
                            }
                        Spacer()
                    }.padding(.top, 30)
                } else {
                    HStack {
                        Spacer()
                        Image(systemName: "gear")
                            .font(.system(size: 40))
                            .foregroundColor(Color.blue)
                            .offset(x: 0, y: -geometry.size.height/2 + 50)
                            .onTapGesture{
                                self.showSettings.toggle()
                            }
                    }.padding(.trailing, 30)
                }
            }
        }.sheet(isPresented: $showSettings){
            SettingsView().environmentObject(self.settings)
        }
    }
}


struct TitleBackground: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).padding(EdgeInsets(top: -15, leading: -15, bottom: -15, trailing: -15)).foregroundColor(Color.white)
            RoundedRectangle(cornerRadius: 5).padding(EdgeInsets(top: -10, leading: -10, bottom: -10, trailing: -10)).foregroundColor(Color.black)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
