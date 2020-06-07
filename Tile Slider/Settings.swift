//
//  Settings.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/6/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI
import Combine

class Settings: ObservableObject{

    static let soundKey: String = "sound"
    static let vibrationKey: String = "vibration"
    static let userNameKey: String = "userName"
    
    var sound: Bool {
        get {
            UserDefaults.standard.object(forKey: Settings.soundKey) as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Settings.soundKey)
            objectWillChange.send()
        }
    }
    
    var vibration: Bool {
        get {
            UserDefaults.standard.object(forKey: Settings.vibrationKey) as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Settings.vibrationKey)
            objectWillChange.send()
        }
    }
    
    var userName: String {
        get {
            UserDefaults.standard.object(forKey: Settings.userNameKey) as? String ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Settings.userNameKey)
            objectWillChange.send()
        }
    }
    
}
