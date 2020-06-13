//
//  SettingsView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/10/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: Settings
    @State private var name: String = ""
    
    var body: some View {
        VStack(spacing: 0){
            Text("Settings").font(.headline).padding()
            Form {
                Section {
                    Toggle(isOn: self.$settings.sound) {
                        Text("Sound")
                    }
                    Toggle(isOn: self.$settings.vibration) {
                        Text("Vibration")
                    }
                }
                Section {
                    HStack {
                        Text("Username: ")
                        TextField("Name", text: $name, onEditingChanged: { began in
                            if !began {
                                self.settings.userName = self.name
                            }
                        })
                    }
                }
            }
        }
            .onAppear { self.name = self.settings.userName}
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
